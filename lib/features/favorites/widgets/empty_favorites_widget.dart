import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../core/constants/app_image.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImage.emptyFavorites, height: 160.h),
            SizedBox(height: 24.h),
            Text(
              'Start Building Your Shortlist',
              style: AppStyles.font20w700.copyWith(
                color: ColorManager.black,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Save jobs you\'re interested in by clicking the bookmark icon. Your saved jobs will appear here for easy access.',
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
