import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_styles.dart';
import '../theme/color_manager.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;

  const PrimaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? ColorManager.primary,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
        shadowColor: ColorManager.primary.withValues(alpha: 0.3),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: AppStyles.font16w600.copyWith(
          color: textColor ?? ColorManager.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
