import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class FindYourJobSection extends StatelessWidget {
  const FindYourJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Find Your Job', style: AppStyles.font20w700),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.jobDetails),
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
                      Image.asset('assets/images/remote_job.png', height: 60.h),
                      SizedBox(height: 16.h),
                      Text('74.5K', style: AppStyles.font20w700),
                      SizedBox(height: 8.h),
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
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                children: [
                  _buildSmallCard(
                    '33.8K',
                    'Part Time',
                    'assets/images/part_time_job.png',
                  ),
                  SizedBox(height: 16.h),
                  _buildSmallCard(
                    '23.8K',
                    'Full Time',
                    'assets/images/full_time_job.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCard(String count, String label, String imagePath) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.jobDetails),
      child: Container(
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(count, style: AppStyles.font16w600),
                  SizedBox(height: 4.h),
                  Text(
                    label,
                    style: TextStyle(color: ColorManager.grey, fontSize: 13.sp),
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
