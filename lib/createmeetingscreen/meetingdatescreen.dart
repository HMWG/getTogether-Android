import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingtimescreen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../cards/meetinginfocard.dart';

class MeetingDateScreen extends StatefulWidget {
  const MeetingDateScreen({super.key});

  @override
  State<MeetingDateScreen> createState() => _MeetingDateScreenState();
}

class _MeetingDateScreenState extends State<MeetingDateScreen> {
  var name = '민우';

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
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
    });
  }

  Map<DateTime, List<Event>> events = {
    DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day):
        [Event("나")],
    DateTime.utc(2023, 10, 26): [Event('임대영'), Event('이재인')],
    DateTime.utc(2023, 10, 28): [Event('황민우')],
  };

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
      body: SingleChildScrollView(
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
                    Text(name + '님',
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
                child: MeetingInfoCard(),
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
                    headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
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
                        color: Colors.red.shade200, shape: BoxShape.circle),
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
            _showCheckDateDialog(context);
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
}

class Event {
  String title;

  Event(this.title);
}

void _showCheckDateDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("입력 완료 되었습니다.\n팀원을 기다려주세요!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("수정하기")),
            TextButton(
                onPressed: () {
                  //Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeetingTimeScreen()),
                  );
                },
                child: Text("네"))
          ],
        );
      });
}
