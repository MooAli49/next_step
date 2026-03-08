import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
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
            _buildTextSection(
              '1. Acceptance of Terms',
              'By downloading or using NextStep, you agree to be bound by these Terms and Conditions. If you do not agree, please do not use the service.',
            ),
            SizedBox(height: 24.h),
            _buildTextSection(
              '2. Role of the Application',
              'NextStep is a platform connecting job seekers and employers. We do not guarantee employment, and we are not responsible for the hiring decisions, workplace conditions, or the accuracy of job postings provided by third-party employers.',
            ),
            SizedBox(height: 24.h),
            _buildTextSection(
              '3. Intellectual Property',
              'The design, code (Flutter & Node.js), and logos of [App Name] are the property of the developer and are protected by copyright laws.',
            ),
            SizedBox(height: 24.h),
            _buildTextSection(
              '4. Termination',
              'We reserve the right to suspend or terminate accounts that violate these terms or engage in fraudulent activity without prior notice.',
            ),
            SizedBox(height: 24.h),
            _buildTextSection(
              '5. Limitation of Liability',
              'NextStep shall not be liable for any indirect or consequential damages arising from your use of the application.',
            ),
          ],
        ),
      ),
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
