import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/features/jobs/data/models/job_model.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';

class JobDescriptionSection extends StatelessWidget {
  const JobDescriptionSection({super.key, required this.job});
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Job Description', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        Text(
          job.description ?? 'No description available.',
          style: TextStyle(
            color: ColorManager.grey,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        SizedBox(height: 24.h),
        Text('Responsibilities', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        if (job.responsibilities != null)
          ...job.responsibilities!.map((resp) => _buildBulletPoint(resp)),
        SizedBox(height: 24.h),
        Text('Requirements', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        if (job.requirements != null)
          ...job.requirements!.map((req) => _buildBulletPoint(req)),
        SizedBox(height: 24.h),
        Text('Benefits', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        if (job.benefits != null)
          ...job.benefits!.map((benefit) => _buildBulletPoint(benefit)),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h, right: 8.w),
            height: 4.w,
            width: 4.w,
            decoration: const BoxDecoration(
              color: ColorManager.grey,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: ColorManager.grey,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
