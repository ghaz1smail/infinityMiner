import 'package:infinityminer/models/device_model.dart';

class AppData {
  List<DeviceModel> miningPlans = [
    DeviceModel(
        name: 'Antminer S90',
        image: 's9',
        subscriptionPrice: 49,
        miningRate: 'Up to 15\$/month',
        description:
            'A compact miner for entry-level users, offering moderate mining power for small-scale operations.'),
    DeviceModel(
        name: 'Antminer S170',
        image: 's17',
        subscriptionPrice: 99,
        miningRate: 'Up to 35\$/month',
        description:
            'An efficient option for users looking to step up their mining efforts with minimal energy consumption.'),
    DeviceModel(
        name: 'Antminer T19',
        image: 't19',
        subscriptionPrice: 249,
        miningRate: 'Up to 80\$/month',
        description:
            'Known for its high efficiency, the T19 provides solid performance for intermediate miners.'),
    DeviceModel(
        name: 'Antminer S19',
        image: 's19',
        subscriptionPrice: 499,
        miningRate: 'Up to 150\$/month',
        description:
            'A powerful miner designed for users seeking higher profitability and stronger mining capabilities.'),
    DeviceModel(
        name: 'Antminer S19 Pro',
        image: 's19pro',
        subscriptionPrice: 999,
        miningRate: 'Up to 300\$/month',
        description:
            'A high-performance miner with excellent energy efficiency, ideal for professional and large-scale mining operations.'),
    DeviceModel(
        name: 'Antminer S19 XP',
        image: 's19xp',
        subscriptionPrice: 1499,
        miningRate: 'Up to 500\$/month',
        description:
            'One of the top-tier miners offering maximum mining power for advanced users, optimizing both performance and profit.'),
    DeviceModel(
        name: 'Whatsminer M30S',
        image: 'm30s',
        subscriptionPrice: 2499,
        miningRate: 'Up to 800\$/month',
        description:
            'A reliable and powerful mining rig suitable for industrial-scale operations, with top-notch energy efficiency.'),
    DeviceModel(
        name: 'Whatsminer M30S++',
        image: 'm30s+',
        subscriptionPrice: 3999,
        miningRate: 'Up to 1300\$/month',
        description:
            'A highly efficient, advanced miner, delivering exceptional performance for large-scale cryptocurrency mining.'),
    DeviceModel(
        name: 'Whatsminer M31S',
        image: 'm31s',
        subscriptionPrice: 4999,
        miningRate: 'Up to 1600\$/month',
        description:
            'A versatile miner designed for users looking for strong, consistent output with a reasonable power draw.'),
    DeviceModel(
        name: 'Antminer S19j Pro',
        image: 's19j',
        subscriptionPrice: 9999,
        miningRate: 'Up to 3200\$/month',
        description:
            'One of the most powerful miners available, perfect for expert-level users aiming for maximum returns on investment.'),
  ];
}
