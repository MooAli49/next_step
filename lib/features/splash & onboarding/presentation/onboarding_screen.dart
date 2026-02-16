import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/core/extension/spacer.dart';
import 'package:next_step/core/styles/app_styles.dart';
import 'package:next_step/core/theme/color_manager.dart';
import 'package:next_step/features/splash%20&%20onboarding/data/onboarding_list_data.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: PageView.builder(
        itemCount: onboardingListData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                onboardingListData[index].image,
                width: 316.w,
                height: 316.h,
              ),
              VerticalSpace(55),
              Text(
                onboardingListData[index].title,
                style: AppStyles.font20w700,
                textAlign: TextAlign.center,
              ),
              VerticalSpace(18),
              Text(
                onboardingListData[index].description,
                style: AppStyles.font16w400.copyWith(color: ColorManager.grey),
                textAlign: TextAlign.center,
              ),
              VerticalSpace(43),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingListData.length, (index) {
                  return Container(
                    width: 35.w,
                    height: 5.h,
                    margin: EdgeInsets.only(right: 5.w),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? ColorManager.primary
                          : ColorManager.whiteED,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  );
                }),
              ),
              VerticalSpace(55),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  // Handle button press
                },
                child: Text(
                  "Get Started",
                  // style: AppStyles.font16w700.copyWith(
                  //   color: ColorManager.white,
                  // ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  // Handle button press
                },
                child: Text(
                  "Skip",
                  // style: AppStyles.font16w700.copyWith(
                  //   color: ColorManager.white,
                  // ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
