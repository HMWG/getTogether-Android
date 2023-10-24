import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingdatescreen.dart';
import 'package:intl/intl.dart';

class MeetingInfoScreen extends StatefulWidget {
  const MeetingInfoScreen({super.key});

  @override
  State<MeetingInfoScreen> createState() => _MeetingInfoScreenState();
}

class _MeetingInfoScreenState extends State<MeetingInfoScreen> {
  var startTime;
  var endTime;
  bool isNeed = true;
  bool isNext = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isNeed, isNext];
    var now = TimeOfDay.now();

    startTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());
    endTime = DateFormat('aa hh:mm', 'ko').format(DateTime.now());

    super.initState();
  }

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
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(40, 60, 0, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('모임 정보를 입력해주세요',
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
              SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                height: 7,
                color: Color(0xffF6F6F6),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 이름',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '모임 이름을 입력해주세요',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 설명 (선택사항)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '모임 설명을 입력해주세요',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '모임 시간',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '시작 시간',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    startTime,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' 부터 ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Future<TimeOfDay?> selectedTime =
                                    showTimePicker(
                                  context:
                                      context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                                  initialTime:
                                      TimeOfDay.now(), // 프로퍼티에 초깃값을 지정합니다.
                                );
                                selectedTime.then((value) {
                                  setState(() {
                                    DateTime start;
                                    if (value != null)
                                      start = DateTime(
                                          0, 0, 0, value.hour, value.minute);
                                    else
                                      start = DateTime.now();
                                    startTime = DateFormat('aa hh:mm', 'ko')
                                        .format(DateTime(
                                            0, 0, 0, start.hour, start.minute));
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            border: Border(
                                left: BorderSide(color: Colors.grey, width: 1),
                                right: BorderSide(color: Colors.grey, width: 1),
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1),
                                top: BorderSide(color: Colors.grey, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '종료 시간',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    endTime,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' 까지 ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Future<TimeOfDay?> selectedTime =
                                    showTimePicker(
                                  context:
                                      context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                                  initialTime:
                                      TimeOfDay.now(), // 프로퍼티에 초깃값을 지정합니다.
                                );
                                selectedTime.then((value) {
                                  setState(() {
                                    DateTime end;
                                    if (value != null)
                                      end = DateTime(
                                          0, 0, 0, value.hour, value.minute);
                                    else
                                      end = DateTime.now();
                                    endTime = DateFormat('aa hh:mm', 'ko')
                                        .format(DateTime(
                                            0, 0, 0, end.hour, end.minute));
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '중간장소 추천',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ToggleButtons(
                        color: Colors.black.withOpacity(0.60),
                        selectedColor: Colors.lightGreen,
                        selectedBorderColor: Colors.lightGreen,
                        fillColor: Colors.lightGreen.withOpacity(0.08),
                        splashColor: Colors.lightGreen.withOpacity(0.12),
                        hoverColor: Colors.lightGreen.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(4.0),
                        constraints: BoxConstraints(minHeight: 36.0),
                        isSelected: isSelected,
                        onPressed: toggleSelect,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 150,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '필요해요',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 150,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '다음에 받을래요',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeetingDateScreen()),
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

  void toggleSelect(value) {
    if (value == 0) {
      isNeed = true;
      isNext = false;
    } else {
      isNeed = false;
      isNext = true;
    }
    setState(() {
      isSelected = [isNeed, isNext];
    });
  }
}
