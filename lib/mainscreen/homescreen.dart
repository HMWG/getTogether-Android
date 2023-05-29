import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get_together_android/cards/meetingcard.dart';
import 'package:get_together_android/mainscreen/tabscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "민우";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "헤쳐모여",
            style: TextStyle(
                fontFamily: "yeonSung", fontSize: 25, color: Colors.green),
          ),
          centerTitle: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 170,
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name + "님",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0)),
                  SizedBox(
                    height: 0.0,
                  ),
                  Text(
                    "안녕하세요 😊",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Color(0xffF6F6F6),
            ),
            Container(
              width: double.infinity,
              height: 500,
              child: ContainedTabBarView(
                tabs: [
                  Text('내가 만든 모임'),
                  Text('나를 초대한 모임'),
                ],
                views: [
                  Container(
                    color: Colors.white60,
                    child: MeetingCard(),
                  ),
                  Container(color: Colors.green)
                ],
                onChange: (index) => print(index),
              ),
            )
          ],
        )));
  }
}
