import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../controllers/my_applications_controller.dart';
import '../widgets/application_card_widget.dart';

class MyApplicationsScreen extends GetView<MyApplicationsController> {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Applications',
          style: AppStyles.font20w700.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: controller.allApplications.isEmpty
                ? null
                : () => controller.deleteAllApplications(),
            child: const Text(
              'Delete All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: GetBuilder<MyApplicationsController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Track all your job applications',
                        style: TextStyle(
                          color: ColorManager.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          _buildTab(
                            'ALL (${controller.getApplicationCount('ALL')})',
                            controller.selectedStatus == 'ALL',
                            () => controller.filterApplications('ALL'),
                          ),
                          _buildTab(
                            'REJECTED (${controller.getApplicationCount('REJECTED')})',
                            controller.selectedStatus == 'REJECTED',
                            () => controller.filterApplications('REJECTED'),
                          ),
                          _buildTab(
                            'ACCEPTED (${controller.getApplicationCount('ACCEPTED')})',
                            controller.selectedStatus == 'ACCEPTED',
                            () => controller.filterApplications('ACCEPTED'),
                          ),
                          _buildTab(
                            'PENDING (${controller.getApplicationCount('PENDING')})',
                            controller.selectedStatus == 'PENDING',
                            () => controller.filterApplications('PENDING'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: controller.filteredApplications.isEmpty
                          ? Center(
                              child: Text(
                                'No applications found',
                                style: TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: controller.filteredApplications.length,
                              itemBuilder: (context, index) {
                                return ApplicationCardWidget(
                                  application:
                                      controller.filteredApplications[index],
                                  onDelete: (applicationId) {
                                    controller.deleteApplication(applicationId);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : ColorManager.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
