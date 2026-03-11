import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/core/constants/app_image.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class JobDetailHeader extends StatelessWidget {
  const JobDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text(
              'Details',
              style: AppStyles.font20w700.copyWith(fontSize: 18.sp),
            ),
            Icon(
              Icons.bookmark_border,
              color: ColorManager.primary,
              size: 24.sp,
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Container(
              height: 56.w,
              width: 56.w,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorManager.greyF3,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.asset(AppImage.googleLogo),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ui Designer', style: AppStyles.font20w700),
                SizedBox(height: 4.h),
                Text(
                  'Google',
                  style: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.near_me_outlined,
              color: ColorManager.black,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'California',
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.credit_card_outlined,
              color: ColorManager.black,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              '\$ 14,000',
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
