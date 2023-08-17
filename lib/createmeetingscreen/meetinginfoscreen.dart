import 'package:flutter/material.dart';

class MeetingInfoScreen extends StatefulWidget {
  const MeetingInfoScreen({super.key});

  @override
  State<MeetingInfoScreen> createState() => _MeetingInfoScreenState();
}

class _MeetingInfoScreenState extends State<MeetingInfoScreen> {
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
              width: double.infinity,
              height: 160,
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('모임 정보를 입력해주세요',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0)),
                  SizedBox(
                    height: 0.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
