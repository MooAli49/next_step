import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/routing/routes.dart';

class ApplyResultScreen extends StatelessWidget {
  final bool isSuccess;
  final String? jobId;

  const ApplyResultScreen({super.key, this.isSuccess = true, this.jobId});

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circle with Icon
              Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSuccess ? Color(0xFFD4F1ED) : Color(0xFFFAD4D4),
                ),
                child: Center(
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSuccess ? Color(0xFF00C853) : Color(0xFFE53935),
                    ),
                    child: Center(
                      child: Icon(
                        isSuccess ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 60.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              // Title
              Text(
                isSuccess ? "You've Applied" : 'Application Failed',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              // Description
              Text(
                isSuccess
                    ? "Thank you for applying. We've received your application and will be in touch soon."
                    : "We couldn't process your job application. Please try again or contact support if the issue persists.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 56.h),
              // Back To Home Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D988C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () => Get.offNamed(Routes.layout),
                  child: Text(
                    'Back To Home',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // See Applied Job Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF0D988C), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    if (jobId != null) {
                      Get.toNamed(
                        Routes.jobDetails,
                        arguments: {'jobId': jobId},
                      );
                    }
                  },
                  child: Text(
                    'See Applied Job',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D988C),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
