class Notice {
  int? id;
  int? member;
  int? invitor;
  int? meeting;
  bool? isView;

  Notice(
      {required this.id,
      required this.meeting,
      required this.member,
      required this.invitor,
      required this.isView});

  Notice.fromMap(Map<String, dynamic>? map) {
    id = map?['id'] ?? '';
    member = map?['memberId'] ?? '';
    invitor = map?['invitorId'] ?? '';
    meeting = map?['meetingId'] ?? '';
    isView = map?['isView'] ?? '';
  }
}

class GetNotice {
  int? id;
  String? invitor;
  String? meetingName;
  bool? isView;

  GetNotice(
      {required this.id,
      required this.meetingName,
      required this.invitor,
      required this.isView});

  GetNotice.fromMap(Map<String, dynamic>? map) {
    id = map?['id'] ?? '';
    invitor = map?['invitor'] ?? '';
    meetingName = map?['meetingName'] ?? '';
    isView = map?['view'] ?? '';
  }
}

class AcceptNotice {
  int? id;
  int? member;

  AcceptNotice({required this.id, required this.member});

  Map<String, dynamic> toJson() => {
        'memberId': member,
        'noticeId': id,
      };
}

class NoticeId {
  int? id;

  NoticeId({required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class InviteNotice {
  final int? member;
  final int? invitor;
  final int? meeting;

  InviteNotice({
    required this.meeting,
    required this.member,
    required this.invitor,
  });

  Map<String, dynamic> toJson() => {
        'memberId': member,
        'invitorId': invitor,
        'meetingId': meeting,
      };
}
