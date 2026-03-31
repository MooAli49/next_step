import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/apply_controller.dart';

class ApplyScreen extends GetView<ApplyController> {
  const ApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Apply Job',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<ApplyController>(
        builder: (_) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Upload CV',
                    'Add your CV/Resume to apply for a job',
                  ),
                  SizedBox(height: 16.h),
                  _buildUploadCVBox(controller),
                  SizedBox(height: 32.h),
                  _buildSectionHeader(
                    'Information',
                    'Explain why you are the right person for this job',
                  ),
                  SizedBox(height: 16.h),
                  _buildCoverLetterInput(controller),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<ApplyController>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(24.w),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D988C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: controller.isLoading
                    ? null
                    : () => controller.submitApplication(),
                child: controller.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildUploadCVBox(ApplyController controller) {
    return GestureDetector(
      onTap: () => controller.pickCV(),
      child: Container(
        width: double.infinity,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: controller.cvPath != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file, color: Color(0xFF0D988C)),
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            controller.cvPath!.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: controller.removeCV,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: Colors.black),
                  SizedBox(width: 8.w),
                  Text(
                    'Upload CV/Resume',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCoverLetterInput(ApplyController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller.coverLetterController,
        onTapOutside: (event) => FocusScope.of(Get.context!).unfocus(),
        maxLines: 6,
        decoration: InputDecoration(
          hintText: 'Dear Hiring Manager...',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a cover letter';
          }
          return null;
        },
      ),
    );
  }
}
