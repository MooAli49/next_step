import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../core/constants/app_image.dart';
import '../../../../core/extension/spacer.dart';

class BrowseCategorySection extends StatelessWidget {
  const BrowseCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Browse by category', style: AppStyles.font16w600),
        VerticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryItem('Company', AppImage.imageCompany, true),
            _buildCategoryItem('Part Time', AppImage.imagePartTimeJob, false),
            _buildCategoryItem('Full Time', AppImage.imageFullTimeJob, false),
            _buildCategoryItem('Freelancer', AppImage.imageFreelancer, false),
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
        VerticalSpace(8),
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
