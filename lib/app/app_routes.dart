import 'package:get/get.dart';
import 'package:infinityminer/admin/admin_acreen.dart';
import 'package:infinityminer/view/refer_code/refer_code_screen.dart';
import 'package:infinityminer/view/user/contact_us/contact_us_screen.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/register/forget_screen.dart';
import 'package:infinityminer/view/register/register_screen.dart';
import 'package:infinityminer/view/user/mine/mine_screen.dart';
import 'package:infinityminer/view/user/profile/profile_screen.dart';
import 'package:infinityminer/view/user/user_screen.dart';
import 'package:infinityminer/view/user/wallet/wallet_screen.dart';

class AppRoutes {
  List<GetPage<dynamic>>? pagesRoutes = [
    GetPage(name: '/', page: () => const RegisterScreen()),
    GetPage(name: '/home', page: () => const UserScreen()),
    GetPage(name: '/admin', page: () => const AdminScreen()),
    GetPage(name: '/fogot-password', page: () => const ForgetScreen()),
    GetPage(name: '/mining-devices', page: () => const MiningDevicesScreen()),
    GetPage(name: '/wallet', page: () => const WalletScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/contact-us', page: () => const ContactUsScreen()),
    GetPage(name: '/mine', page: () => const MineScreen()),
    GetPage(name: '/refer-code/:userId', page: () => const ReferCodeScreen()),
  ];
}
