import 'dart:ffi';

import 'package:intl/intl.dart';

class Meeting {
  int? id;
  String? name;
  String? place;
  String? description;
  DateTime? start;
  DateTime? end;
  MeetingType? meetingType;
  bool? done;
  int? createdBy;
  int? count;
  bool? checkTime;

  Meeting(
      {required this.id,
      required this.name,
      required this.place,
      required this.description,
      required this.start,
      required this.end,
      required this.meetingType,
      required this.done,
      required this.createdBy,
      required this.count,
      required this.checkTime});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    String ms = json['meetingType'];
    MeetingType? mt;
    switch (ms) {
      case "close":
        mt = MeetingType.close;
        break;
      case "time":
        mt = MeetingType.time;
        break;
      case "inProgress":
        mt = MeetingType.inProgress;
        break;
      case "toDo":
        mt = MeetingType.toDo;
        break;
      case "finalPlace":
        mt = MeetingType.finalPlace;
        break;
      case "place":
        mt = MeetingType.place;
        break;
      case "date":
        mt = MeetingType.date;
        break;
      case "":
        mt = null;
        break;
    }

    return Meeting(
        id: json['id'],
        name: json['name'],
        place: json['place'],
        description: json['description'],
        start: json['start'] != null ? DateTime.parse(json['start']) : null,
        end: json['end'] != null ? DateTime.parse(json['end']) : null,
        meetingType: mt,
        done: json['done'],
        createdBy: json['createdBy'],
        count: json['count'],
        checkTime: null);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'place': place,
        'description': description,
        'start': start != null ? start.toString() : "",
        'end': end != null ? end.toString() : "",
        'meetingType': meetingType?.name,
        'done': done,
        'createdBy': createdBy,
        'checkTime': checkTime
      };

  Meeting.fromMap(Map<String, dynamic>? map) {
    String ms = map?['meetingType'] ?? '';
    MeetingType? mt;
    switch (ms) {
      case "close":
        mt = MeetingType.close;
        break;
      case "time":
        mt = MeetingType.time;
        break;
      case "inProgress":
        mt = MeetingType.inProgress;
        break;
      case "toDo":
        mt = MeetingType.toDo;
        break;
      case "finalPlace":
        mt = MeetingType.finalPlace;
        break;
      case "place":
        mt = MeetingType.place;
        break;
      case "date":
        mt = MeetingType.date;
        break;
      case "":
        mt = null;
        break;
    }

    id = map?['id'] ?? '';
    name = map?['name'] ?? '';
    place = map?['place'] ?? null;
    description = map?['description'] ?? null;
    start = map?['start'] != null ? DateTime.parse(map?['start'] ?? "") : null;
    end = map?['end'] != null ? DateTime.parse(map?['end'] ?? "") : null;
    meetingType = mt;
    done = map?['done'] ?? '';
    createdBy = map?['createdBy'] ?? '';
    count = map?['count'] ?? '';
  }
}

class MeetingId {
  int? id;

  MeetingId({required this.id});

  factory MeetingId.fromJson(Map<String, dynamic> json) {
    return MeetingId(
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class LeaveMeeting {
  int? meetingId;
  int? memberId;

  LeaveMeeting({required this.memberId, required this.meetingId});

  factory LeaveMeeting.fromJson(Map<String, dynamic> json) {
    return LeaveMeeting(
      memberId: json['memberId'],
      meetingId: json['meetingId'],
    );
  }
  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'meetingId': meetingId,
      };
}

class MeetingDate {
  int? meetingId;
  int? memberId;
  DateTime? date;

  MeetingDate(
      {required this.memberId, required this.meetingId, required this.date});

  factory MeetingDate.fromJson(Map<String, dynamic> json) {
    return MeetingDate(
      memberId: json['memberId'],
      meetingId: json['meetingId'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'meetingId': meetingId,
        'date': date != null ? date.toString() : "",
      };
}

class MeetingPlace {
  int? meetingId;
  int? memberId;
  double? latitude;
  double? longitude;

  MeetingPlace(
      {required this.memberId,
      required this.meetingId,
      required this.longitude,
      required this.latitude});

  factory MeetingPlace.fromJson(Map<String, dynamic> json) {
    return MeetingPlace(
        memberId: json['memberId'],
        meetingId: json['meetingId'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'meetingId': meetingId,
        'latitude': latitude,
        'longitude': longitude
      };
}

enum MeetingType { date, time, place, finalPlace, toDo, inProgress, close }

class Address {
  String? address;

  Address({required this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['road_address'],
    );
  }

  Address.fromMap(Map<String, dynamic>? map) {
    address = map?['road_address'] ?? '';
  }
}

class DateList {
  DateTime? date;

  DateList({required this.date});

  DateList.fromMap(Map<String, dynamic>? map) {
    date = map?['date'] != null ? DateTime.parse(map?['date'] ?? "") : null;
  }
}

class FinalPlace {
  double? latitude;
  double? longitude;
  int? createdBy;

  FinalPlace(
      {required this.longitude,
      required this.latitude,
      required this.createdBy});

  factory FinalPlace.fromJson(Map<String, dynamic> json) {
    return FinalPlace(
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdBy: json['createdBy'],
    );
  }
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'createdBy': createdBy,
      };
}

class FinalPlaceAddress {
  int? meetingId;
  String? place;

  FinalPlaceAddress({required this.meetingId, required this.place});

  Map<String, dynamic> toJson() => {'meetingId': meetingId, 'place': place};
}

class KakaoRecommend {
  String? place_name;
  String? x;
  String? y;

  KakaoRecommend({required this.place_name, required this.x, required this.y});

  factory KakaoRecommend.fromJson(Map<String, dynamic> json) {
    return KakaoRecommend(
      place_name: json['place_name'],
      x: json['x'],
      y: json['y'],
    );
  }

  KakaoRecommend.fromMap(Map<String, dynamic>? map) {
    place_name = map?['place_name'] ?? '';
    x = map?['x'] ?? '';
    y = map?['y'] ?? '';
  }
}
