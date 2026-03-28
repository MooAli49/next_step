import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/features/jobs/data/models/job_model.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';

class JobSkillsSection extends StatelessWidget {
  const JobSkillsSection({super.key, required this.job});
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            if (job.skills != null)
              ...job.skills!.map((skill) => _buildSkillChip(skill)),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.greyEE,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: ColorManager.grey,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
