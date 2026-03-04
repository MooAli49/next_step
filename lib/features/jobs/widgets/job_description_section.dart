import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class JobDescriptionSection extends StatelessWidget {
  const JobDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Job Description', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        Text(
          'Conduct user research to inform product design decisions. Plan and execute usability studies, interviews, and surveys.',
          style: TextStyle(
            color: ColorManager.grey,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        SizedBox(height: 24.h),
        Text('Responsibilities', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        _buildBulletPoint('Plan and conduct user research studies'),
        _buildBulletPoint('Analyze research data and synthesize insights'),
        _buildBulletPoint('Create user personas and journey maps'),
        _buildBulletPoint('Present findings to stakeholders'),
        _buildBulletPoint('Collaborate with designers and product managers'),
        SizedBox(height: 24.h),
        Text('Requirements', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        _buildBulletPoint(
          'Bachelor\'s degree in HCI, Psychology, or related field',
        ),
        _buildBulletPoint('3+ years UX research experience'),
        _buildBulletPoint(
          'Experience with qualitative and quantitative methods',
        ),
        _buildBulletPoint('Strong analytical skills'),
        _buildBulletPoint('Excellent presentation abilities'),
        SizedBox(height: 24.h),
        Text('Benefits', style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        _buildBulletPoint('Competitive Salary'),
        _buildBulletPoint('Health Insurance'),
        _buildBulletPoint('Remote Work Options'),
        _buildBulletPoint('Research Tools'),
        _buildBulletPoint('Conference Budget'),
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
