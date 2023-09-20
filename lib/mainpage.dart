import 'package:flutter/material.dart';
import 'package:get_together_android/mainscreen/friendsscreen.dart';
import 'package:get_together_android/mainscreen/homescreen.dart';
import 'package:get_together_android/mainscreen/managescreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(label: "친구", icon: Icon(Icons.people_alt)),
    BottomNavigationBarItem(label: "홈", icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: "더보기", icon: Icon(Icons.more_horiz)),
  ];

  // List pages = [
  //   Container(
  //     child: Center(
  //       child: Text("친구 페이지"),
  //     ),
  //   ),
  //   Container(
  //     child: Center(
  //       child: Text("홈 페이지"),
  //     ),
  //   ),
  //   Container(
  //     child: Center(
  //       child: Text("더보기 페이지"),
  //     ),
  //   ),
  //   Container(
  //     child: Center(
  //       child: Text("햄버거 페이지"),
  //     ),
  //   ),
  // ];

  List pages = [
    FriendsScreen(),
    HomeScreen(),
    ManageScreen(),
  ];

  // 앱바 텍스트
  String appBarText = "메인페이지(헤쳐모여)";

  //메뉴버튼 누를 시 state 변경
  void menuState() {
    setState(() {
      selectedIndex = 2;
      appBarText = "관리";
    });
  }

  //메뉴버튼
  IconButton menuBtn = IconButton(onPressed: () {}, icon: Icon(Icons.menu));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(2
      //   title: Text(
      //     appBarText,
      //     style: TextStyle(
      //         fontFamily: "yeonSung", fontSize: 25, color: Colors.black),
      //   ),
      //   centerTitle: false,
      //   elevation: 0.0,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           setState(() {
      //             selectedIndex = 2;
      //             appBarText = "관리";
      //           });
      //         },
      //         icon: Icon(Icons.menu))
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightGreenAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 10,
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
            // switch (selectedIndex) {
            //   case 0:
            //     appBarText = "친구";
            //     break;
            //   case 1:
            //     appBarText = "메인페이지(헤쳐모여)";
            //     break;
            //   case 2:
            //     appBarText = "관리";
            //     break;
            // }
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: bottomItems,
      ),
      body: pages[selectedIndex],
    );
  }
}
