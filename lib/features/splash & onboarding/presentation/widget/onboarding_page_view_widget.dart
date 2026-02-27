import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extension/spacer.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../splash%20&%20onboarding/data/onboarding_list_data.dart';

class OnboardingPageViewWidget extends StatelessWidget {
  const OnboardingPageViewWidget(this.pageController, {super.key});
  final PageController pageController;
  // final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        // onPageChanged: onPageChanged,
        itemCount: onboardingListData.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerticalSpace(40),
                Image.asset(
                  onboardingListData[index].image,
                  width: 316.w,
                  height: 316.h,
                  fit: BoxFit.contain,
                ),
                VerticalSpace(30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    onboardingListData[index].title,
                    style: AppStyles.font20w700.copyWith(
                      color: ColorManager.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                VerticalSpace(18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    onboardingListData[index].description,
                    style: AppStyles.font16w400.copyWith(
                      color: ColorManager.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
