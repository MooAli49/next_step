import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

import '../../core/constants/app_image.dart';
import '../../core/extension/spacer.dart';
import '../../core/routing/routes.dart';
import '../../core/styles/app_styles.dart';
import '../../core/theme/color_manager.dart';
import '../../core/widgets/app_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    VerticalSpace(20),
                    Image.asset(AppImage.logoGreen, height: 60.h, width: 120.w),
                    VerticalSpace(20),
                    Center(
                      child: Text(
                        'Create Account',
                        style: AppStyles.font20w700.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    VerticalSpace(10),
                    Text(
                      "Sign up now to start your journey with NextStep.",
                      style: AppStyles.font13w500.copyWith(
                        color: ColorManager.grey,
                        height: 1.5.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    VerticalSpace(20),
                    AppTextFormField(
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(15),
                    AppTextFormField(
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(15),
                    AppTextFormField(
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(15),
                    AppTextFormField(
                      hintText: 'Password',
                      isObscureText: true,
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        size: 24.sp,
                        color: ColorManager.grey,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(15),
                    AppTextFormField(
                      hintText: 'Confirm Password',
                      isObscureText: true,
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        size: 24.sp,
                        color: ColorManager.grey,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(20),
                    ElevatedButton(
                      onPressed: () {
                        // TODO : Implement registration logic
                        Get.snackbar(
                          'Registration',
                          'Registration successful! Please log in.',
                          backgroundColor: ColorManager.primary,
                          colorText: Colors.white,
                        );
                        Get.offAllNamed(Routes.profile);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: AppStyles.font16w600.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    VerticalSpace(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: AppStyles.font13w500.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Log In',
                            style: AppStyles.font13w500.copyWith(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
