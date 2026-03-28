import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/extension/spacer.dart';
import '../controllers/complete_profile_controller.dart';

class CareerInterestsWidget extends GetView<CompleteProfileController> {
  const CareerInterestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Career Interests",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          "Select the job roles you're passionate about to personalize your opportunities.",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: Obx(() {
            if (controller.jobRoles.isEmpty) {
              return const Center(child: Text("No job roles available"));
            }
            return ListView.separated(
              itemCount: controller.jobRoles.length,
              separatorBuilder: (context, index) => VerticalSpace(12),
              itemBuilder: (context, index) {
                final role = controller.jobRoles[index];
                return Obx(() {
                  final isSelected = controller.selectedJobRoles.contains(
                    role.id,
                  );
                  return InkWell(
                    onTap: () => controller.toggleJobRole(role.id),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal.withValues(alpha: 0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected ? Colors.teal : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              role.label,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.teal
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Colors.teal,
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );
          }),
        ),
        Obx(
          () => Text(
            "${controller.selectedJobRoles.length} roles selected",
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
