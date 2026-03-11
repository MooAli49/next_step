import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../core/constants/app_image.dart';
import '../../search/widgets/search_job_card_widget.dart';
import '../widgets/empty_favorites_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Toggle this to test empty/populated states
  final bool _hasFavorites = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _hasFavorites
          ? AppBar(
              title: Text(
                'Jobs Saved',
                style: AppStyles.font20w700.copyWith(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete All',
                    style: TextStyle(
                      color: ColorManager.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: !_hasFavorites
            ? const EmptyFavoritesWidget()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                children: const [
                  SearchJobCardWidget(
                    title: 'Ui Designer',
                    company: 'Google',
                    location: 'California',
                    price: '\$15/Mo',
                    imagePath: AppImage.googleLogo,
                    isBookmarked: true,
                  ),
                  SearchJobCardWidget(
                    title: 'Human Resources Manager',
                    company: 'Facebook',
                    location: 'Chicago, IL',
                    price: '\$15/Mo',
                    imagePath: AppImage.googleLogo,
                    isBookmarked: true,
                  ),
                  SearchJobCardWidget(
                    title: 'Data Scientist',
                    company: 'xing',
                    location: 'Boston, MA',
                    price: '\$15/Mo',
                    imagePath: AppImage.googleLogo,
                    isBookmarked: true,
                  ),
                  SearchJobCardWidget(
                    title: 'Supply Chain Manager',
                    company: 'mcdonalds',
                    location: 'Boston, MA',
                    price: '\$15/Mo',
                    imagePath: AppImage.googleLogo,
                    isBookmarked: true,
                  ),
                ],
              ),
      ),
    );
  }
}
