import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extension/spacer.dart';
import '../../../core/routing/routes.dart';
import '../../../core/styles/app_styles.dart';
import '../../../core/theme/color_manager.dart';
import '../../../core/widgets/primary_button_widget.dart';
import '../../splash%20&%20onboarding/data/onboarding_list_data.dart';
import '../../splash%20&%20onboarding/presentation/widget/onboarding_dots_indicator_widget.dart';
import '../../splash%20&%20onboarding/presentation/widget/onboarding_page_view_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _onPageChange();
  }

  void _onPageChange() {
    _pageController.addListener(() {
      int newIndex = _pageController.page?.round() ?? 0;
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(() {});
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentIndex < onboardingListData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _onSkipPressed() {
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Get.offAllNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingPageViewWidget(_pageController),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 30.h,
              ),
              child: Column(
                children: [
                  OnboardingDotsIndicatorWidget(currentIndex: _currentIndex),
                  VerticalSpace(40),
                  PrimaryButtonWidget(
                    buttonText: _currentIndex == onboardingListData.length - 1
                        ? "Get Started"
                        : "Next",
                    onPressed: _onNextPressed,
                  ),
                  VerticalSpace(16),
                  TextButton(
                    onPressed: _onSkipPressed,
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 45.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Skip",
                      style: AppStyles.font16w600.copyWith(
                        color: ColorManager.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
