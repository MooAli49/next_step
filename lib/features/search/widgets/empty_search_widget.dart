import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../core/constants/app_image.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImage.search1, height: 150.h),
            SizedBox(height: 24.h),
            Text(
              'No Results Found',
              style: AppStyles.font20w700.copyWith(color: ColorManager.black),
            ),
            SizedBox(height: 12.h),
            Text(
              'No jobs found matching your search. Try different keywords or browse all available positions',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManager.grey,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
