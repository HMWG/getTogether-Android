import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingInfoCard extends StatefulWidget {
  const MeetingInfoCard({super.key});

  @override
  State<MeetingInfoCard> createState() => _MeetingInfoCardState();
}

class _MeetingInfoCardState extends State<MeetingInfoCard> {
  var meetingName = 'Ourmeeting 회의';
  var meetingStatus = '진행중';
  var description = "어셈블~~~~ (회의 설명)";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  meetingStatus,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(3),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
          ),
          Text(
            meetingName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
