import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_together_android/entity/noticeentity.dart';
import 'package:get_together_android/kakaologin.dart';
import 'package:get_together_android/spring.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../entity/meetingentity.dart';

class MeetingCard extends StatefulWidget {
  int? id;
  String? name;
  String? place;
  String? description;
  DateTime? start;
  DateTime? end;
  MeetingType? meetingType;
  bool? done;
  int? createdBy;
  int? count;
  MeetingCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.place,
      required this.description,
      required this.start,
      required this.end,
      required this.meetingType,
      required this.done,
      required this.createdBy,
      required this.count})
      : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

var meetingStatus = [
  '날짜 설정중',
  '시간 설정중',
  '장소 설정중',
  '최종 장소 설정중',
  '모임 대기중',
  '모임 진행중',
  '모임 종료'
];

class _MeetingCardState extends State<MeetingCard> {
  int status = 0;
  bool creator = false;
  var sd = DateTime.now();
  var ed = DateTime.now();
  bool isDate = false;
  late SelectedUsers? users;
  List<String?> pickedId = [];

  Future picked(BuildContext context) async {
    users = await kakaoPicker(context);
  }

  @override
  void initState() {
    switch (widget.meetingType) {
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
    if (widget.createdBy == userInfo.id) {
      creator = true;
    }
    // if(widget.start == null){
    //   isDate = false;
    // }
    // else{
    //   isDate = true;
    //   sd = widget.start!;
    //   ed = widget.end!;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 230,
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
                          Container(
                              alignment: Alignment.centerRight,
                              child: _checkCreatorButton(creator, widget.id)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.name!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                widget.start == null
                    ? Text("날짜 미정")
                    : Text(DateFormat('M월 d일 E요일', 'ko').format(widget.start!))
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
                widget.start == null
                    ? Text("시간 미정")
                    : Text(DateFormat('aa hh:mm', 'ko').format(widget.start!) +
                        " ~ " +
                        DateFormat('aa hh:mm', 'ko').format(widget.end!))
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
                Text(widget.count.toString() + '명')
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color _statusColor(status) {
  Color c = Colors.red;
  if (status == 5)
    c = Colors.lightBlue;
  else if (status == 6)
    c = Colors.black45;
  else if (status == 4) c = Colors.lightGreen;
  return c;
}

PopupMenuButton _checkCreatorButton(creator, meetingId) {
  PopupMenuButton p = PopupMenuButton(itemBuilder: (context) {
    return [
      PopupMenuItem(
        child: Text('모임 종료'),
        onTap: () {
          print('종료 선택');
        },
      ),
      PopupMenuItem(
        child: Text('모임 수정'),
        onTap: () {
          print('수정 선택');
        },
      ),
      PopupMenuItem(
        child: Text('삭제'),
        onTap: () {
          deleteMeeting(MeetingId(id: meetingId));
          print('삭제 선택');
        },
      ),
    ];
  });

  if (creator == false) {
    p = PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Text('모임 나가기'),
          onTap: () {
            leaveMeeting(
                LeaveMeeting(memberId: userInfo.id, meetingId: meetingId));
            print('나가기 선택');
          },
        ),
      ];
    });
  }
  return p;
}

Row checkCreatorStatus(creator, status) {
  Row r = Row(
    children: [
      Container(
        child: Text(
          meetingStatus[status],
          style: TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.left,
        ),
        decoration: BoxDecoration(
            color: _statusColor(status),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(3),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        child: Text(
          "내가 만든 모임",
          style: TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.left,
        ),
        decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(3),
      ),
    ],
  );

  if (!creator) {
    r = Row(
      children: [
        Container(
          child: Text(
            meetingStatus[status],
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.left,
          ),
          decoration: BoxDecoration(
              color: _statusColor(status),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(3),
        ),
      ],
    );
  }

  return r;
}
