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
  int meetingNum = 0;
  int myMeetingNum = 5;

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
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 160,
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
              height: 7,
              color: Color(0xffF6F6F6),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: ContainedTabBarView(
                    tabs: [
                      Text('나의 모임'),
                      Text('내가 만든 모임'),
                    ],
                    views: [
                      Container(
                        color: Colors.white60,
                        child: meetingNum != 0
                            ? ListView.builder(
                                itemCount: meetingNum,
                                itemBuilder: (BuildContext context, int index) {
                                  return MeetingCard();
                                })
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name + '님이 속한 모임이 없습니다.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    Text(
                                      '모임을 만들어보세요!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: null,
                                        child: Text(
                                          '모임 만들기',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0),
                                        ))
                                  ],
                                ),
                              ),
                      ),
                      Container(
                        color: Colors.white60,
                        child: myMeetingNum != 0
                            ? ListView.builder(
                                itemCount: myMeetingNum,
                                itemBuilder: (BuildContext context, int index) {
                                  return MeetingCard();
                                })
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '내가 만든 모임이 없습니다.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    Text(
                                      '모임을 만들어보세요!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: null,
                                        child: Text(
                                          '모임 만들기',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0),
                                        ))
                                  ],
                                ),
                              ),
                      ),
                    ],
                    onChange: (index) => print(index),
                  )),
            )
          ],
        )));
  }
}
