import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/color_manager.dart';
import '../controllers/job_controller.dart';
import '../widgets/job_description_section.dart';
import '../widgets/job_detail_header.dart';
import '../widgets/job_detail_info_row.dart';
import '../widgets/job_skills_section.dart';

class JobDetailScreen extends GetView<JobController> {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<JobController>(
          builder: (jobController) {
            if (jobController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (jobController.currentJob == null) {
              return const Center(
                child: Text('Job not found'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JobDetailHeader(job: jobController.currentJob!),
                        SizedBox(height: 24.h),
                        JobDetailInfoRow(job: jobController.currentJob!),
                        SizedBox(height: 24.h),
                        JobSkillsSection(job: jobController.currentJob!),
                        SizedBox(height: 24.h),
                        JobDescriptionSection(job: jobController.currentJob!),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
                _buildBottomApplyButton(jobController),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomApplyButton(JobController jobController) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
            jobController.applyToJob();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Apply Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
