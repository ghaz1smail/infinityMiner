import 'package:get/get.dart';
import 'package:infinityminer/view/admin/admin_message_details.dart';
import 'package:infinityminer/view/admin/admin_user_details_screen.dart';
import 'package:infinityminer/view/admin/admin_acreen.dart';
import 'package:infinityminer/view/admin/admin_request_details.dart';
import 'package:infinityminer/view/admin/admin_withdraw_details.dart';
import 'package:infinityminer/view/admin/admin_withdraw_screen.dart';
import 'package:infinityminer/view/refer_code/refer_code_screen.dart';
import 'package:infinityminer/view/register/privacy_policy_screen.dart';
import 'package:infinityminer/view/user/contact_us/contact_us_screen.dart';
import 'package:infinityminer/view/user/contact_us/replies_screen.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/register/forget_screen.dart';
import 'package:infinityminer/view/register/register_screen.dart';
import 'package:infinityminer/view/user/profile/members_screen.dart';
import 'package:infinityminer/view/user/profile/profile_screen.dart';
import 'package:infinityminer/view/user/user_screen.dart';
import 'package:infinityminer/view/user/wallet/wallet_screen.dart';

class AppRoutes {
  List<GetPage<dynamic>>? pagesRoutes = [
    GetPage(name: '/members', page: () => const MembersScreen()),
    GetPage(name: '/', page: () => const RegisterScreen()),
    GetPage(name: '/home', page: () => const UserScreen()),
    GetPage(
      name: '/admin',
      page: () => const AdminScreen(),
    ),
    GetPage(
      name: '/withdraw',
      page: () => const AdminWithdrawScreen(),
    ),
    GetPage(
      name: '/privacy-policy',
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: '/replies',
      page: () => const RepliesScreen(),
    ),
    GetPage(name: '/fogot-password', page: () => const ForgetScreen()),
    GetPage(name: '/mining-devices', page: () => const MiningDevicesScreen()),
    GetPage(name: '/wallet', page: () => const WalletScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/contact-us', page: () => const ContactUsScreen()),
    GetPage(name: '/refer-code/:userId', page: () => const ReferCodeScreen()),
    GetPage(
        name: '/request-details/:id', page: () => const AdminRequestDetails()),
    GetPage(
        name: '/withdraw-details/:id',
        page: () => const AdminWithdrawDetailsScreen()),
    GetPage(
        name: '/user-details/:uid', page: () => const AdminUserDetailsScreen()),
    GetPage(
        name: '/message-details/:id',
        page: () => const AdminMessageDetailsScreen()),
  ];
}
