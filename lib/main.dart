import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_together_android/langdingpage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '헤쳐모여',
      theme:
          ThemeData(primarySwatch: Colors.lightGreen, fontFamily: "notoSans"),
      home: LandingPage(),
    );
  }
}
