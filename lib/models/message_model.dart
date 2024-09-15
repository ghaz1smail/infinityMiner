class MessageModel {
  final String id;
  final String timestamp;
  final String name;
  final String attachFile;
  final String message;
  final String email;
  final String uid;

  MessageModel({
    required this.id,
    required this.timestamp,
    required this.name,
    required this.attachFile,
    required this.message,
    required this.email,
    required this.uid,
  });

  factory MessageModel.fromJson(Map json) {
    return MessageModel(
      id: json['id'],
      timestamp: json['timestamp'],
      message: json['message'],
      attachFile: json['attachFile'] ?? '',
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'deviceData': message,
      'attachFile': attachFile,
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}
