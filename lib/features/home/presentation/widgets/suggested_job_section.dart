import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../core/constants/app_image.dart';
import '../../../../core/extension/spacer.dart';
import '../controllers/home_controller.dart';

class SuggestedJobSection extends GetView<HomeController> {
  const SuggestedJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Suggested Job', style: AppStyles.font16w600),
        VerticalSpace(16),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: controller.suggestedJobs?.length ?? 0,
            itemBuilder: (context, index) {
              final job = controller.suggestedJobs![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: GestureDetector(
                  onTap: () => Get.toNamed(
                    Routes.jobDetails,
                    parameters: {'jobId': job.id ?? ''},
                  ),
                  child: Container(
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
                              child: job.company?.imageUrl != null
                                  ? Image.network(
                                      job.company!.imageUrl!,
                                      errorBuilder: (_, _, _) =>
                                          Image.asset(AppImage.googleLogo),
                                    )
                                  : Image.asset(AppImage.googleLogo),
                            ),
                            HorizontalSpace(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title ?? 'Untitled',
                                    style: AppStyles.font16w600,
                                  ),
                                  VerticalSpace(4),
                                  Text(
                                    job.company?.fullName ?? '',
                                    style: TextStyle(
                                      color: ColorManager.grey,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.bookmark_border,
                              color: ColorManager.primary,
                              size: 24.sp,
                            ),
                          ],
                        ),
                        VerticalSpace(16),
                        Row(
                          children: [
                            if (job.jobLevel != null)
                              Flexible(child: _buildTag(job.jobLevel!)),
                            if (job.jobLevel != null && job.jobType != null)
                              HorizontalSpace(8),
                            if (job.jobType != null)
                              Flexible(child: _buildTag(job.jobType!)),
                          ],
                        ),
                        VerticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.near_me_outlined,
                                    color: ColorManager.black,
                                    size: 20.sp,
                                  ),
                                  HorizontalSpace(4),
                                  Flexible(
                                    child: Text(
                                      job.location ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: ColorManager.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            HorizontalSpace(8),
                            Text(
                              job.salaryRange ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorManager.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      ),
    );
  }
}
