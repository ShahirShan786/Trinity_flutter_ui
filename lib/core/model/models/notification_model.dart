class NotificationModel {
  final String image;
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationModel({
    required this.image,
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      image: json['image'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
