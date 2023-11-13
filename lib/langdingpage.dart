import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mainpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Get.offAll(MainPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreenAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/salute.png"),
              ),
              Container(
                child: Text("헤쳐모여"),
              ),
              Container(
                child: Text("로그인 중.."),
              ),
              Container(
                height: 100,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
