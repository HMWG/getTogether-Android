import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_together_android/createmeetingscreen/meetingtimescreen.dart';
import 'package:get_together_android/entity/meetingentity.dart';
import 'package:get_together_android/kakaologin.dart';
import 'package:get_together_android/spring.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../cards/meetinginfocard.dart';
import '../mainpage.dart';

class MeetingDateScreen extends StatefulWidget {
  int? id;
  MeetingDateScreen({super.key, required this.id});

  @override
  State<MeetingDateScreen> createState() => _MeetingDateScreenState();
}

class _MeetingDateScreenState extends State<MeetingDateScreen> {
  bool emptyCheck = true;
  List<DateTime> getDateTime = [];
  bool isLoading = true;

  Future initMeetingDate() async {
    emptyCheck = await emptyMeetingDate(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
    getDateTime = await getMeetingDate(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  }

  Future addDate() async {
    List<DateTime> list = List.from(_selectedDay);
    list.add(DateTime(2023, 1, 1));
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
      addMeetingDate(MeetingDate(
          memberId: userInfo.id, meetingId: widget.id, date: list[i]));
    }
  }

  @override
  void initState() {
    super.initState();
    initMeetingDate().then((_) {
      setState(() {
        for (DateTime dateTime in getDateTime) {
          events[DateTime.utc(dateTime.year, dateTime.month, dateTime.day)] = [
            Event('')
          ];
        }
        print(events);
        isLoading = false;
        if (!emptyCheck) _showCheckDateDialog(context, widget.id!);
      });
    });
  }

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );

  final Set<DateTime> _selectedDay = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
      if (_selectedDay
          .contains(selectedDay.subtract(Duration(hours: 9)).toLocal())) {
        _selectedDay.remove(selectedDay.subtract(Duration(hours: 9)).toLocal());
      } else {
        _selectedDay.add(selectedDay.subtract(Duration(hours: 9)).toLocal());
      }
    });
  }

  Map<DateTime, List<Event>> events = {};

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "헤쳐모여",
          style: TextStyle(
              fontFamily: "yeonSung", fontSize: 25, color: Colors.green),
        ),
        centerTitle: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userInfo.name + '님',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                          SizedBox(
                            height: 0.0,
                          ),
                          Text('모임이 불가능한',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                          SizedBox(
                            height: 0.0,
                          ),
                          Text('날짜를 골라주세요',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                          SizedBox(
                            height: 0.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 7,
                      color: Color(0xffF6F6F6),
                    ),
                    Container(
                      child: MeetingInfoCard(
                        id: widget.id,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 7,
                      color: Colors.blueGrey[50],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TableCalendar(
                        locale: 'ko_KR',
                        focusedDay: _focusedDay,
                        firstDay: DateTime(1800),
                        lastDay: DateTime(3000),
                        daysOfWeekHeight: 20,
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          //titleTextFormatter: (date, locale) =>
                          //    DateFormat.yMMMMd(locale).format(date),
                          formatButtonVisible: false,
                          titleTextStyle: const TextStyle(
                            fontSize: 20.0,
                          ),
                          headerPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          leftChevronIcon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 30.0,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 30.0,
                          ),
                        ),
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          // Use values from Set to mark multiple days as selected
                          return _selectedDays.contains(day);
                        },
                        onDaySelected: _onDaySelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        calendarStyle: CalendarStyle(
                          selectedTextStyle: const TextStyle(
                            color: const Color(0xFFFAFAFA),
                            fontSize: 16.0,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.red[300],
                            shape: BoxShape.circle,
                          ),
                          markerSize: 10.0,
                          markerDecoration: BoxDecoration(
                              color: Colors.red.shade200,
                              shape: BoxShape.circle),
                        ),
                        eventLoader: _getEventsForDay,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text(
                        '초기화',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedDays.clear();
                          //_selectedEvents.value = [];
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            // List<DateTime> list = List.from(_selectedDay);
            // list.add(DateTime(0));
            // for (int i = 0; i < _selectedDays.length; i++) {
            //   print(list[i]);
            //   addMeetingDate(MeetingDate(
            //       memberId: userInfo.id, meetingId: widget.id, date: list[i]));
            // }
            addDate().then((value) async {
              if (await checkMeetingDate(
                  LeaveMeeting(memberId: userInfo.id, meetingId: widget.id))) {
                Get.offAll(MainPage());
                Fluttertoast.showToast(msg: "모든 사람이 날짜를 입력했습니다");
              } else {
                _showCheckDateDialog(context, widget.id!);
              }
            });
          },
          child: Text(
            '입력 완료',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showCheckDateDialog(BuildContext context, int meetingId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("입력 완료 되었습니다.\n팀원을 기다려주세요!"),
            actions: [
              TextButton(
                  onPressed: () {
                    isLoading = true;
                    deleteMeetingDate(LeaveMeeting(
                            memberId: userInfo.id, meetingId: meetingId))
                        .then((value) {
                      Get.back();
                      Get.off(MeetingDateScreen(id: meetingId));
                    });
                  },
                  child: Text("수정하기")),
              TextButton(
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => MeetingTimeScreen()),
                    // );
                    Get.offAll(MainPage());
                  },
                  child: Text("네"))
            ],
          );
        });
  }
}

class Event {
  String title;

  Event(this.title);
}
