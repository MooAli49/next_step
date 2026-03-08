import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_manager.dart';
import '../widgets/empty_search_widget.dart';
import '../widgets/search_filter_bottom_sheet.dart';
import '../widgets/search_job_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false; // Toggle to show empty state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              _buildSearchBar(),
              SizedBox(height: 24.h),
              Expanded(
                child: _isSearching
                    ? const EmptySearchWidget()
                    : ListView(
                        children: const [
                          SearchJobCardWidget(
                            title: 'Ui Designer',
                            company: 'Google',
                            location: 'Califorina',
                            price: '\$15/Mo',
                            imagePath: 'assets/images/google.png',
                            isBookmarked: true,
                          ),
                          SearchJobCardWidget(
                            title: 'Human Resources Manager',
                            company: 'Facebook',
                            location: 'Chicago, IL',
                            price: '\$15/Mo',
                            imagePath:
                                'assets/images/google.png', // Assuming user applies right asset
                            isBookmarked: true,
                          ),
                          SearchJobCardWidget(
                            title: 'Data Scientist',
                            company: 'xing',
                            location: 'Boston, MA',
                            price: '\$15/Mo',
                            imagePath: 'assets/images/google.png',
                            isBookmarked: true,
                          ),
                          SearchJobCardWidget(
                            title: 'Supply Chain Manager',
                            company: 'mcdonalds',
                            location: 'Boston, MA',
                            price: '\$15/Mo',
                            imagePath: 'assets/images/google.png',
                            isBookmarked: true,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorManager.greyEE),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ...',
                hintStyle: TextStyle(
                  color: ColorManager.greyDE,
                  fontSize: 14.sp,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: ColorManager.primary,
                  size: 24.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              onChanged: (val) {
                // Mocking search empty state based on input
                setState(() {
                  _isSearching = val.isNotEmpty && val.length > 5;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const SearchFilterBottomSheet(),
            );
          },
          child: Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.tune, color: ColorManager.primary, size: 24.sp),
          ),
        ),
      ],
    );
  }
}
