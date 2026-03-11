import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_step/core/constants/app_image.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final bool showEditIcon;

  const ProfileHeaderWidget({super.key, this.showEditIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      width: double.infinity,
      padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 80.w,
                width: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImage.userAvatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (showEditIcon)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 14.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Laith Mahdi',
            style: AppStyles.font20w700.copyWith(color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Text(
            'mahdilaith@gmail.com',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
