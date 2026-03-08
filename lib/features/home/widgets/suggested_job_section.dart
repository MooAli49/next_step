import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class SuggestedJobSection extends StatelessWidget {
  const SuggestedJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Suggested Job', style: AppStyles.font16w600),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.jobDetails),
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorManager.greyEE),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48.w,
                      width: 48.w,
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: ColorManager.greyF3,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset('assets/images/google.png'),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ui Designer', style: AppStyles.font16w600),
                          SizedBox(height: 4.h),
                          Text(
                            'Google',
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: ColorManager.primary,
                      size: 24.sp,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _buildTag('Design'),
                    SizedBox(width: 8.w),
                    _buildTag('Full Time'),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.near_me_outlined,
                          color: ColorManager.black,
                          size: 20.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'California',
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$15/Mo',
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorManager.primary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
