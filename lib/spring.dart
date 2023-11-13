import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_together_android/entity/meetingentity.dart';
import 'package:get_together_android/entity/noticeentity.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_together_android/entity/memberentity.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import 'mainpage.dart';
import 'mainscreen/meetingdetailscreen.dart';

//final String url = "http://192.168.0.6:8080";
final String url = "http://172.20.10.2:8080";

Future<void> saveMember(Member member) async {
  try {
    final response = await http.post(
      Uri.parse("$url/join"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(member.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("멤버 회원 가입 데이터 전송 실패: ${e}");
  }
}

Future<void> createMeeting(Meeting meeting) async {
  try {
    final response = await http.post(
      Uri.parse("$url/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meeting.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("POST 데이터 전송 실패: ${e}");
  }
}

Future<List<List<Meeting>>> myMeetings(int? id) async {
  List<Meeting> meetings = [];
  List<Meeting> myMeetings = [];
  List<List<Meeting>> list = [];
  try {
    final response = await http.get(
      Uri.parse("$url/meetings?id=$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print(0);
      meetings = jsonDecode(utf8.decode(response.bodyBytes))['meetings']
          .map<Meeting>((meetings) {
        return Meeting.fromMap(meetings);
      }).toList();
      print(1);
      myMeetings = jsonDecode(utf8.decode(response.bodyBytes))['myMeetings']
          .map<Meeting>((myMeetings) {
        return Meeting.fromMap(myMeetings);
      }).toList();
      print("데이터 받기 성공");
    }
  } catch (e) {
    print("GET 데이터 전송 실패: ${e}");
  }
  list = [meetings, myMeetings];

  return list;
}

Future<Meeting?> myMeeting(int? id) async {
  Meeting meeting;

  try {
    final response = await http.get(
      Uri.parse("$url/meeting?id=$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      meeting = Meeting.fromJson(responseBody);
      return meeting;
    }
  } catch (e) {
    print("GET 데이터 전송 실패: ${e}");
  }
}

Future<void> inviteMember(InviteNotice inviteNotice) async {
  try {
    final response = await http.post(
      Uri.parse("$url/notice/invite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(inviteNotice.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("멤버 모임 초대 전송 실패: ${e}");
  }
}

Future<List<GetNotice>> myNotice(int? id) async {
  List<GetNotice> list = [];
  try {
    final response = await http.get(
      Uri.parse("$url/notice?id=$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      list =
          jsonDecode(utf8.decode(response.bodyBytes)).map<GetNotice>((notice) {
        return GetNotice.fromMap(notice);
      }).toList();
      print("데이터 받기 성공");
    }
  } catch (e) {
    print("GET 데이터 전송 실패: ${e}");
  }

  return list;
}

Future<void> acceptNotice(
    AcceptNotice acceptNotice, String meetingName, int id) async {
  try {
    final response = await http.post(
      Uri.parse("$url/notice/accept"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(acceptNotice.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      MeetingId meetingId = MeetingId.fromJson(responseBody);
      Get.off(() => MeetingDetailScreen(
            id: meetingId.id,
          ));
      Fluttertoast.showToast(msg: meetingName + "모임에 가입하였습니다");
    }
  } catch (e) {
    print("모임 수락 전송 실패: ${e}");
    Fluttertoast.showToast(msg: "모임에 이미 가입했거나 모임 가입에 실패하였습니다");
    Get.back();
  }
}

Future<void> viewNotice(NoticeId noticeId) async {
  try {
    final response = await http.put(
      Uri.parse("$url/notice/view"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(noticeId.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 확인 실패: ${e}");
  }
}

Future<void> deleteNotice(NoticeId noticeId) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/notice/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(noticeId.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<void> clearNotice(int? id) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/notice/clear?id=$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
      Fluttertoast.showToast(msg: "알림을 지웠습니다");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<void> deleteMeeting(MeetingId meetingId) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/meetings/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingId.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
      Get.offAll(MainPage());
      Fluttertoast.showToast(msg: "모임을 삭제했습니다");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<void> leaveMeeting(LeaveMeeting leaveMeet) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/meetings/leave"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
      Get.offAll(MainPage());
      Fluttertoast.showToast(msg: "모임을 나갔습니다");
    }
  } catch (e) {
    print("모임 나가기 실패: ${e}");
  }
}

Future<String> getAddress(LatLng latLng) async {
  Address address;
  String addressName = "알수없음";
  String buildingName = "";
  List<Address> list = [];
  try {
    final response = await http.get(
      Uri.parse(
          "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=${latLng.longitude}&y=${latLng.latitude}&input_coord=WGS84"),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'KakaoAK dfef89ca2a5efeba6b070964015eca93',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody['documents'][0]['address']);
      if (responseBody['documents'][0]['road_address'] != null) {
        buildingName =
            responseBody['documents'][0]['road_address']["building_name"];
      }
      addressName = responseBody['documents'][0]['address']['address_name'] +
          " " +
          buildingName;
      //address = Address.fromJson(responseBody['documents'][0]['address']);
      print(2);
      //addressName = address.address == null ? "알수없음" : address.address!;
      print(3);
      // list = jsonDecode(utf8.decode(response.bodyBytes))['documents']
      //         ['road_address']
      //     .map<Meeting>((address) {
      //   return Address.fromMap(address);
      // }).toList();
      // addressName = list[0].address!;
      print("데이터 받기 성공");
    }
  } catch (e) {
    print("GET 데이터 전송 실패: ${e}");
  }

  return addressName;
}

///////////date////////

Future<bool> emptyMeetingDate(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/date/empty"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      check = responseBody;
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }
  return check;
}

Future<void> deleteMeetingDate(LeaveMeeting leaveMeet) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/recommend/date/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<List<DateTime>> getMeetingDate(LeaveMeeting leaveMeet) async {
  List<DateList> dates = [];
  List<DateTime> dateTimes = [];
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/date"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      dates = jsonDecode(utf8.decode(response.bodyBytes)).map<DateList>((date) {
        return DateList.fromMap(date);
      }).toList();
      print(1);
      for (DateList date in dates) {
        dateTimes.add(date.date!);
      }
      print("데이터 전송 성공");
      print(dateTimes);
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }

  return dateTimes;
}

Future<void> addMeetingDate(MeetingDate meetingDate) async {
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/date/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingDate.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임날짜 추가 실패: ${e}");
  }
}

Future<bool> checkMeetingDate(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/date/check"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      check = responseBody;
      print(check);
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임날짜 추가 실패: ${e}");
  }
  return check;
}

//////////time/////////

Future<List<DateTime>> getMeetingFinalDate(LeaveMeeting leaveMeet) async {
  List<DateList> dates = [];
  List<DateTime> dateTimes = [];
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/time"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      dates = jsonDecode(utf8.decode(response.bodyBytes)).map<DateList>((date) {
        return DateList.fromMap(date);
      }).toList();
      print(1);
      for (DateList date in dates) {
        dateTimes.add(date.date!);
      }
      print("데이터 전송 성공");
      print(dateTimes);
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }

  return dateTimes;
}

Future<bool> emptyMeetingTime(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/time/empty"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      check = responseBody;
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }
  return check;
}

Future<void> deleteMeetingTime(LeaveMeeting leaveMeet) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/recommend/time/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<void> addMeetingTime(MeetingDate meetingDate) async {
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/time/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingDate.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임날짜 추가 실패: ${e}");
  }
}

Future<bool> checkMeetingTime(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/time/check"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      check = responseBody;
      print(check);
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임날짜 추가 실패: ${e}");
  }
  return check;
}

