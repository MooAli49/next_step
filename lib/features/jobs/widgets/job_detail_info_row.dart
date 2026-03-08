import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class JobDetailInfoRow extends StatelessWidget {
  const JobDetailInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoItem('Experience', '4 - 6 years'),
            _buildDivider(),
            _buildInfoItem('Job Type', 'Full Time'),
            _buildDivider(),
            _buildInfoItem('Level', 'Entry level'),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Updated 3 days ago',
          style: TextStyle(color: ColorManager.grey99, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: ColorManager.grey, fontSize: 12.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppStyles.font13w500.copyWith(
            color: ColorManager.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30.h, width: 1.w, color: ColorManager.greyEE);
  }
}
