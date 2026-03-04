import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class BrowseCategorySection extends StatelessWidget {
  const BrowseCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Browse by category', style: AppStyles.font16w600),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryItem('Company', 'assets/images/company.png', true),
            _buildCategoryItem(
              'Part Time',
              'assets/images/part_time_job.png',
              false,
            ),
            _buildCategoryItem(
              'Full Time',
              'assets/images/full_time_job.png',
              false,
            ),
            _buildCategoryItem(
              'Freelancer',
              'assets/images/freelancer.png',
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String imagePath, bool isSelected) {
    return Column(
      children: [
        Container(
          height: 60.w,
          width: 60.w,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? ColorManager.primary : ColorManager.greyEE,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Center(
            child: Image.asset(imagePath, height: 32.h, width: 32.w),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? ColorManager.primary : ColorManager.black,
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
