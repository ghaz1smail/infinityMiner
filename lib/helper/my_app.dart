import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/helper/languages.dart';
import 'package:infinityminer/app/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => GetMaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        defaultTransition: Transition.fade,
        getPages: AppRoutes().pagesRoutes,
        locale: const Locale('en'),
        translations: Languages(),
        theme: appTheme.theme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
