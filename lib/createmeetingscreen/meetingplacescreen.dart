import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_together_android/createmeetingscreen/meetingrecommendscreen.dart';
import 'package:get_together_android/spring.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../entity/meetingentity.dart';
import '../kakaologin.dart';
import '../mainpage.dart';

class MeetingPlaceScreen extends StatefulWidget {
  int? id;
  MeetingPlaceScreen({super.key, required this.id});

  @override
  State<MeetingPlaceScreen> createState() => _MeetingPlaceScreenState();
}

class _MeetingPlaceScreenState extends State<MeetingPlaceScreen> {
  LatLng pos = LatLng(37.277057, 127.134173);
  late Position myPos;
  bool emptyCheck = true;

  Future initMeetingPlace() async {
    emptyCheck = await emptyMeetingPlace(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  }

  @override
  void initState() {
    super.initState();
    initMeetingPlace().then((_) {
      setState(() {
        if (!emptyCheck) _showCheckPlaceDialog(context, widget.id!);
      });
    });
  }

  Future addPlace() async {
    addMeetingPlace(MeetingPlace(
        memberId: userInfo.id,
        meetingId: widget.id,
        longitude: pos.longitude,
        latitude: pos.latitude));
  }

  Future getCurrentLocation() async {
    myPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  late var addressName = "알수없음";
  bool isLoading = true;

  Future getMyAddress(LatLng latLng) async {
    addressName = await getAddress(latLng);
  }

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
            padding: EdgeInsets.fromLTRB(40, 40, 0, 30),
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
            height: 20,
            child: isLoading
                ? const RefreshProgressIndicator()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade50, // 배경색
                      borderRadius: BorderRadius.circular(5), // 테두리 모양
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 그림자 색상
                          spreadRadius: 5, // 그림자 확산 범위
                          blurRadius: 7, // 그림자 흐림 정도
                          offset: Offset(0, 3), // 그림자 위치
                        ),
                      ],
                    ),
                    child: Text(
                      addressName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 305,
                child: KakaoMap(
                  onMapCreated: ((controller) async {
                    mapController = controller;

                    getCurrentLocation().then((_) {
                      pos = LatLng(myPos.latitude, myPos.longitude);
                      getMyAddress(pos).then((_) {
                        setState(() {
                          isLoading = false;
                          mapController.panTo(pos);
                          marker.latLng = pos;
                        });
                      });
                    });

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
                    isLoading = true;
                    marker.latLng = latLng;
                    //pos = getCurrentLocation(); 좌표를 위치로 바꾸어서 텍스트로 내보내기 구현하기

                    mapController.panTo(latLng);

                    pos = latLng;
                    getMyAddress(pos).then((_) {
                      setState(() {
                        isLoading = false;
                      });
                    });

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
                      isLoading = true;

                      getCurrentLocation().then((_) {
                        pos = LatLng(myPos.latitude, myPos.longitude);
                        marker.latLng = pos;
                        mapController.panTo(pos);
                        getMyAddress(pos).then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      });

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
            addPlace().then((value) async {
              if (await checkMeetingPlace(
                  LeaveMeeting(memberId: userInfo.id, meetingId: widget.id))) {
                Get.offAll(MainPage());
                Fluttertoast.showToast(msg: "모든 사람이 장소를 입력했습니다");
              } else {
                _showCheckPlaceDialog(context, widget.id!);
              }
            });
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

void _showCheckPlaceDialog(BuildContext context, int meetingId) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("입력 완료 되었습니다.\n팀원을 기다려주세요!"),
          actions: [
            TextButton(
                onPressed: () {
                  deleteMeetingPlace(LeaveMeeting(
                          memberId: userInfo.id, meetingId: meetingId))
                      .then((value) {
                    Get.back();
                    Get.off(MeetingPlaceScreen(id: meetingId));
                  });
                },
                child: Text("수정하기")),
            TextButton(
                onPressed: () {
                  Get.offAll(MainPage());
                },
                child: Text("네"))
          ],
        );
      });
}
