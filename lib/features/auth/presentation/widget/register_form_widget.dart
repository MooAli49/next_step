import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/extension/spacer.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../data/models/register_request_model.dart';
import '../controller/auth_controller.dart';

class RegisterFormWidget extends GetView<AuthController> {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: controller.nameController,
            hintText: 'Name',
            validator: (value) => AppValidator.validateName(value),
          ),
          VerticalSpace(15),
          AppTextFormField(
            controller: controller.emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidator.validateEmail(value),
          ),
          VerticalSpace(15),
          AppTextFormField(
            controller: controller.phoneController,
            hintText: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: (value) => AppValidator.validatePhoneNumber(value),
          ),
          VerticalSpace(15),
          GetBuilder<AuthController>(
            builder: (context) {
              return AppTextFormField(
                controller: controller.passwordController,
                hintText: 'Password',
                isObscureText: controller.obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 24.sp,
                    color: ColorManager.grey,
                  ),
                  onPressed: controller.toggleObscurePassword,
                ),
                validator: (value) => AppValidator.validatePassword(value),
              );
            },
          ),
          VerticalSpace(15),
          GetBuilder<AuthController>(
            builder: (context) {
              return AppTextFormField(
                controller: controller.confirmPasswordController,
                hintText: 'Confirm Password',
                isObscureText: controller.obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 24.sp,
                    color: ColorManager.grey,
                  ),
                  onPressed: controller.toggleObscureConfirmPassword,
                ),
                validator: (value) => AppValidator.validateConfirmPassword(
                  value,
                  controller.passwordController.text,
                ),
              );
            },
          ),
          VerticalSpace(20),
          GetBuilder<AuthController>(
            builder: (controller) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          if (controller.registerFormKey.currentState!
                              .validate()) {
                            final success = await controller.register(
                              RegisterRequestModel(
                                name: controller.nameController.text.trim(),
                                email: controller.emailController.text.trim(),
                                phoneNumber: controller.phoneController.text
                                    .trim(),
                                password: controller.passwordController.text
                                    .trim(),
                              ),
                            );

                            if (success) {
                              Get.snackbar(
                                'Registration',
                                'Registration successful! Please log in.',
                                backgroundColor: ColorManager.primary,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              Get.offAllNamed(Routes.profileSetup);
                            }
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
                          'Sign Up',
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
