import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../apply/data/models/user_applications_model/user_applications_model.dart';

class ApplicationCardWidget extends StatelessWidget {
  final UserApplicationsModel application;
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.job?.title ?? 'Unknown Job',
                      style: AppStyles.font16w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      application.job?.postedBy?.fullName ?? 'Unknown',
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
                    Get.toNamed(
                      Routes.jobDetails,
                      arguments: {'jobId': application.job?.id},
                    );
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
                      onDelete!(application.id ?? '');
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

/*
  {
    "id": "72979231-5641-4195-844f-cee9ef74192a",
    "jobId": "56a8d11e-6eec-49a9-983e-02254c01459e",
    "applicantId": "a3adf7b7-80e1-4c3e-8c8f-27894f6a2c88",
    "coverLetter": "hi dear",
    "resumeUrl": "https://cygiwbzhbqqgxeecttvh.supabase.co/storage/v1/object/public/cv-storage/cv_1774816369179_Flutter_Developer_Mohamed_Ali.pdf",
    "status": "PENDING",
    "appliedAt": "2026-03-29T20:34:09.035Z",
    "job": {
    "id": "56a8d11e-6eec-49a9-983e-02254c01459e",
    "title": "Blockchain Developer",
    "postedBy": {
    "id": "550e8400-e29b-41d4-a716-446655440004",
    "fullName": "David Davis",
    "email": "recruiter3@nextstep.com",
    "role": "RECRUITER",
    "imageUrl": "https://www.4cornerresources.com/wp-content/uploads/2025/05/recruiter-having-trouble-finding-candidates.png"
    }
    }
},
 */
