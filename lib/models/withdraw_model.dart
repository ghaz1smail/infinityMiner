import 'package:infinityminer/models/user_model.dart';

class WithdrawModel {
  final String amount;
  final String id;
  final String timestamp;
  final UserModel userData;
  final String wallet;
  final String status;

  WithdrawModel({
    required this.amount,
    required this.id,
    required this.timestamp,
    required this.userData,
    required this.wallet,
    required this.status,
  });

  factory WithdrawModel.fromJson(Map json) {
    return WithdrawModel(
      amount: json['amount'].toString(),
      id: json['id'].toString(),
      timestamp: json['timestamp'],
      userData: UserModel.fromJson(json['userData']),
      wallet: json['wallet'],
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'id': id,
      'timestamp': timestamp,
      'userData': userData.toJson(),
      'wallet': wallet,
      'status': status,
    };
  }
}
