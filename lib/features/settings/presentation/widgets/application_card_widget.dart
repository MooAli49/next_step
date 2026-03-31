import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../apply/data/models/user_application_job_model.dart';

class ApplicationCardWidget extends StatelessWidget {
  final UserApplicationJobModel application;
  final Function(String)? onDelete;

  const ApplicationCardWidget({
    super.key,
    required this.application,
    this.onDelete,
  });

  Color _getStatusColor() {
    switch (application.status?.toUpperCase()) {
      case 'ACCEPTED':
        return ColorManager.green;
      case 'REJECTED':
        return ColorManager.red;
      case 'PENDING':
        return Color(0xFFFFA500);
      default:
        return ColorManager.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.greyEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  application.jobInfo?.postedBy?.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported_outlined,
                    color: ColorManager.grey,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.jobInfo?.title ?? 'Unknown Job',
                      style: AppStyles.font16w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      application.coverLetter ?? 'Unknown',
                      style: TextStyle(
                        color: ColorManager.grey,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  application.status?.toUpperCase() ?? 'PENDING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16.sp,
                color: ColorManager.grey,
              ),
              SizedBox(width: 8.w),
              Text(
                'Applied ${_formatDate(application.appliedAt)}',
                style: TextStyle(color: ColorManager.grey, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final jobId = application.jobInfo?.id ?? '';

                    if (jobId.isNotEmpty) {
                      Get.toNamed(
                        Routes.jobDetails,
                        parameters: {'jobId': jobId},
                      );
                    } else {
                      Get.snackbar(
                        'Job not available',
                        'Could not open job details for this application.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.greyF3,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (onDelete != null) {
                      onDelete!(application.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.red.withValues(alpha: 0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: ColorManager.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('d MMM, yyyy').format(date);
    }
  }
}
