class DeviceModel {
  final String name;
  final String image;
  final double subscriptionPrice;
  final String miningRateRange;
  final int powerConsumption;
  final double hashRate;

  DeviceModel({
    required this.name,
    required this.image,
    required this.subscriptionPrice,
    required this.miningRateRange,
    required this.powerConsumption,
    required this.hashRate,
  });
}
