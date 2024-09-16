class AppModel {
  final bool server;
  final List? admins;
  final String wallet;
  final String network;

  final String activeUsers;

  AppModel(
      {this.server = false,
      this.admins,
      this.wallet = '',
      this.network = '',
      this.activeUsers = ''});

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admins: json['admins'] ?? [],
        wallet: json['wallet'] ?? '',
        network: json['network'] ?? '',
        activeUsers: json['activeUsers'] ?? '');
  }
}
