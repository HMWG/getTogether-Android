import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../entity/noticeentity.dart';
import '../kakaologin.dart';
import '../spring.dart';

class MeetingInfoCard extends StatefulWidget {
  int? id;
  MeetingInfoCard({super.key, required this.id});

  @override
  State<MeetingInfoCard> createState() => _MeetingInfoCardState();
}

class _MeetingInfoCardState extends State<MeetingInfoCard> {
  var meeting;
  bool creator = false;
  bool isDate = false;
  bool isLoading = true;
  late SelectedUsers? users;
  List<String?> pickedId = [];

  Future picked(BuildContext context) async {
    users = await kakaoPicker(context);
  }

  Future initMeeting() async {
    meeting = await myMeeting(widget.id);
  }

  @override
  void initState() {
    super.initState();
    initMeeting().then((_) {
      setState(() {
        isLoading = false;
        if (meeting.createdBy == userInfo.id) {
          creator = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: const CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    creator
                        ? Container(
                            child: Text(
                              "내가 만든 모임",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.left,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.all(3),
                          )
                        : Container(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            picked(context).then((_) {
                              for (int i = 0; i < users!.users!.length; i++) {
                                print("아이디 ${i} : " + users!.users![i].id!);
                                InviteNotice notice = InviteNotice(
                                    meeting: widget.id,
                                    member: int.parse(users!.users![i].id!),
                                    invitor: userInfo.id);
                                inviteMember(notice);
                              }
                              Fluttertoast.showToast(msg: "초대를 완료하였습니다");
                            });
                          },
                          icon: Icon(Icons.share),
                        ),
                        // Container(
                        //     alignment: Alignment.centerRight,
                        //     child: PopupMenuButton(itemBuilder: (context) {
                        //       return [
                        //         PopupMenuItem(
                        //           child: Text('모임 수정'),
                        //           onTap: () {
                        //             print('삭제 선택');
                        //           },
                        //         ),
                        //         PopupMenuItem(
                        //           child: Text('삭제'),
                        //           onTap: () {
                        //             print('삭제 선택');
                        //           },
                        //         ),
                        //       ];
                        //     })),
                      ],
                    ),
                  ],
                ),
                Text(
                  meeting.name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                meeting.description != null
                    ? Text(
                        meeting.description!,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      )
                    : Container()
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
  }
}
