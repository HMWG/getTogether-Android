class Member {
  final int id;
  final String? username;

  Member({required this.id, required this.username});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
      };
}

class MemberId {
  int? id;

  MemberId({required this.id});

  factory MemberId.fromJson(Map<String, dynamic> json) {
    return MemberId(
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
      };

  MemberId.fromMap(Map<String, dynamic>? map) {
    id = map?['id'] ?? '';
  }
}
