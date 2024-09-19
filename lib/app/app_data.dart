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

  String termsAndConditions = """
Terms and Conditions for Infinityminer.net

1. Acceptance of Terms
By accessing and using Infinityminer.net, you agree to comply with these Terms and Conditions. If you do not agree, please refrain from using our services.

2. Services Offered
Infinityminer.net provides cloud mining services where users can purchase mining power. Our services include the operation of mining hardware to generate cryptocurrencies.

3. Earnings Disclaimer
The earnings mentioned on our website are not a guarantee of profit. They are based on our operation of mining equipment. In the event of a cessation of mining activity or a decline in the price of Bitcoin, your earnings may decrease or cease altogether.

4. User Responsibilities
Users are responsible for maintaining the confidentiality of their account information and for all activities conducted under their accounts. You agree to notify us immediately of any unauthorized use of your account.

5. Modifications to Services
Infinityminer.net reserves the right to modify or discontinue its services at any time without prior notice. We will not be liable for any modifications or discontinuation of services.

6. Limitation of Liability
Infinityminer.net is not responsible for any losses or damages arising from the use of our services, including but not limited to financial losses resulting from fluctuations in cryptocurrency prices.

7. Governing Law
These Terms and Conditions shall be governed by and construed in accordance with the laws applicable in the jurisdiction in which Infinityminer.net operates.

8. Changes to Terms
We may update these Terms and Conditions from time to time. Any changes will be posted on this page with an updated effective date.

By using our services, you acknowledge that you have read, understood, and agree to these Terms and Conditions.
""";
}
