import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingCard extends StatefulWidget {
  String meetingName;
  DateTime sd;
  DateTime ed;
  DateTime md;
  int status;
  int member;
  MeetingCard(
      {Key? key,
      required this.meetingName,
      required this.sd,
      required this.ed,
      required this.md,
      required this.status,
      required this.member})
      : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
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

class _MeetingCardState extends State<MeetingCard> {
  //var meetingName = 'Ourmeeting 회의';
  //DateFormat dateFormat = DateFormat('aa hh:mm','ko');
  //var d = DateTime.now();
  //var t = TimeOfDay.now();
  //String startTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
  //String endTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
  //String meetingDate = DateFormat('M월 d일 E요일', 'ko').format(DateTime.now());

  var meetingStatus = [
    '날짜 설정중',
    '시간 설정중',
    '장소 설정중',
    '최종 장소 설정중',
    '모임 대기중',
    '모임 진행중',
    '모임 종료'
  ];
  //var member = 5;

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
                      Container(
                        child: Text(
                          meetingStatus[widget.status],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                        decoration: BoxDecoration(
                            color: _statusColor(widget.status),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.all(3),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(itemBuilder: (context) {
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
                                      print('삭제 선택');
                                    },
                                  ),
                                ];
                              })),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.meetingName,
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
                Text(DateFormat('M월 d일 E요일', 'ko').format(widget.md))
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
                Text(DateFormat('aa hh:mm', 'ko').format(widget.sd) +
                    " ~ " +
                    DateFormat('aa hh:mm', 'ko').format(widget.ed))
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
                Text(widget.member.toString() + '명')
              ],
            )
          ],
        ),
      ),
    );
  }
}
