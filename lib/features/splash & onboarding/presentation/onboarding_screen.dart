import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extension/spacer.dart';
import '../../../core/styles/app_styles.dart';
import '../../../core/theme/color_manager.dart';
import '../../../core/widgets/primary_button_widget.dart';
import '../../splash%20&%20onboarding/controller/onboarding_controller.dart';
import '../../splash%20&%20onboarding/data/onboarding_list_data.dart';
import '../../splash%20&%20onboarding/presentation/widget/onboarding_dots_indicator_widget.dart';
import '../../splash%20&%20onboarding/presentation/widget/onboarding_page_view_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.find<OnboardingController>();
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingPageViewWidget(onboardingController.pageController),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 30.h,
              ),
              child: Column(
                children: [
                  OnboardingDotsIndicatorWidget(
                    currentIndex: onboardingController.currentIndex.value,
                  ),
                  VerticalSpace(40),
                  PrimaryButtonWidget(
                    buttonText:
                        onboardingController.currentIndex.value ==
                            onboardingListData.length - 1
                        ? "Get Started"
                        : "Next",
                    onPressed: onboardingController.onNextPressed,
                  ),
                  VerticalSpace(16),
                  TextButton(
                    onPressed: onboardingController.onSkipPressed,
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
