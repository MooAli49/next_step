import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/browse_category_section.dart';
import '../widgets/find_your_job_section.dart';
import '../widgets/home_header.dart';
import '../widgets/home_promo_banner.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/suggested_job_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              SizedBox(height: 24.h),
              const HomeSearchBar(),
              SizedBox(height: 24.h),
              const HomePromoBanner(),
              SizedBox(height: 24.h),
              const FindYourJobSection(),
              SizedBox(height: 24.h),
              const BrowseCategorySection(),
              SizedBox(height: 24.h),
              const SuggestedJobSection(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
