import 'package:flutter/material.dart';

class NoticeCard extends StatefulWidget {
  String meetingName;
  String inviter;
  bool isView;
  NoticeCard(
      {super.key,
      required this.meetingName,
      required this.inviter,
      required this.isView});

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

Color _noticeColor(newCheck) {
  Color c = Colors.transparent;
  if (newCheck == false) c = Colors.grey.shade200;
  return c;
}

class _NoticeCardState extends State<NoticeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.maxFinite,
      height: 70,
      decoration: BoxDecoration(
          color: _noticeColor(widget.isView),
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          )),
      child: Row(
        children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.0),
                  color: Colors.green.shade300),
              child: Icon(Icons.groups) // Text(key['title']),
              ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.inviter,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" 님이 모임에 초대했어요!")
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    widget.meetingName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" 모임에 가입해보세요")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
