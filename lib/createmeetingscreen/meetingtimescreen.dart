import 'package:flutter/material.dart';

class MeetingTimeScreen extends StatefulWidget {
  const MeetingTimeScreen({super.key});

  @override
  State<MeetingTimeScreen> createState() => _MeetingTimeScreenState();
}

class _MeetingTimeScreenState extends State<MeetingTimeScreen> {
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
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text('모임이 불가능한 시간을 추가해주세요!'),
            )
          ],
        ),
      ),
    );
  }
}
