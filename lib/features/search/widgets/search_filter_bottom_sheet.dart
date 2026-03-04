import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: ColorManager.greyDE,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Center(child: Text('Filter', style: AppStyles.font20w700)),
          SizedBox(height: 24.h),
          Text('Location', style: AppStyles.font16w600),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.greyEE),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tunisia',
                  style: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
                ),
                Icon(Icons.keyboard_arrow_down, color: ColorManager.grey),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text('Job Type', style: AppStyles.font16w600),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 12.h,
            children: [
              _buildRadioOption('Full Time', true),
              _buildRadioOption('Freelance', false),
              _buildRadioOption('Contract', false),
              _buildRadioOption('Internship', false),
              _buildRadioOption('Part Time', false),
            ],
          ),
          SizedBox(height: 24.h),
          Text('Job Level', style: AppStyles.font16w600),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 12.h,
            children: [
              _buildRadioOption('Entry Level', true),
              _buildRadioOption('Mid Level', false),
              _buildRadioOption('Senior Level', false),
              _buildRadioOption('Management', false),
              _buildRadioOption('Executive', false),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary.withOpacity(0.15),
                    elevation: 0,
                    minimumSize: Size(0, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    elevation: 0,
                    minimumSize: Size(0, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, bool isSelected) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? ColorManager.primary : ColorManager.grey,
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(color: ColorManager.black, fontSize: 14.sp),
        ),
      ],
    );
  }
}
