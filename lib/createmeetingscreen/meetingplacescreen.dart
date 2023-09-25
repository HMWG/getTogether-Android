import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingrecommendscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPlaceScreen extends StatefulWidget {
  const MeetingPlaceScreen({super.key});

  @override
  State<MeetingPlaceScreen> createState() => _MeetingPlaceScreenState();
}

class _MeetingPlaceScreenState extends State<MeetingPlaceScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng kangnamUniv = LatLng(
      //위도와 경도 값 지정
      37.277057,
      127.134173);

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(
        //위도와 경도 값 지정
        37.277057,
        127.134173),
    zoom: 15,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('출발하실 위치를',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
                SizedBox(
                  height: 0.0,
                ),
                Text('선택해주세요',
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
            height: 500,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
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
