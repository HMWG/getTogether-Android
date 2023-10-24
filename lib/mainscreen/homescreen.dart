import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get_together_android/cards/meetingcard.dart';
import 'package:get_together_android/createmeetingscreen/meetinginfoscreen.dart';
import 'package:get_together_android/mainscreen/tabscreen.dart';

import '../createmeetingscreen/meetingdatescreen.dart';
import '../createmeetingscreen/meetingplacescreen.dart';
import '../createmeetingscreen/meetingrecommendscreen.dart';
import '../createmeetingscreen/meetingtimescreen.dart';
import 'meetingdetailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "민우";

  List<Meeting> meeting = [
    Meeting(
        0, "ourMeeting0", DateTime.now(), DateTime.now(), DateTime.now(), 0, 5),
    Meeting(
        1, "ourMeeting1", DateTime.now(), DateTime.now(), DateTime.now(), 1, 4),
    Meeting(
        2, "ourMeeting2", DateTime.now(), DateTime.now(), DateTime.now(), 2, 3),
    Meeting(
        3, "ourMeeting3", DateTime.now(), DateTime.now(), DateTime.now(), 3, 2),
    Meeting(
        4, "ourMeeting4", DateTime.now(), DateTime.now(), DateTime.now(), 4, 1),
    Meeting(
        5, "ourMeeting5", DateTime.now(), DateTime.now(), DateTime.now(), 5, 6),
    Meeting(
        6, "ourMeeting6", DateTime.now(), DateTime.now(), DateTime.now(), 6, 33)
  ];

  List<Meeting> myMeeting = [];
  /*List<Map<String, dynamic>> meeting = [
    {
      'meetingName': 'ourMeeting',
      'sd': DateTime.now(),
      'ed': DateTime.now(),
      'md': DateTime.now(),
      'status': 0,
      'member': 5
    },
    {
      'meetingName': 'ourMeeting2',
      'sd': DateTime.now(),
      'ed': DateTime.now(),
      'md': DateTime.now(),
      'status': 1,
      'member': 4
    },
    {
      'meetingName': 'ourMeeting3',
      'sd': DateTime.now(),
      'ed': DateTime.now(),
      'md': DateTime.now(),
      'status': 2,
      'member': 3
    },
    {
      'meetingName': 'ourMeeting',
      'sd': DateTime.now(),
      'ed': DateTime.now(),
      'md': DateTime.now(),
      'status': 4,
      'member': 2
    }
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "헤쳐모여",
            style: TextStyle(
                fontFamily: "yeonSung", fontSize: 25, color: Colors.green),
          ),
          centerTitle: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeetingInfoScreen()),
                  );
                },
                icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
        ),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 160,
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name + "님",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0)),
                  SizedBox(
                    height: 0.0,
                  ),
                  Text(
                    "안녕하세요 😊",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 7,
              color: Color(0xffF6F6F6),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: ContainedTabBarView(
                    tabs: [
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: Text(
                          '나의 모임',
                        ),
                      ),
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: Text(
                          '내가 만든 모임',
                        ),
                      ),
                    ],
                    views: [
                      Container(
                        color: Colors.white60,
                        child: meeting.isNotEmpty
                            ? ListView.builder(
                                itemCount: meeting.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    child: MeetingCard(
                                      meetingName: meeting[index].meetingName,
                                      sd: meeting[index].sd,
                                      ed: meeting[index].ed,
                                      md: meeting[index].md,
                                      status: meeting[index].status,
                                      member: meeting[index].member,
                                    ),
                                    onTap: () {
                                      switch (meeting[index].status) {
                                        case 0:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDateScreen()),
                                          );
                                          break;
                                        case 1:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingTimeScreen()),
                                          );
                                          break;
                                        case 2:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingPlaceScreen()),
                                          );
                                          break;
                                        case 3:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingRecommendScreen()),
                                          );
                                          break;
                                        case 4:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                        case 5:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                        case 6:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                      }
                                    },
                                  );
                                })
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name + '님이 속한 모임이 없습니다.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    Text(
                                      '모임을 만들어보세요!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingInfoScreen()),
                                          );
                                        },
                                        child: Text(
                                          '모임 만들기',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0),
                                        ))
                                  ],
                                ),
                              ),
                      ),
                      Container(
                        color: Colors.white60,
                        child: myMeeting.isNotEmpty
                            ? ListView.builder(
                                itemCount: myMeeting.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    child: MeetingCard(
                                      meetingName: myMeeting[index].meetingName,
                                      sd: myMeeting[index].sd,
                                      ed: myMeeting[index].ed,
                                      md: myMeeting[index].md,
                                      status: myMeeting[index].status,
                                      member: myMeeting[index].member,
                                    ),
                                    onTap: () {
                                      switch (meeting[index].status) {
                                        case 0:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDateScreen()),
                                          );
                                          break;
                                        case 1:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingTimeScreen()),
                                          );
                                          break;
                                        case 2:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingPlaceScreen()),
                                          );
                                          break;
                                        case 3:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingRecommendScreen()),
                                          );
                                          break;
                                        case 4:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                        case 5:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                        case 6:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetailScreen()),
                                          );
                                          break;
                                      }
                                    },
                                  );
                                })
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '내가 만든 모임이 없습니다.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    Text(
                                      '모임을 만들어보세요!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingInfoScreen()),
                                          );
                                        },
                                        child: Text(
                                          '모임 만들기',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0),
                                        ))
                                  ],
                                ),
                              ),
                      ),
                    ],
                    onChange: (index) => print(index),
                  )),
            )
          ],
        )));
  }
}

class Meeting {
  int meetingId;
  String meetingName;
  DateTime sd;
  DateTime ed;
  DateTime md;
  int status;
  int member;

  Meeting(this.meetingId, this.meetingName, this.sd, this.ed, this.md,
      this.status, this.member);
}
