import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/routing/routes.dart';
import 'features/splash%20&%20onboarding/presentation/splash_screen.dart';

class NextStep extends StatelessWidget {
  const NextStep({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        child: SplashScreen(),
      ),
      initialRoute: Routes.splash,
      getPages: Routes.getPages,
    );
  }
}
