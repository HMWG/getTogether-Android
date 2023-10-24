import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_android/createmeetingscreen/meetingrecommendscreen.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MeetingPlaceScreen extends StatefulWidget {
  const MeetingPlaceScreen({super.key});

  @override
  State<MeetingPlaceScreen> createState() => _MeetingPlaceScreenState();
}

late var pos = LatLng(37.277057, 127.134173);

Future<void> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  pos = LatLng(position.latitude, position.longitude);
}

class _MeetingPlaceScreenState extends State<MeetingPlaceScreen> {
  late KakaoMapController mapController;
  late Marker marker;
  Set<Marker> markers = {};

  LatLng kangnamUniv = LatLng(
      //위도와 경도 값 지정
      37.277057,
      127.134173);

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
            child: Text(
              pos.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 350,
                child: KakaoMap(
                  onMapCreated: ((controller) async {
                    mapController = controller;
                    getCurrentLocation();

                    marker = Marker(
                      markerId: markers.length.toString(),
                      latLng: await mapController.getCenter(),
                      width: 30,
                      height: 44,
                      offsetX: 15,
                      offsetY: 44,
                      infoWindowContent: '',
                      infoWindowFirstShow: true,
                      infoWindowRemovable: true,
                    );

                    markers.add(marker);

                    mapController.addMarker(markers: markers.toList());
                  }),
                  onMapTap: ((latLng) {
                    marker.latLng = latLng;
                    //pos = getCurrentLocation(); 좌표를 위치로 바꾸어서 텍스트로 내보내기 구현하기

                    pos = latLng;
                    mapController.panTo(latLng);

                    setState(() {});
                  }),
                  currentLevel: 4,
                  markers: markers.toList(),
                  center: pos,
                ),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      getCurrentLocation();
                      marker.latLng = pos;

                      mapController.panTo(pos);

                      setState(() {});
                    },
                    child: Icon(
                      Icons.location_searching,
                      size: 20,
                      color: Colors.black,
                    ),
                  ))
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.lightGreen,
        child: TextButton(
          onPressed: () {
            _showCheckPlaceDialog(context);
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

void _showCheckPlaceDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("입력 완료 되었습니다.\n팀원을 기다려주세요!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("수정하기")),
            TextButton(
                onPressed: () {
                  //Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeetingRecommendScreen()),
                  );
                },
                child: Text("네"))
          ],
        );
      });
}