/////////////////////place/////////////////////

Future<bool> emptyMeetingPlace(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/place/empty"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      check = responseBody;
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }
  return check;
}

Future<void> deleteMeetingPlace(LeaveMeeting leaveMeet) async {
  try {
    final response = await http.delete(
      Uri.parse("$url/recommend/place/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임 삭제 실패: ${e}");
  }
}

Future<void> addMeetingPlace(MeetingPlace meetingPlace) async {
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/place/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingPlace.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임장소 추가 실패: ${e}");
  }
}

Future<bool> checkMeetingPlace(LeaveMeeting leaveMeet) async {
  bool check = true;
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/place/check"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      check = responseBody;
      print(check);
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임날짜 추가 실패: ${e}");
  }
  return check;
}

////////////finalPlace/.../////////

Future<FinalPlace> getMeetingFinalPlace(LeaveMeeting leaveMeet) async {
  FinalPlace finalPlace =
      FinalPlace(longitude: 127.134173, latitude: 37.277057, createdBy: 0);
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/final"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(leaveMeet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      finalPlace = FinalPlace.fromJson(responseBody);
      print("데이터 전송 성공");
      print(finalPlace);
    }
  } catch (e) {
    print("모임 가져오기 실패: ${e}");
  }

  return finalPlace;
}

Future<void> saveMeetingPlace(FinalPlaceAddress finalPlaceAddress) async {
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/final/save"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(finalPlaceAddress.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임장소 추가 실패: ${e}");
  }
}

Future<String> gptMeetingPlace(FinalPlaceAddress finalPlaceAddress) async {
  String recommend = "";
  try {
    final response = await http.post(
      Uri.parse("$url/recommend/final/gpt"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(finalPlaceAddress.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      var responsebody = utf8.decode(response.bodyBytes);
      print(responsebody);
      recommend = responsebody;
      print(recommend);
      print("데이터 전송 성공");
    }
  } catch (e) {
    print("모임장소 추가 실패: ${e}");
  }
  print(recommend);
  return recommend;
}

Future<List<KakaoRecommend>> getKakaoRecommend(LatLng latLng) async {
  String addressName = "알수없음";
  String buildingName = "";
  List<KakaoRecommend> list = [];
  try {
    final response = await http.get(
      Uri.parse(
          "https://dapi.kakao.com/v2/local/search/category.json?category\_group\_code=SW8&radius=20000&y=${latLng.latitude}&x=${latLng.longitude}"),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'KakaoAK dfef89ca2a5efeba6b070964015eca93',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("데이터 전송 실패");
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes))['documents']);

      list = jsonDecode(utf8.decode(response.bodyBytes))['documents']
          .map<KakaoRecommend>((address) {
        return KakaoRecommend.fromMap(address);
      }).toList();
      print("카카오맵 데이터 받기 성공");
    }
  } catch (e) {
    print("GET 데이터 전송 실패: ${e}");
  }
  return list;
}
