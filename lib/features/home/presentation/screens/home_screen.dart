import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/core/extension/spacer.dart';

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
              const VerticalSpace(24),
              const HomeSearchBar(),
              const VerticalSpace(24),
              const HomePromoBanner(),
              const VerticalSpace(24),
              const FindYourJobSection(),
              const VerticalSpace(24),
              const BrowseCategorySection(),
              const VerticalSpace(24),
              const SuggestedJobSection(),
              const VerticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
