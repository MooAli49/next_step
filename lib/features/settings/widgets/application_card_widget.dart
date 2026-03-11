import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/core/constants/app_image.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class ApplicationCardWidget extends StatelessWidget {
  const ApplicationCardWidget({super.key});

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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      AppImage.googleLogo,
                    ), // placeholder image, can match design
                    fit: BoxFit.cover,
                  ),
                ),
                // Wrap in colored border if needed
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Human Resources Manager',
                      style: AppStyles.font16w600,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Facebook',
                      style: TextStyle(
                        color: ColorManager.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.green,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'ACCEPTED',
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
                'Applied Jan 10, 2026',
                style: TextStyle(color: ColorManager.grey, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.red.withValues(alpha: 0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Delete Application',
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
}
