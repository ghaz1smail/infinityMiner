class DeviceModel {
  final String name;
  final String image;
  final double subscriptionPrice;
  final String miningRate;
  final String description;

  DeviceModel({
    required this.name,
    required this.image,
    required this.subscriptionPrice,
    required this.miningRate,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'subscriptionPrice': subscriptionPrice,
      'miningRateRange': miningRate,
      'description': description,
    };
  }

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      subscriptionPrice: double.parse(json['subscriptionPrice'].toString()),
      miningRate: json['miningRateRange'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
