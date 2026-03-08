import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_manager.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.greyEE),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter job location',
          hintStyle: TextStyle(color: ColorManager.greyDE, fontSize: 14.sp),
          prefixIcon: Icon(
            Icons.search,
            color: ColorManager.primary,
            size: 24.sp,
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: ColorManager.primary,
            size: 24.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
