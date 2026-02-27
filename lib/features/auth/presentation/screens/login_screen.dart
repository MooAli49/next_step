import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../widget/auth_logo_widget.dart';
import '../widget/login_form_widget.dart';

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
                    AuthLogoWidget(
                      title: RichText(
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
                      description:
                          'Log in to your account to continue your journey with us.',
                    ),
                    LoginFormWidget(),
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
