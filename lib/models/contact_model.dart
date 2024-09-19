class ContactModel {
  final String id;
  final String timestamp;
  final String name;
  final String attachFile;
  final String message;
  final String email;
  final String uid;
  final String status;

  ContactModel({
    required this.id,
    required this.timestamp,
    required this.name,
    required this.attachFile,
    required this.message,
    required this.email,
    required this.uid,
    required this.status,
  });

  factory ContactModel.fromJson(Map json) {
    return ContactModel(
      id: json['id'],
      timestamp: json['timestamp'],
      message: json['message'],
      attachFile: json['attachFile'] ?? '',
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      status: json['status'] ?? 'pending',
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
      'status': status,
    };
  }
}
