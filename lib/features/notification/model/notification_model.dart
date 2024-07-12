class NotifModel {
  final int? id;
  final String title;
  final String body;
  final String uid;
  final DateTime time;

  NotifModel({
    this.id,
    required this.title,
    required this.body,
    required this.uid,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'uid': uid,
      'time': time.toIso8601String(),
    };
  }

  factory NotifModel.fromMap(Map<String, dynamic> map) {
    return NotifModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      uid: map['uid'],
      time: DateTime.parse(map['time']),
    );
  }
}
