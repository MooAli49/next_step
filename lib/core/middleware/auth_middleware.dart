import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routing/routes.dart';
import '../services/cache_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final cacheService = Get.find<CacheService>();

    if (!cacheService.isLoggedIn()) {
      return const RouteSettings(name: Routes.login);
    }

    // Redirect to profile setup if profile is incomplete
    // (skip if already navigating to profile-setup to avoid loop)
    if (!cacheService.isProfileCompleted() && route != Routes.profileSetup) {
      return const RouteSettings(name: Routes.profileSetup);
    }

    return null;
  }
}
