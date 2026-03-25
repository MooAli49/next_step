import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:next_step/features/jobs/data/models/job_model.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';

class JobDetailInfoRow extends StatelessWidget {
  const JobDetailInfoRow({super.key, required this.job});
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoItem('Experience', job.experience ?? ''),
            _buildDivider(),
            _buildInfoItem('Job Type', job.jobType ?? ''),
            _buildDivider(),
            _buildInfoItem('Level', job.jobLevel ?? ''),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Last updated: ${job.updatedAt != null ? DateFormat.yMMMd().format(job.updatedAt!) : 'N/A'}',
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
