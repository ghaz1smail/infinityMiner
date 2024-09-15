import 'package:infinityminer/models/device_model.dart';

class AppData {
  List<DeviceModel> miningPlans = [
    DeviceModel(
        id: '0',
        name: 'Antminer S90',
        image: 's9',
        miningRate: 15,
        subscriptionPrice: 49,
        miningRateString: 'Up to 15\$/month',
        description:
            'A compact miner for entry-level users, offering moderate mining power for small-scale operations.'),
    DeviceModel(
        id: '1',
        name: 'Antminer S170',
        image: 's17',
        miningRate: 30,
        subscriptionPrice: 99,
        miningRateString: 'Up to 30\$/month',
        description:
            'An efficient option for users looking to step up their mining efforts with minimal energy consumption.'),
    DeviceModel(
        id: '2',
        name: 'Antminer T19',
        image: 't19',
        miningRate: 80,
        subscriptionPrice: 249,
        miningRateString: 'Up to 80\$/month',
        description:
            'Known for its high efficiency, the T19 provides solid performance for intermediate miners.'),
    DeviceModel(
        id: '3',
        name: 'Antminer S19',
        image: 's19',
        miningRate: 150,
        subscriptionPrice: 499,
        miningRateString: 'Up to 150\$/month',
        description:
            'A powerful miner designed for users seeking higher profitability and stronger mining capabilities.'),
    DeviceModel(
        id: '4',
        name: 'Antminer S19 Pro',
        image: 's19pro',
        miningRate: 250,
        subscriptionPrice: 999,
        miningRateString: 'Up to 300\$/month',
        description:
            'A high-performance miner with excellent energy efficiency, ideal for professional and large-scale mining operations.'),
    DeviceModel(
        id: '5',
        name: 'Antminer S19 XP',
        image: 's19xp',
        subscriptionPrice: 1499,
        miningRate: 400,
        miningRateString: 'Up to 500\$/month',
        description:
            'One of the top-tier miners offering maximum mining power for advanced users, optimizing both performance and profit.'),
    DeviceModel(
        id: '6',
        name: 'Whatsminer M30S',
        image: 'm30s',
        miningRate: 700,
        subscriptionPrice: 2499,
        miningRateString: 'Up to 800\$/month',
        description:
            'A reliable and powerful mining rig suitable for industrial-scale operations, with top-notch energy efficiency.'),
    DeviceModel(
        id: '7',
        name: 'Whatsminer M30S++',
        image: 'm30s+',
        miningRate: 1300,
        subscriptionPrice: 3999,
        miningRateString: 'Up to 1300\$/month',
        description:
            'A highly efficient, advanced miner, delivering exceptional performance for large-scale cryptocurrency mining.'),
    DeviceModel(
        id: '8',
        name: 'Whatsminer M31S',
        image: 'm31s',
        miningRate: 1200,
        subscriptionPrice: 4999,
        miningRateString: 'Up to 1600\$/month',
        description:
            'A versatile miner designed for users looking for strong, consistent output with a reasonable power draw.'),
    DeviceModel(
        id: '9',
        name: 'Antminer S19j Pro',
        image: 's19j',
        miningRate: 2500,
        subscriptionPrice: 9999,
        miningRateString: 'Up to 3200\$/month',
        description:
            'One of the most powerful miners available, perfect for expert-level users aiming for maximum returns on investment.'),
  ];
}
