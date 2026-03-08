import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routing/routes.dart';
import '../services/cache_service.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final cacheService = Get.find<CacheService>();

    if (cacheService.isLoggedIn()) {
      if (!cacheService.isProfileCompleted()) {
        return const RouteSettings(name: Routes.profileSetup);
      }
      return const RouteSettings(name: Routes.layout);
    }

    return null;
  }
}
