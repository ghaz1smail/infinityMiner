class AppModel {
  final bool server;
  final List? admins;
  final String wallet;
  final String wallet2;

  AppModel({
    this.server = false,
    this.admins,
    this.wallet = '',
    this.wallet2 = '',
  });

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admins: json['admins'] ?? [],
        wallet: json['wallet'] ?? '',
        wallet2: json['wallet2'] ?? '');
  }
}
