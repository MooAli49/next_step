import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:next_step/core/constants/app_image.dart';
import 'package:next_step/core/routing/routes.dart';
import 'package:next_step/core/theme/color_manager.dart';

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
        Get.offAllNamed(Routes.onboarding);
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
