import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routing/routes.dart';
import '../services/cache_service.dart';

class OnboardingMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isOnboardingCompleted = Get.find<CacheService>()
        .isOnboardingCompleted();

    if (isOnboardingCompleted) {
      return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}
