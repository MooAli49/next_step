import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';
import '../../../search/presentation/widgets/search_job_card_widget.dart';
import '../widgets/empty_favorites_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Load favorites when screen is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<JobController>();
      controller.getFavoriteJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
      builder: (controller) {
        final hasFavorites = controller.favoriteJobs.isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: hasFavorites
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
                      onPressed: () {
                        controller.deleteAllFavorites();
                      },
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
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : !hasFavorites
                ? const EmptyFavoritesWidget()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    itemCount: controller.favoriteJobs.length,
                    itemBuilder: (context, index) {
                      final job = controller.favoriteJobs[index];
                      return SearchJobCardWidget(
                        job: job,
                        onBookmarkToggle: () {
                          if (job.id != null) {
                            controller.toggleFavorite(job.id!);
                          }
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
