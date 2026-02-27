import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_manager.dart';
import '../../../splash%20&%20onboarding/data/onboarding_list_data.dart';

class OnboardingDotsIndicatorWidget extends StatelessWidget {
  const OnboardingDotsIndicatorWidget({super.key, required int currentIndex})
    : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingListData.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentIndex == index ? 35.w : 8.w,
          height: 5.h,
          margin: EdgeInsets.only(right: 6.w),
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? ColorManager.primary
                : ColorManager.greyDE,
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      }),
    );
  }
}
