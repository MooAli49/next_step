import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:next_step/core/constants/app_image.dart';
import 'package:next_step/core/extension/spacer.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../controllers/home_controller.dart';

class FindYourJobSection extends StatelessWidget {
  const FindYourJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Find Your Job', style: AppStyles.font20w700),
        VerticalSpace(16),
        GetX<HomeController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (controller.hasError) {
              return const Center(
                child: Text(
                  'Failed to load job stats. Please try again later.',
                  style: TextStyle(color: ColorManager.red),
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: ColorManager.greyEE),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.imageRemoteJob, height: 60.h),
                        VerticalSpace(16),
                        Text(
                          '${controller.remoteJobCount}',
                          style: AppStyles.font20w700,
                        ),
                        VerticalSpace(8),
                        Text(
                          'Remote Job',
                          style: TextStyle(
                            color: ColorManager.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HorizontalSpace(16),
                Expanded(
                  child: Column(
                    children: [
                      _buildSmallCard(
                        '${controller.partTimeJobCount}',
                        'Part Time',
                        AppImage.imagePartTimeJob,
                      ),
                      VerticalSpace(16),
                      _buildSmallCard(
                        '${controller.fullTimeJobCount}',
                        'Full Time',
                        AppImage.imageFullTimeJob,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSmallCard(String count, String label, String imagePath) {
    return Container(
      height: 92.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.greyEE),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 40.h, width: 40.w),
          HorizontalSpace(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count, style: AppStyles.font16w600),
                VerticalSpace(4),
                Text(
                  label,
                  style: TextStyle(color: ColorManager.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
