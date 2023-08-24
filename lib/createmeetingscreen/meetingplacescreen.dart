import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingrecommendscreen.dart';

class MeetingPlaceScreen extends StatefulWidget {
  const MeetingPlaceScreen({super.key});

  @override
  State<MeetingPlaceScreen> createState() => _MeetingPlaceScreenState();
}

class _MeetingPlaceScreenState extends State<MeetingPlaceScreen> {
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
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeetingRecommendScreen()),
            );
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
