import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/features/jobs/data/models/job_model.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';

class JobDetailHeader extends StatelessWidget {
  const JobDetailHeader({super.key, required this.job});
  final JobModel job;

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
            Icon(
              Icons.bookmark_border,
              color: ColorManager.primary,
              size: 24.sp,
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
                job.postedBy?.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title ?? '',
                    style: AppStyles.font20w700,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    job.postedBy?.fullName ?? '',
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
                job.location ?? '',
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
                '${job.salaryRange}',
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
