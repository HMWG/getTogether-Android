import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_together_android/createmeetingscreen/meetingrecommendscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPlaceGoogleScreen extends StatefulWidget {
  const MeetingPlaceGoogleScreen({super.key});

  @override
  State<MeetingPlaceGoogleScreen> createState() =>
      _MeetingPlaceGoogleScreenState();
}

class _MeetingPlaceGoogleScreenState extends State<MeetingPlaceGoogleScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? mapController;
  LatLng? _lastTap;
  LatLng? _lastLongPress;

  LatLng kangnamUniv = LatLng(
      //위도와 경도 값 지정
      37.277057,
      127.134173);

  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(
          //위도와 경도 값 지정
          37.277057,
          127.134173),
      zoom: 15);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            width: double.infinity,
            height: 500,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng pos) {
                setState(() {
                  _lastTap = pos;
                });
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
