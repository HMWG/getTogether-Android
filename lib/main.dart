import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_together_android/langdingpage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import 'mainpage.dart';

void main() async {
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  final status = await Geolocator.checkPermission();
  if (status == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
  AuthRepository.initialize(appKey: 'a95a3cc7c4ed405f329e56e3e0a3c23b');

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
      home: MainPage(),
    );
  }
}
