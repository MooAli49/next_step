import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../controllers/job_controller.dart';

class JobDetailHeader extends GetView<JobController> {
  const JobDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text(
              'Details',
              style: AppStyles.font20w700.copyWith(fontSize: 18.sp),
            ),
            IconButton(
              icon: Icon(
                (controller.currentJob?.isFavorite ?? false)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: ColorManager.primary,
                size: 24.sp,
              ),
              onPressed: () {
                controller.toggleFavorite(controller.currentJob?.id ?? '');
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Container(
              height: 56.w,
              width: 56.w,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorManager.greyF3,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.network(
                controller.currentJob?.postedBy?.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported_outlined,
                  color: ColorManager.grey,
                  size: 32.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.currentJob?.title ?? '',
                    style: AppStyles.font20w700,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    controller.currentJob?.postedBy?.fullName ?? '',
                    style: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.near_me_outlined,
              color: ColorManager.black,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                controller.currentJob?.location ?? '',
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.credit_card_outlined,
              color: ColorManager.black,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '${controller.currentJob?.salaryRange}',
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
