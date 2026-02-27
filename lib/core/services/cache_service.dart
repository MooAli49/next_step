import 'package:get/get.dart';

import '../constants/cache_constants.dart';
import '../utils/cache_helper.dart';

class CacheService extends GetxService {
  Future<CacheService> init() async {
    await CacheHelper.init();

    return this;
  }

  Future<void> setOnboardingCompleted() async {
    await CacheHelper.set(
      key: CacheConstants.isOnboardingCompleted,
      value: true,
    );
  }

  bool isOnboardingCompleted() {
    return CacheHelper.getBool(key: CacheConstants.isOnboardingCompleted) ??
        false;
  }

  bool isLoggedIn() {
    return CacheHelper.getBool(key: CacheConstants.isUserLoggedIn) ?? false;
  }

  Future<bool> isAuthenticated() async {
    final token = await CacheHelper.getSecureData(
      key: CacheConstants.accessToken,
    );
    return token != null && token.isNotEmpty;
  }

  bool hasUserData() {
    return CacheHelper.getMap(key: CacheConstants.userData) != null;
  }
}
