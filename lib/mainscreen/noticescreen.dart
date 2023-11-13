import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_together_android/cards/noticecard.dart';
import 'package:get_together_android/entity/noticeentity.dart';
import 'package:get_together_android/mainscreen/meetingdetailscreen.dart';
import 'package:get_together_android/spring.dart';

import '../kakaologin.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

// List<Notice> notice = [
//   Notice("ourMeeting1", "황민우", true),
//   Notice("코딩을하자", "장경우", true),
//   Notice("ourMeeting3", "임대영", true),
//   Notice("집가자", "이재인", true),
// ];

class _NoticeScreenState extends State<NoticeScreen> {
  var myNotices = [];
  var num = 5;
  bool isLoading = true;

  Future initNotices() async {
    myNotices = await myNotice(userInfo.id);
  }

  @override
  void initState() {
    checkSignInWithKakao(context);
    super.initState();
    initNotices().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "알림",
          style: TextStyle(
              fontFamily: "yeonSung", fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('알림 지우기'),
                    onTap: () {
                      isLoading = true;
                      setState(() {
                        clearNotice(userInfo.id).then((_) {
                          initNotices().then((_) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        });
                      });
                      print('알림 지우기 선택');
                      setState(() {});
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
          : myNotices.isEmpty
              ? Center(
                  child: Text(
                    userInfo.name + '님의 알림이 없습니다.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: myNotices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    myNotices[index].isView = false;
                                    viewNotice(
                                        NoticeId(id: myNotices[index].id));
                                    _showCheckPlaceDialog(
                                        context,
                                        myNotices[index].meetingName,
                                        myNotices[index].id,
                                        userInfo.id);
                                  },
                                  child: NoticeCard(
                                    meetingName: myNotices[index].meetingName,
                                    inviter: myNotices[index].invitor,
                                    isView: myNotices[index].isView,
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
    );
  }
}

void _showCheckPlaceDialog(BuildContext context, meetingName, id, member) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text(meetingName + "\n모임 가입을 수락하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("아니요")),
            TextButton(
                onPressed: () {
                  acceptNotice(
                      AcceptNotice(id: id, member: member), meetingName, id);
                },
                child: Text("네"))
          ],
        );
      });
}
