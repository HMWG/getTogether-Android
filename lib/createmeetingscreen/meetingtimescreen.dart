import 'package:flutter/material.dart';
import 'package:get_together_android/cards/meetingcard.dart';
import 'package:get_together_android/cards/meetinginfocard.dart';
import 'package:get_together_android/cards/meetingtimecard.dart';
import 'package:get_together_android/createmeetingscreen/meetingplacescreen.dart';
import 'package:intl/intl.dart';

class MeetingTimeScreen extends StatefulWidget {
  const MeetingTimeScreen({super.key});

  @override
  State<MeetingTimeScreen> createState() => _MeetingTimeScreenState();
}

class _MeetingTimeScreenState extends State<MeetingTimeScreen> {
  String meetingDate = DateFormat('yyyy년 M월', 'ko').format(DateTime.now());

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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('모임이 가능한 시간을',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
                SizedBox(
                  height: 0.0,
                ),
                Text('추가해주세요',
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
          Container(
            width: double.infinity,
            height: 7,
            color: Color(0xffF6F6F6),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Text(
              meetingDate,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: MeetingTimeCard(),
          )
        ]),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            _showCheckTimeDialog(context);
          },
          child: Text(
            '입력 완료',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

void _showCheckTimeDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("입력 완료 되었습니다.\n팀원을 기다려주세요!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("수정하기")),
            TextButton(
                onPressed: () {
                  //Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeetingPlaceScreen()),
                  );
                },
                child: Text("네"))
          ],
        );
      });
}
