import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingDetailScreen extends StatefulWidget {
  const MeetingDetailScreen({super.key});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "헤쳐모여",
            style: TextStyle(
                fontFamily: "yeonSung", fontSize: 25, color: Colors.green),
          ),
          centerTitle: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('출발하실 위치를',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
                SizedBox(
                  height: 0.0,
                ),
                Text('선택해주세요',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
                SizedBox(
                  height: 0.0,
                ),
              ],
            ),
          ),
        ]));
  }
}
