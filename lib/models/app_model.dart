class AppModel {
  final bool server;
  final List? admins;

  AppModel({
    this.server = false,
    this.admins,
  });

  factory AppModel.fromJson(Map json) {
    return AppModel(server: json['server'] ?? false, admins: json['admins']);
  }
}
