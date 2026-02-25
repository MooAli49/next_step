import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

import '../../core/extension/spacer.dart';
import '../../core/styles/app_styles.dart';
import '../../core/theme/color_manager.dart';
import 'presentation/widget/auth_logo_widget.dart';
import 'presentation/widget/register_form_widget.dart';

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
                  children: [
                    AuthLogoWidget(
                      title: Text(
                        'Create Account',
                        style: AppStyles.font20w700.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                      description:
                          'Join us today! Create your account to get started.',
                    ),
                    RegisterFormWidget(),
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
