import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extension/spacer.dart';
import '../controllers/complete_profile_controller.dart';

class PreferredLocationsWidget extends GetView<CompleteProfileController> {
  const PreferredLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preferred Work Locations",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          "Choose countries where you'd like to work to see relevant job matches.",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: Obx(() {
            if (controller.countries.isEmpty) {
              return const Center(child: Text('No countries available'));
            }
            return ListView.separated(
              itemCount: controller.countries.length,
              separatorBuilder: (context, index) => VerticalSpace(12),
              itemBuilder: (context, index) {
                final country = controller.countries[index];
                return Obx(() {
                  final isSelected = controller.selectedCountries.contains(
                    country.code,
                  );
                  return InkWell(
                    onTap: () => controller.toggleCountry(country.code),
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
                              country.name,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              country.code,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
            "${controller.selectedCountries.length} locations selected",
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
