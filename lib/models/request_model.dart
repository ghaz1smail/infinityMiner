import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/models/user_model.dart';

class RequestModel {
  final String id;
  final String timestamp;
  final DeviceModel deviceData;
  final String attachFile;
  final UserModel userData;
  final String status;

  RequestModel({
    required this.id,
    required this.timestamp,
    required this.deviceData,
    required this.attachFile,
    required this.userData,
    required this.status,
  });

  factory RequestModel.fromJson(Map json) {
    return RequestModel(
      id: json['id'],
      timestamp: json['timestamp'],
      deviceData: DeviceModel.fromJson(json['deviceData']),
      attachFile: json['attachFile'] ?? '',
      status: json['status'] ?? '',
      userData: UserModel.fromJson(json['userData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'deviceData': deviceData.toJson(),
      'attachFile': attachFile,
      'status': status,
      'userData': userData.toJson(),
    };
  }
}
