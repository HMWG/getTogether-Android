import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_together_android/cards/placecard.dart';
import 'package:get_together_android/entity/meetingentity.dart';
import 'package:get_together_android/kakaologin.dart';
import 'package:get_together_android/spring.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../mainscreen/meetingdetailscreen.dart';

class MeetingRecommendScreen extends StatefulWidget {
  int? id;
  MeetingRecommendScreen({super.key, required this.id});

  @override
  State<MeetingRecommendScreen> createState() => _MeetingRecommendScreenState();
}

class _MeetingRecommendScreenState extends State<MeetingRecommendScreen> {
  late KakaoMapController mapController;
  late Marker marker;
  Set<Marker> markers = {};
  var pos = LatLng(37.276508, 127.1323971);
  bool isLoading = true;
  late FinalPlace finalPlace;
  late var addressName = "알수없음";
  bool isCreated = false;
  String recommendText = "모임 추천이 없습니다.";
  List<KakaoRecommend> kakaoList = [];

  Future initMeetingFinalPlace() async {
    finalPlace = await getMeetingFinalPlace(
        LeaveMeeting(memberId: userInfo.id, meetingId: widget.id));
  }

  Future getRecommend() async {
    kakaoList = await getKakaoRecommend(pos);
    recommendText = await gptMeetingPlace(
        FinalPlaceAddress(meetingId: widget.id, place: addressName));
  }

  @override
  void initState() {
    super.initState();
    initMeetingFinalPlace().then((_) {
      setState(() {
        pos = LatLng(finalPlace.latitude!, finalPlace.longitude!);
        if (userInfo.id == finalPlace.createdBy) {
          isCreated = true;
        }
        getMyAddress(LatLng(finalPlace.latitude!, finalPlace.longitude!))
            .then((value) {
          getRecommend().then((value) {
            setState(() {
              isLoading = false;
            });
          });
        });
      });
    });
  }

  Future getMyAddress(LatLng latLng) async {
    addressName = await getAddress(latLng);
  }

  var checkCreator = true;

  var num = 4;
  var place = ["강남역", "신논현역", "역삼역", "교대역"];
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
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('모임 추천 장소를',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0)),
                      SizedBox(
                        height: 0.0,
                      ),
                      Text('알려드릴게요!',
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 450,
                  child: KakaoMap(
                    onMapCreated: ((controller) async {
                      mapController = controller;

                      marker = Marker(
                        markerId: markers.length.toString(),
                        latLng: pos,
                        width: 40,
                        height: 55,
                        offsetX: 0,
                        offsetY: 0,
                        infoWindowContent: '중간 위치에요!',
                        infoWindowFirstShow: true,
                        infoWindowRemovable: false,
                      );

                      markers.add(marker);

                      mapController.addMarker(markers: markers.toList());
                    }),
                    center: pos,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    recommendText,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                isCreated
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: kakaoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    _showCheckPlaceDialog(
                                        context, kakaoList[index].place_name!);
                                  },
                                  child: PlaceCard(
                                      number: index,
                                      place: kakaoList[index].place_name));
                            }),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: kakaoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {},
                                  child: PlaceCard(
                                      number: index,
                                      place: kakaoList[index].place_name));
                            }),
                      ),
              ],
            ),
      // bottomNavigationBar: isCreated
      //     ? Container(
      //         height: 55,
      //         color: Colors.lightGreen,
      //         child: TextButton(
      //           onPressed: () {
      //             _showCheckPlaceDialog(context);
      //           },
      //           child: Text(
      //             '입력 완료',
      //             style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white),
      //           ),
      //         ),
      //       )
      //     : Container(
      //         height: 55,
      //       ),
    );
  }

  void _showCheckPlaceDialog(BuildContext context, String place) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("모임 장소를 " + place + "로 설정할까요?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("아니요")),
              TextButton(
                  onPressed: () {
                    saveMeetingPlace(FinalPlaceAddress(
                            meetingId: widget.id, place: place))
                        .then((value) {
                      Get.back();
                      Get.off(() => MeetingDetailScreen(id: widget.id));
                    });
                  },
                  child: Text("네"))
            ],
          );
        });
  }
}
