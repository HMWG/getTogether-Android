import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../createmeetingscreen/meetingtimescreen.dart';
import '../entity/meetingentity.dart';
import '../kakaologin.dart';
import '../spring.dart';

class MeetingTimeCard extends StatefulWidget {
  const MeetingTimeCard({super.key});

  @override
  State<MeetingTimeCard> createState() => _MeetingTimeCardState();
}

class _MeetingTimeCardState extends State<MeetingTimeCard> {
  bool emptyCheck = true;
  List<DateTime> getDateTime = [];
  bool isLoading = true;
  String meetingDate = "";

  // Future initMeetingDate() async {
  //   emptyCheck = await emptyMeetingTime(
  //       LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  //   getDateTime = await getMeetingFinalDate(
  //       LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initMeetingDate().then((_) {
  //     setState(() {
  //       meetingDate = DateFormat('yyyy년', 'ko').format(getDateTime.first);
  //       isLoading = false;
  //       if (!emptyCheck) showCheckTimeDialog(context, widget.id!);
  //     });
  //   });
  // }

  var dayOfTheWeek = ['월', '화', '수'];
  var day = [11, 12, 13];
  var meetingTime = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  List<List<int>> timeList = [[], [], []];
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  meetingDate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            dayOfTheWeek[0],
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        width: 80,
                        child: Text(
                          day[0].toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                            dayOfTheWeek[1],
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        width: 80,
                        child: Text(
                          day[1].toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                            dayOfTheWeek[2],
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        width: 80,
                        child: Text(
                          day[2].toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '오전 ' + (i + 8).toString() + '시',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '오후 ' + (12).toString() + '시',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        for (num i = 5; i < 13; i++)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
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
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: InkWell(
                                onTap: () {
                                  timeList[0].contains(meetingTime[i])
                                      ? timeList[0].remove(meetingTime[i])
                                      : timeList[0].add(meetingTime[i]);
                                  setState(() {
                                    timeList[0].contains(meetingTime[i])
                                        ? btnColor[0][i] =
                                            Colors.lightGreen[300]
                                        : btnColor[0][i] = btnSave[1][i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: btnColor[0][i],
                                      borderRadius: BorderRadius.circular(5)),
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
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: InkWell(
                                onTap: () {
                                  timeList[1].contains(meetingTime[i])
                                      ? timeList[1].remove(meetingTime[i])
                                      : timeList[1].add(meetingTime[i]);
                                  setState(() {
                                    timeList[1].contains(meetingTime[i])
                                        ? btnColor[1][i] =
                                            Colors.lightGreen[300]
                                        : btnColor[1][i] = btnSave[1][i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: btnColor[1][i],
                                      borderRadius: BorderRadius.circular(5)),
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
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: InkWell(
                                onTap: () {
                                  timeList[2].contains(meetingTime[i])
                                      ? timeList[2].remove(meetingTime[i])
                                      : timeList[2].add(meetingTime[i]);
                                  setState(() {
                                    timeList[2].contains(meetingTime[i])
                                        ? btnColor[2][i] =
                                            Colors.lightGreen[300]
                                        : btnColor[2][i] = btnSave[1][i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: btnColor[2][i],
                                      borderRadius: BorderRadius.circular(5)),
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
    );
  }
}
