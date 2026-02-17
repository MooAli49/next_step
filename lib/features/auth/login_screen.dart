import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_image.dart';
import '../../core/extension/spacer.dart';
import '../../core/routing/routes.dart';
import '../../core/styles/app_styles.dart';
import '../../core/theme/color_manager.dart';
import '../../core/widgets/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    Image.asset(AppImage.logoGreen, height: 60.h, width: 120.w),
                    VerticalSpace(20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Welcome Back to ',
                          style: AppStyles.font20w700.copyWith(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'NextStep',
                              style: AppStyles.font20w700.copyWith(
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalSpace(20),
                    Text(
                      "Log in to your NextStep account to continue your job search, manage applications, and stay updated with the latest job opportunities.",
                      style: AppStyles.font13w500.copyWith(
                        color: ColorManager.grey,
                        height: 1.5.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    VerticalSpace(20),
                    AppTextFormField(
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(20),
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
                    VerticalSpace(10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password logic here
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppStyles.font13w500.copyWith(
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                    VerticalSpace(15),
                    ElevatedButton(
                      onPressed: () {
                        //TODO Handle login logic here
                        Get.snackbar(
                          "Login Successful",
                          "Welcome back to NextStep!",
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
                        'Log In',
                        style: AppStyles.font16w600.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppStyles.font13w500.copyWith(
                            color: ColorManager.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.register);
                          },
                          child: Text(
                            'Register',
                            style: AppStyles.font13w500.copyWith(
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
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
