import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_together_android/cards/meetingcard.dart';
import 'package:get_together_android/cards/meetinginfocard.dart';
import 'package:get_together_android/cards/meetingtimecard.dart';
import 'package:get_together_android/createmeetingscreen/meetingplacescreen.dart';
import 'package:intl/intl.dart';

import '../entity/meetingentity.dart';
import '../kakaologin.dart';
import '../mainpage.dart';
import '../spring.dart';

class MeetingTimeScreen extends StatefulWidget {
  int? id;
  MeetingTimeScreen({super.key, required this.id});

  @override
  State<MeetingTimeScreen> createState() => _MeetingTimeScreenState();
}

class _MeetingTimeScreenState extends State<MeetingTimeScreen> {
  bool emptyCheck = true;
  List<DateTime> getDateTime = [];
  bool isLoading = true;
  String meetingDate = "";

  var dayOfTheWeek = ['월', '화', '수'];
  var day = [11, 12, 13];
  var meetingTime = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  List<List<int>> timeList = [[], [], []];

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>();

  final Set<DateTime> _selectedDay = LinkedHashSet<DateTime>();

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
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

  Future addTime() async {
    List<DateTime> list = List.from(_selectedDays);
    if (list.isEmpty) list.add(getDateTime[0].add(Duration(hours: 12)));
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
      addMeetingTime(MeetingDate(
          memberId: userInfo.id, meetingId: widget.id, date: list[i]));
    }
  }

  Future initMeetingDate() async {
    emptyCheck = await emptyMeetingTime(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
    getDateTime = await getMeetingFinalDate(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  }

  @override
  void initState() {
    super.initState();
    initMeetingDate().then((_) {
      setState(() {
        meetingDate = DateFormat('yyyy년', 'ko').format(getDateTime.first);
        isLoading = false;
        if (!emptyCheck) showCheckTimeDialog(context, widget.id!);
      });
    });
  }

  var btnColor = [
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ],
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ],
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ]
  ];
  var btnSave = [
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ],
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ],
    [
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50],
      Colors.blue[50]
    ]
  ];

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
              child: Column(children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('모임이 가능한 시간을',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0)),
                      SizedBox(
                        height: 0.0,
                      ),
                      Text('추가해주세요',
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Text(
                              meetingDate,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 80,
                                      child: Text(
                                        DateFormat('E', 'ko')
                                            .format(getDateTime[0]),
                                        textAlign: TextAlign.center,
                                      )),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      DateFormat('M월 d일', 'ko')
                                          .format(getDateTime[0]),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 80,
                                      child: Text(
                                        DateFormat('E', 'ko')
                                            .format(getDateTime[1]),
                                        textAlign: TextAlign.center,
                                      )),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      DateFormat('M월 d일', 'ko')
                                          .format(getDateTime[1]),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 80,
                                      child: Text(
                                        DateFormat('E', 'ko')
                                            .format(getDateTime[2]),
                                        textAlign: TextAlign.center,
                                      )),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      DateFormat('M월 d일', 'ko')
                                          .format(getDateTime[2]),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    for (num i = 0; i < 4; i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '오전 ' + (i + 8).toString() + '시',
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        '오후 ' + (12).toString() + '시',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    for (num i = 5; i < 13; i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '오후 ' + (i - 4).toString() + '시',
                                          textAlign: TextAlign.right,
                                        ),
                                      )
                                  ],
                                ),
                                Column(
                                  children: [
                                    for (var i = 0; i < meetingTime.length; i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 3),
                                        child: InkWell(
                                            onTap: () {
                                              timeList[0]
                                                      .contains(meetingTime[i])
                                                  ? timeList[0]
                                                      .remove(meetingTime[i])
                                                  : timeList[0]
                                                      .add(meetingTime[i]);
                                              setState(() {
                                                timeList[0].contains(
                                                        meetingTime[i])
                                                    ? btnColor[0][i] =
                                                        Colors.lightGreen[300]
                                                    : btnColor[0][i] =
                                                        btnSave[1][i];
                                              });
                                              _onDaySelected(getDateTime[0].add(
                                                  Duration(
                                                      hours: meetingTime[i])));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: btnColor[0][i],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 34,
                                              width: 80,
                                              child: Text(""),
                                            )),
                                      )
                                  ],
                                ),
                                Column(
                                  children: [
                                    for (var i = 0; i < meetingTime.length; i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 3),
                                        child: InkWell(
                                            onTap: () {
                                              timeList[1]
                                                      .contains(meetingTime[i])
                                                  ? timeList[1]
                                                      .remove(meetingTime[i])
                                                  : timeList[1]
                                                      .add(meetingTime[i]);
                                              setState(() {
                                                timeList[1].contains(
                                                        meetingTime[i])
                                                    ? btnColor[1][i] =
                                                        Colors.lightGreen[300]
                                                    : btnColor[1][i] =
                                                        btnSave[1][i];
                                              });
                                              _onDaySelected(getDateTime[1].add(
                                                  Duration(
                                                      hours: meetingTime[i])));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: btnColor[1][i],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 34,
                                              width: 80,
                                              child: Text(""),
                                            )),
                                      )
                                  ],
                                ),
                                Column(
                                  children: [
                                    for (var i = 0; i < meetingTime.length; i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 3),
                                        child: InkWell(
                                            onTap: () {
                                              timeList[2]
                                                      .contains(meetingTime[i])
                                                  ? timeList[2]
                                                      .remove(meetingTime[i])
                                                  : timeList[2]
                                                      .add(meetingTime[i]);
                                              setState(() {
                                                timeList[2].contains(
                                                        meetingTime[i])
                                                    ? btnColor[2][i] =
                                                        Colors.lightGreen[300]
                                                    : btnColor[2][i] =
                                                        btnSave[1][i];
                                              });
                                              _onDaySelected(getDateTime[2].add(
                                                  Duration(
                                                      hours: meetingTime[i])));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: btnColor[2][i],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 34,
                                              width: 80,
                                              child: Text(""),
                                            )),
                                      )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            addTime().then((value) async {
              if (await checkMeetingTime(
                  LeaveMeeting(memberId: userInfo.id, meetingId: widget.id))) {
                Get.offAll(MainPage());
                Fluttertoast.showToast(msg: "모든 사람이 시간을 입력했습니다");
              } else {
                showCheckTimeDialog(context, widget.id!);
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

  void showCheckTimeDialog(BuildContext context, int meetingId) {
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
                    deleteMeetingTime(LeaveMeeting(
                            memberId: userInfo.id, meetingId: meetingId))
                        .then((value) {
                      Get.back();
                      Get.off(MeetingTimeScreen(id: meetingId));
                    });
                  },
                  child: Text("수정하기")),
              TextButton(
                  onPressed: () {
                    Get.offAll(MainPage());
                  },
                  child: Text("네"))
            ],
          );
        });
  }
}
