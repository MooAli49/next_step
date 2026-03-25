import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_styles.dart';
import '../theme/color_manager.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final int maxLines;
  final bool readOnly;

  const AppTextFormField({
    super.key,
    this.maxLines = 1,
    this.readOnly = false,
    this.controller,
    required this.hintText,
    this.isObscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style:
          inputTextStyle ?? AppStyles.font13w500.copyWith(color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.primary,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.greyDE,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        hintStyle:
            hintStyle ??
            AppStyles.font13w500.copyWith(color: ColorManager.grey),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorManager.greyF3,
        filled: true,
      ),
    );
  }
}
