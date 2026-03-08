import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_image.dart';
import '../../../core/routing/routes.dart';
import '../../../core/services/cache_service.dart';
import '../../../core/theme/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slidingAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _animateToOnboarding();
  }

  void _animateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final cacheService = Get.find<CacheService>();

        if (!cacheService.isOnboardingCompleted()) {
          Get.offAllNamed(Routes.onboarding);
        } else if (!cacheService.isLoggedIn()) {
          Get.offAllNamed(Routes.login);
        } else if (!cacheService.isProfileCompleted()) {
          Get.offAllNamed(Routes.profileSetup);
        } else {
          Get.offAllNamed(Routes.layout);
        }
      }
    });
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(5, 0),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppImage.logoWhite, width: 140.w, height: 70.h),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: -50.w,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                  position: _slidingAnimation,
                  child: child,
                );
              },
              child: Opacity(
                opacity: .4,
                child: Image.asset(
                  AppImage.imageArrow,
                  width: 120.w,
                  height: 100.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
