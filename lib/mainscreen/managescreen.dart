import 'package:flutter/material.dart';
import 'package:get_together_android/mainpage.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("관리스크린"),
      ),
      appBar: AppBar(
        title: Text(
          "관리",
          style: TextStyle(
              fontFamily: "yeonSung", fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
    );
  }
}
