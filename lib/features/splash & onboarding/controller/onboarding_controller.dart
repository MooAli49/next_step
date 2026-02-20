import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routing/routes.dart';
import '../../../core/services/cache_service.dart';
import '../data/onboarding_list_data.dart';

class OnboardingController extends GetxController {
  late final PageController pageController;
  late final VoidCallback _pageListener;

  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _pageListener = () {
      int newIndex = pageController.page?.round() ?? 0;
      if (newIndex != currentIndex.value) {
        currentIndex.value = newIndex;
      }
    };
    pageController.addListener(_pageListener);
  }

  @override
  void onClose() {
    pageController.removeListener(_pageListener);
    pageController.dispose();
    super.onClose();
  }

  void onNextPressed() {
    if (currentIndex.value < onboardingListData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
      navigateToLogin();
    }
  }

  void onSkipPressed() {
    completeOnboarding();
    navigateToLogin();
  }

  void completeOnboarding() {
    CacheService cacheService = Get.find<CacheService>();
    cacheService.setOnboardingCompleted();
  }

  void navigateToLogin() {
    Get.offAllNamed(Routes.login);
  }
}
