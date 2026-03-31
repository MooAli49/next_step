import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../jobs/data/models/job_model.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';

class SearchJobCardWidget extends StatelessWidget {
  final JobModel job;
  final VoidCallback onBookmarkToggle;

  const SearchJobCardWidget({
    super.key,
    required this.job,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    final JobController jobController = Get.find<JobController>();

    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.jobDetails, parameters: {'jobId': job.id}),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.greyEE),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48.w,
                  width: 48.w,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorManager.greyF3,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.network(
                    job.postedBy?.imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        color: ColorManager.grey,
                        size: 24.sp,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title ?? '',
                        style: AppStyles.font16w600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        job.postedBy?.fullName ?? '',
                        style: TextStyle(
                          color: ColorManager.grey,
                          fontSize: 13.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onBookmarkToggle,
                  child: Icon(
                    jobController.isFavorite(job.id)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: ColorManager.primary,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTag(job.jobType ?? ''),
                  SizedBox(width: 8.w),
                  _buildTag(job.jobLevel ?? ''),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        color: ColorManager.black,
                        size: 20.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          job.location ?? '',
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    job.salaryRange ?? '',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorManager.primary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
