import 'package:flutter/material.dart';
import 'package:get_together_android/cards/placecard.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MeetingRecommendScreen extends StatefulWidget {
  const MeetingRecommendScreen({super.key});

  @override
  State<MeetingRecommendScreen> createState() => _MeetingRecommendScreenState();
}

class _MeetingRecommendScreenState extends State<MeetingRecommendScreen> {
  late KakaoMapController mapController;
  late Marker marker;
  Set<Marker> markers = {};
  var pos = LatLng(37.276508, 127.1323971);

  var checkMaker = true;

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
        body: Column(
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
              child: Expanded(
                child: ListView.builder(
                    itemCount: num,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (checkMaker) {
                            _showCheckPlaceDialog(context, place, index);
                          }
                        },
                        child: PlaceCard(
                          number: index,
                          place: place[index],
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}

void _showCheckPlaceDialog(BuildContext context, List place, int index) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text("모임 장소를 " + place[index] + "으로 설정할까요?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("아니요")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                },
                child: Text("네"))
          ],
        );
      });
}
