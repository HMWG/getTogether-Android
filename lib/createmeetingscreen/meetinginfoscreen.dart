import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_together_android/createmeetingscreen/meetingdatescreen.dart';
import 'package:get_together_android/entity/meetingentity.dart';
import 'package:get_together_android/mainscreen/homescreen.dart';
import 'package:get_together_android/spring.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../kakaologin.dart';
import '../mainpage.dart';

class MeetingInfoScreen extends StatefulWidget {
  const MeetingInfoScreen({super.key});

  @override
  State<MeetingInfoScreen> createState() => _MeetingInfoScreenState();
}

class _MeetingInfoScreenState extends State<MeetingInfoScreen> {
  TextEditingController meetingName = TextEditingController();
  TextEditingController meetingDes = TextEditingController();
  TextEditingController meetingPlace = TextEditingController();

  var startTime;
  var endTime;
  var meetingDate;
  DateTime? startDateTime;
  DateTime? endDateTime;
  TimeOfDay st = TimeOfDay.now();
  bool checkDate = false;
  bool checkTime = false;
  bool isNeed = true;
  bool isNext = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isNeed, isNext];
    var now = TimeOfDay.now();

    startTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
    endTime = DateFormat('aa hh:mm', 'ko')
        .format(DateTime.now().add(Duration(hours: 1)));
    meetingDate = DateFormat("yyyy년 MM월 dd일", 'ko').format(DateTime.now());

    super.initState();
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
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(40, 60, 0, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('모임 정보를 입력해주세요',
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
              SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                height: 7,
                color: Color(0xffF6F6F6),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 이름',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: meetingName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '모임 이름을 입력해주세요',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 설명 (선택사항)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: meetingDes,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '모임 설명을 입력해주세요',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 날짜',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '모임 날짜',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  !checkDate ? "미정" : meetingDate,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Future<DateTime?> selectedDate = showDatePicker(
                                context:
                                    context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0),
                                lastDate: DateTime(20000),
                                // 프로퍼티에 초깃값을 지정합니다.
                              );
                              selectedDate.then((value) {
                                setState(() {
                                  DateTime start;
                                  if (value != null)
                                    start = DateTime(
                                        value.year, value.month, value.day);
                                  else
                                    start = DateTime.now();
                                  meetingDate = DateFormat(
                                          "yyyy년 MM월 dd일", 'ko')
                                      .format(DateTime(
                                          start.year, start.month, start.day));
                                  startDateTime = DateTime(
                                      start.year, start.month, start.day);
                                  endDateTime = DateTime(
                                      start.year, start.month, start.day);
                                  checkDate = true;
                                });
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: checkDate,
                      child: Column(
                        children: [
                          Column(children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '모임 시간',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '시작 시간',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          !checkTime ? "미정" : startTime,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' 부터 ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Future<TimeOfDay?> selectedTime =
                                          showTimePicker(
                                        context:
                                            context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                                        initialTime: TimeOfDay
                                            .now(), // 프로퍼티에 초깃값을 지정합니다.
                                      );
                                      selectedTime.then((value) {
                                        setState(() {
                                          DateTime start;
                                          if (value != null)
                                            start = DateTime(0, 0, 0,
                                                value.hour, value.minute);
                                          else
                                            start = DateTime.now();
                                          startTime =
                                              DateFormat('aa hh:mm', 'ko')
                                                  .format(DateTime(
                                                      0,
                                                      0,
                                                      0,
                                                      start.hour,
                                                      start.minute));
                                          startDateTime = startDateTime?.add(
                                              Duration(
                                                  hours: start.hour,
                                                  minutes: start.minute));
                                          st = TimeOfDay(
                                              hour: start.hour,
                                              minute: start.minute);
                                          checkTime = true;
                                        });
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.grey, width: 1),
                                      right: BorderSide(
                                          color: Colors.grey, width: 1),
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 1),
                                      top: BorderSide(
                                          color: Colors.grey, width: 1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '종료 시간',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          !checkTime ? "미정" : endTime,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' 까지 ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Future<TimeOfDay?> selectedTime =
                                          showTimePicker(
                                              context:
                                                  context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                                              initialTime:
                                                  st // 프로퍼티에 초깃값을 지정합니다.
                                              );
                                      selectedTime.then((value) {
                                        setState(() {
                                          DateTime end;
                                          if (value != null)
                                            end = DateTime(0, 0, 0, value.hour,
                                                value.minute);
                                          else
                                            end = DateTime.now();
                                          endTime = DateFormat('aa hh:mm', 'ko')
                                              .format(DateTime(0, 0, 0,
                                                  end.hour, end.minute));
                                          endDateTime = endDateTime?.add(
                                              Duration(
                                                  hours: end.hour,
                                                  minutes: end.minute));
                                          checkTime = true;
                                        });
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '중간장소 추천',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ToggleButtons(
                      color: Colors.black.withOpacity(0.60),
                      selectedColor: Colors.lightGreen,
                      selectedBorderColor: Colors.lightGreen,
                      fillColor: Colors.lightGreen.withOpacity(0.08),
                      splashColor: Colors.lightGreen.withOpacity(0.12),
                      hoverColor: Colors.lightGreen.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(4.0),
                      constraints: BoxConstraints(minHeight: 36.0),
                      isSelected: isSelected,
                      onPressed: toggleSelect,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '필요해요',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '다음에 받을래요',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: isNext,
                      child: TextField(
                        controller: meetingPlace,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '장소를 입력해주세요 (생략 가능)',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
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
            createMeeting(Meeting(
                id: null,
                name: meetingName.text,
                place: isNeed ? null : meetingPlace.text,
                description: meetingDes.text != "" ? meetingDes.text : null,
                start: startDateTime != null ? startDateTime : null,
                end: endDateTime != null ? endDateTime : null,
                meetingType: MeetingType.toDo,
                done: false,
                createdBy: userInfo.id,
                count: null,
                checkTime: checkTime));
            Get.offAll(MainPage());
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

  void toggleSelect(value) {
    if (value == 0) {
      isNeed = true;
      isNext = false;
    } else {
      isNeed = false;
      isNext = true;
    }
    setState(() {
      isSelected = [isNeed, isNext];
    });
  }
}
