import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingCard extends StatefulWidget {
  const MeetingCard({Key? key}) : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  var meetingName = 'Ourmeeting 회의';
  //DateFormat dateFormat = DateFormat('aa hh:mm','ko');
  var d = DateTime.now();
  var t = TimeOfDay.now();
  String startTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
  String endTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
  String meetingDate = DateFormat('M월 d일 E요일', 'ko').format(DateTime.now());
  var meetingStatus = '진행중';
  var member = 5;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
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
                            meetingStatus,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.left,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(3),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          meetingName,
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
                  Text(meetingDate)
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
                  Text(startTime + " ~ " + endTime)
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
                  Text(member.toString() + '명')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
