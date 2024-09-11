import 'package:get/get.dart';
import 'package:infinityminer/admin/admin_acreen.dart';
import 'package:infinityminer/view/register/forget_screen.dart';
import 'package:infinityminer/view/register/register_screen.dart';
import 'package:infinityminer/view/screens/splash_screen.dart';
import 'package:infinityminer/view/user/user_screen.dart';

class Routes {
  List<GetPage<dynamic>>? pagesRoutes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => const RegisterScreen()),
    GetPage(name: '/user', page: () => const UserScreen()),
    GetPage(name: '/admin', page: () => const AdminScreen()),
    GetPage(name: '/fogot-password', page: () => const ForgetScreen()),
  ];
}
