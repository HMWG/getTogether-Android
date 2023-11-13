import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_together_android/cards/meetingcard.dart';
import 'package:get_together_android/createmeetingscreen/meetinginfoscreen.dart';
import 'package:get_together_android/mainscreen/tabscreen.dart';
import 'package:get_together_android/spring.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:get_together_android/entity/meetingentity.dart';

import '../createmeetingscreen/meetingdatescreen.dart';
import '../createmeetingscreen/meetingplacescreen.dart';
import '../createmeetingscreen/meetingrecommendscreen.dart';
import '../createmeetingscreen/meetingtimescreen.dart';
import '../kakaologin.dart';
import '../mainpage.dart';
import 'meetingdetailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var meetingList = [];
  List<Meeting> myMeeting = [];
  List<Meeting> meeting = [];
  bool isLoading = true;

  Future initMeetings() async {
    meetingList = await myMeetings(userInfo.id);
  }

  @override
  void initState() {
    checkSignInWithKakao(context);
    super.initState();
    initMeetings().then((_) {
      setState(() {
        isLoading = false;
        meeting.addAll(meetingList[0]);
        myMeeting.addAll(meetingList[1]);
      });
    });
  }

  // List<Meeting> meeting = [
  //   Meeting(0, "ourMeeting0", DateTime.now(), DateTime.now(), DateTime.now(), 0,
  //       5, true),
  //   Meeting(1, "ourMeeting1", DateTime.now(), DateTime.now(), DateTime.now(), 1,
  //       4, false),
  //   Meeting(2, "ourMeeting2", DateTime.now(), DateTime.now(), DateTime.now(), 2,
  //       3, true),
  //   Meeting(3, "ourMeeting3", DateTime.now(), DateTime.now(), DateTime.now(), 3,
  //       2, false),
  //   Meeting(4, "ourMeeting4", DateTime.now(), DateTime.now(), DateTime.now(), 4,
  //       1, true),
  //   Meeting(5, "ourMeeting5", DateTime.now(), DateTime.now(), DateTime.now(), 5,
  //       6, false),
  //   Meeting(6, "ourMeeting6", DateTime.now(), DateTime.now(), DateTime.now(), 6,
  //       33, false)
  // ];

  //List<Meeting> meeting = [];
  // List<Meeting> myMeeting = [];
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
                Get.to(() => MeetingInfoScreen());
              },
              icon: Icon(Icons.add)),
          PopupMenuButton(
              icon: Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('로그아웃'),
                    onTap: () {
                      _showCheckLogout(context);
                    },
                  ),
                ];
              })
        ],
      ),
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Container(
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
                      Text(userInfo.name + "님",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0)),
                      SizedBox(
                        height: 0.0,
                      ),
                      meeting.isNotEmpty && myMeeting.isNotEmpty
                          ? Text(
                              "안녕하세요 😊",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            )
                          : !isLoading
                              ? Text(
                                  "모임을 만들어보세요 😊",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0),
                                )
                              : Text(
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: MeetingCard(
                                            id: meeting[index].id,
                                            name: meeting[index].name,
                                            place: meeting[index].place,
                                            description:
                                                meeting[index].description,
                                            start: meeting[index].start,
                                            end: meeting[index].end,
                                            meetingType:
                                                meeting[index].meetingType,
                                            done: meeting[index].done,
                                            createdBy: meeting[index].createdBy,
                                            count: meeting[index].count),
                                        onTap: () {
                                          switch (meeting[index].meetingType) {
                                            case MeetingType.date:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingDateScreen(
                                                          id: meeting[index].id,
                                                        )),
                                              );
                                              break;
                                            case MeetingType.time:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingTimeScreen(
                                                          id: meeting[index].id,
                                                        )),
                                              );
                                              break;
                                            case MeetingType.place:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingPlaceScreen(
                                                          id: meeting[index].id,
                                                        )),
                                              );
                                              break;
                                            case MeetingType.finalPlace:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingRecommendScreen(
                                                          id: meeting[index].id,
                                                        )),
                                              );
                                              break;
                                            case MeetingType.toDo:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingDetailScreen(
                                                          id: meeting[index].id,
                                                        )),
                                              );
                                              break;
                                            case MeetingType.inProgress:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingDetailScreen(
                                                            id: meeting[index]
                                                                .id)),
                                              );
                                              break;
                                            case MeetingType.close:
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeetingDetailScreen(
                                                            id: meeting[index]
                                                                .id)),
                                              );
                                              break;
                                          }
                                        },
                                      );
                                    })
                                : Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userInfo.name + '님이 속한 모임이 없습니다.',
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          child: MeetingCard(
                                              id: myMeeting[index].id,
                                              name: myMeeting[index].name,
                                              place: myMeeting[index].place,
                                              description:
                                                  myMeeting[index].description,
                                              start: myMeeting[index].start,
                                              end: myMeeting[index].end,
                                              meetingType:
                                                  myMeeting[index].meetingType,
                                              done: myMeeting[index].done,
                                              createdBy:
                                                  myMeeting[index].createdBy,
                                              count: myMeeting[index].count),
                                          onTap: () {
                                            switch (
                                                myMeeting[index].meetingType) {
                                              case MeetingType.date:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingDateScreen(
                                                            id: myMeeting[index]
                                                                .id,
                                                          )),
                                                );
                                                break;
                                              case MeetingType.time:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingTimeScreen(
                                                            id: myMeeting[index]
                                                                .id,
                                                          )),
                                                );
                                                break;
                                              case MeetingType.place:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingPlaceScreen(
                                                            id: myMeeting[index]
                                                                .id,
                                                          )),
                                                );
                                                break;
                                              case MeetingType.finalPlace:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingRecommendScreen(
                                                            id: myMeeting[index]
                                                                .id,
                                                          )),
                                                );
                                                break;
                                              case MeetingType.toDo:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingDetailScreen(
                                                            id: myMeeting[index]
                                                                .id,
                                                          )),
                                                );
                                                break;
                                              case MeetingType.inProgress:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingDetailScreen(
                                                              id: myMeeting[
                                                                      index]
                                                                  .id)),
                                                );
                                                break;
                                              case MeetingType.close:
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingDetailScreen(
                                                              id: myMeeting[
                                                                      index]
                                                                  .id)),
                                                );
                                                break;
                                            }
                                          });
                                    })
                                : Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAll(MainPage());
        },
        tooltip: 'refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
//
// class Meeting {
//   int meetingId;
//   String meetingName;
//   DateTime sd;
//   DateTime ed;
//   DateTime md;
//   int status;
//   int member;
//   bool creator;
//
//   Meeting(this.meetingId, this.meetingName, this.sd, this.ed, this.md,
//       this.status, this.member, this.creator);
// }

void _showCheckLogout(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("로그아웃 하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("아니요")),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await logout();
                  await checkSignInWithKakao(context);
                },
                child: Text("네"))
          ],
        );
      });
}

void _getUserInfo(name) async {
  try {
    User user = await UserApi.instance.me();
    print(
        'asd사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile?.nickname}');
    name = "${user.kakaoAccount?.profile?.nickname}";
  } catch (error) {
    print('사용자 정보 요청 실패: $error');
    name = "알수없음";
  }
}
