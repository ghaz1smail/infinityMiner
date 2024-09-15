class AppModel {
  final bool server;
  final List? admins;
  final String wallet;
  final String network;

  AppModel({
    this.server = false,
    this.admins,
    this.wallet = '',
    this.network = '',
  });

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admins: json['admins'] ?? [],
        wallet: json['wallet'] ?? '',
        network: json['network'] ?? '');
  }
}
