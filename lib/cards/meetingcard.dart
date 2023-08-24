import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingCard extends StatefulWidget {
  const MeetingCard({Key? key}) : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Container(
          width: 350,
          height: 215,
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
                      children: [
                        Container(
                          child: Text(
                            "진행중",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.left,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Ourmeeting 회의",
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
                  Text("1월 1일 월요일")
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
                  Text("오후 1:00 ~ 오후 2:00")
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
                  Text("5명")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
