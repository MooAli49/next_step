import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../core/extension/spacer.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../controller/auth_controller.dart';

class LoginFormWidget extends GetView<AuthController> {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: controller.emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidator.validateEmail(value),
          ),
          VerticalSpace(20),
          GetBuilder<AuthController>(
            id: 'password',
            builder: (controller) {
              return AppTextFormField(
                controller: controller.passwordController,
                hintText: 'Password',
                isObscureText: controller.obscurePassword,
                suffixIcon: IconButton(
                  onPressed: controller.toggleObscurePassword,
                  icon: Icon(
                    controller.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 24.sp,
                    color: ColorManager.grey,
                  ),
                ),
                validator: (value) => AppValidator.validatePassword(value),
              );
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
          GetBuilder<AuthController>(
            builder: (controller) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          if (controller.loginFormKey.currentState!
                              .validate()) {
                            await controller.onLogin();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: controller.isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Log In',
                          style: AppStyles.font16w600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
