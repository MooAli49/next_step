import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../controllers/job_controller.dart';

class JobDetailInfoRow extends GetView<JobController> {
  const JobDetailInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoItem(
              'Experience',
              controller.currentJob?.experience ?? '',
            ),
            _buildDivider(),
            _buildInfoItem('Job Type', controller.currentJob?.jobType ?? ''),
            _buildDivider(),
            _buildInfoItem('Level', controller.currentJob?.jobLevel ?? ''),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Last updated: ${controller.currentJob?.updatedAt != null ? DateFormat.yMMMd().format(controller.currentJob!.updatedAt!) : 'N/A'}',
          style: TextStyle(color: ColorManager.grey99, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: ColorManager.grey, fontSize: 12.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppStyles.font13w500.copyWith(
              color: ColorManager.black,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 30.h, width: 1.w, color: ColorManager.greyEE);
  }
}
