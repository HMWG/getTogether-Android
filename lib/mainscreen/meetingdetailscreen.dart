import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_together_android/entity/meetingentity.dart';
import 'package:get_together_android/spring.dart';
import 'package:intl/intl.dart';

import '../cards/meetingcard.dart';
import '../kakaologin.dart';

class MeetingDetailScreen extends StatefulWidget {
  int? id;
  MeetingDetailScreen({super.key, required this.id});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  var meeting;
  int status = 0;
  bool creator = false;
  var sd = DateTime.now();
  var ed = DateTime.now();
  bool isDate = false;
  bool isLoading = true;

  Future initMeeting() async {
    meeting = await myMeeting(widget.id);
  }

  @override
  void initState() {
    super.initState();
    initMeeting().then((_) {
      setState(() {
        isLoading = false;
        switch (meeting.meetingType) {
          case MeetingType.date:
            status = 0;
            break;
          case MeetingType.time:
            status = 1;
            break;
          case MeetingType.place:
            status = 2;
            break;
          case MeetingType.finalPlace:
            status = 3;
            break;
          case MeetingType.toDo:
            status = 4;
            break;
          case MeetingType.inProgress:
            status = 5;
            break;
          case MeetingType.close:
            status = 6;
            break;
        }
        if (meeting.createdBy == userInfo.id) {
          creator = true;
        }
      });
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
        body: Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('모임 상세 페이지 ' + widget.id.toString(),
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
          isLoading
              ? Center(
                  child: const CircularProgressIndicator(),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade50,
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                checkCreatorStatus(creator, status),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  meeting.name!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: Color(0xffF6F6F6),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            width: 20,
                          ),
                          meeting.start == null
                              ? Text("날짜 미정")
                              : Text(DateFormat('M월 d일 E요일', 'ko')
                                  .format(meeting.start!))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(
                            width: 20,
                          ),
                          meeting.start == null
                              ? Text("날짜 미정")
                              : Text(DateFormat('aa hh:mm', 'ko')
                                      .format(meeting.start!) +
                                  " ~ " +
                                  DateFormat('aa hh:mm', 'ko')
                                      .format(meeting.end!))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.person_outline),
                          SizedBox(
                            width: 20,
                          ),
                          Text(meeting.count.toString() + '명')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.place),
                          SizedBox(
                            width: 20,
                          ),
                          Text(meeting.place == null
                              ? Text("장소 미정")
                              : meeting.place)
                        ],
                      )
                    ],
                  ),
                )
        ]));
  }
}
