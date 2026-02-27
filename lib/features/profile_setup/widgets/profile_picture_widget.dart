import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extension/spacer.dart';
import '../controllers/complete_profile_controller.dart';

class ProfilePictureWidget extends GetView<CompleteProfileController> {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Profile Picture",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        VerticalSpace(8),
        Text(
          "Upload a clear, professional headshot to make a strong first impression on recruiters and potential employers.",
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        Spacer(),
        Obx(() {
          return Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: controller.profilePicturePath.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.file(
                      File(controller.profilePicturePath.value),
                      fit: BoxFit.cover,
                      width: 150.w,
                      height: 150.w,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error_outline,
                          size: 60.sp,
                          color: Colors.red[400],
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.person_outline,
                    size: 60.sp,
                    color: Colors.grey[400],
                  ),
          );
        }),
        VerticalSpace(24),
        Text(
          "Add Your Photo",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpace(8),
        Text(
          "Upload a professional photo to complete your profile",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
        VerticalSpace(24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Show Bottom Sheet
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload Photo",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                      VerticalSpace(16),
                      _buildOption(
                        context,
                        icon: Icons.camera_alt,
                        label: "Take Photo",
                        subLabel: "Use your camera",
                        onTap: () {
                          Get.back();
                          controller.pickPictureFromCamera();
                        },
                      ),
                      VerticalSpace(16),
                      _buildOption(
                        context,
                        icon: Icons.photo_library,
                        label: "Choose from Gallery",
                        subLabel: "Select existing photo",
                        onTap: () {
                          Get.back();
                          controller.pickPictureFromGallery();
                        },
                      ),
                      VerticalSpace(24),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isScrollControlled: true,
              );
            },
            icon: const Icon(Icons.cloud_upload_outlined),
            label: const Text("Upload Photo"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors
                  .grey[100], // Verify color in design, looks light greyish white
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subLabel,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(icon, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  subLabel,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
