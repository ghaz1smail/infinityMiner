class DeviceModel {
  final String id;
  final String name;
  final String image;
  final double subscriptionPrice;
  final double miningRate;

  final String miningRateString;
  final String description;

  DeviceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.subscriptionPrice,
    required this.miningRateString,
    required this.miningRate,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'subscriptionPrice': subscriptionPrice,
      'miningRateString': miningRateString,
      'miningRate': miningRate,
      'description': description,
    };
  }

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      miningRate: double.parse(json['miningRate'].toString()),
      subscriptionPrice: double.parse(json['subscriptionPrice'].toString()),
      miningRateString: json['miningRateString'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
