import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingtimescreen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
      body: Padding(
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
                  selectedDecoration: const BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                ),
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
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeetingTimeScreen()),
            );
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
