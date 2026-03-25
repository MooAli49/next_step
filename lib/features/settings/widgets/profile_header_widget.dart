import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../core/constants/app_image.dart';
import '../presentation/controllers/update_profile_controller.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final bool showEditIcon;

  const ProfileHeaderWidget({super.key, this.showEditIcon = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProfileController>(
      builder: (controller) {
        final user = controller.user;

        return Container(
          color: ColorManager.primary,
          width: double.infinity,
          padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
          child: Column(
            children: [
              Stack(
                children: [
                  _buildProfileImage(user?.imageUrl),
                  if (showEditIcon)
                    Positioned(
                      right: -5,
                      top: -5,
                      child: GestureDetector(
                        onTap: () => _showBottomSheetOptions(context),
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
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                user?.fullName ?? 'Guest',
                style: AppStyles.font20w700.copyWith(color: Colors.white),
              ),
              SizedBox(height: 4.h),
              Text(
                user?.email ?? '',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        height: 80.w,
        width: 80.w,
        child: hasImage
            ? _buildUserImage(imageUrl)
            : Image.asset(AppImage.userAvatar, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildUserImage(String imageUrl) {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // Add cache-busting parameter to force fresh network fetch
      final cacheBustingUrl = Uri.parse(imageUrl).hasQuery
          ? '$imageUrl&v=${DateTime.now().millisecondsSinceEpoch}'
          : '$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}';

      log('Loading profile image from URL: $cacheBustingUrl');

      return Image.network(
        cacheBustingUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return Image.asset(AppImage.userAvatar, fit: BoxFit.cover);
        },
      );
    }

    return Image.file(
      File(imageUrl),
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return Image.asset(AppImage.userAvatar, fit: BoxFit.cover);
      },
    );
  }

  void _showBottomSheetOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  Get.find<UpdateProfileController>().pickPictureFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  Get.find<UpdateProfileController>().pickPictureFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
