import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: AppStyles.font20w700.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('1. Information We Collect', [
              'Personal Information: Name, email address, phone number, and profile picture.',
              'Professional Information: Your CV/Resume, work experience, education, and skills.',
              'Device Information: IP address, device type, and operating system (collected via our Node.js API).',
              'Usage Data: How you interact with the app, jobs searched, and applications sent.',
            ]),
            SizedBox(height: 24.h),
            _buildSection('2. Data Sharing and Disclosure', [
              'With Employers: When you apply for a job, your profile and CV are shared with the respective employer.',
              'Legal Requirements: We may disclose info if required by law or to protect our rights.',
              'Service Providers: We may use third-party tools for analytics or hosting (e.g., Supabase or AWS).',
            ]),
            SizedBox(height: 24.h),
            _buildTextSection(
              '3. Data Security',
              'We implement industry-standard security measures (SSL encryption, secure API headers) to protect your data. However, no method of transmission over the internet is 100% secure.',
            ),
            SizedBox(height: 24.h),
            _buildTextSection(
              '4. User Rights',
              'You have the right to access, update, or delete your personal data at any time through your account settings.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> bulletPoints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        ...bulletPoints.map(
          (point) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6.h, right: 8.w),
                  height: 4.w,
                  width: 4.w,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: TextStyle(
                      fontSize: 13.sp,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.font16w600),
        SizedBox(height: 12.h),
        Text(
          content,
          style: TextStyle(fontSize: 13.sp, height: 1.5, color: Colors.black87),
        ),
      ],
    );
  }
}
