import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/color_manager.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';
import '../widgets/empty_search_widget.dart';
import '../widgets/search_filter_bottom_sheet.dart';
import '../widgets/search_job_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    // Load all jobs when screen is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<JobController>();
      controller.getAllJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _buildSearchBar(controller),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : controller.jobs.isEmpty
                        ? const EmptySearchWidget()
                        : NotificationListener<ScrollNotification>(
                            onNotification: (notification) =>
                                _onScroll(notification, controller),
                            child: ListView.builder(
                              itemCount: controller.jobs.length,
                              itemBuilder: (context, index) {
                                final job = controller.jobs[index];
                                return SearchJobCardWidget(
                                  job: job,
                                  onBookmarkToggle: () {
                                    controller.toggleFavorite(job.id);
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                  controller.isLoadingMore
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(JobController controller) {
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
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                controller.searchLocalJobs(val);
              },
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: Get.context!,
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

  bool _onScroll(ScrollNotification notification, JobController controller) {
    final maxScroll = notification.metrics.maxScrollExtent;
    final currentScroll = notification.metrics.pixels;
    final triggerDistance = 200.0; // Distance from bottom to trigger load more

    if (notification is ScrollEndNotification) {
      if (maxScroll - currentScroll <= triggerDistance &&
          !controller.isLoadingMore) {
        controller.loadMoreJobs();
      }
    }
    return false;
  }
}
