class MessageModel {
  final String id;
  final String message;
  final String contactId;
  final String contactMessage;
  final String status;
  final String uid;
  final String timestamp;

  MessageModel({
    required this.id,
    required this.message,
    required this.contactId,
    required this.contactMessage,
    required this.status,
    required this.uid,
    required this.timestamp,
  });

  // Factory constructor to create a Message instance from a map
  factory MessageModel.fromMap(Map map) {
    return MessageModel(
      id: map['id'],
      message: map['message'],
      contactId: map['contactId'],
      contactMessage: map['contactMessage'],
      status: map['status'],
      uid: map['uid'],
      timestamp: map['timestamp'],
    );
  }

  // Method to convert a Message instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'contactId': contactId,
      'contactMessage': contactMessage,
      'status': status,
      'uid': uid,
      'timestamp': timestamp,
    };
  }
}
