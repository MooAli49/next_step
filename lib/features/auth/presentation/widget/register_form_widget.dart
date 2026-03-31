import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/extension/spacer.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/app_text_form_field.dart';
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
          AppTextFormField(
            controller: controller.addressController,
            hintText: 'Address',
            validator: (value) => AppValidator.validateAddress(value),
          ),
          VerticalSpace(15),
          GetBuilder<AuthController>(
            builder: (controller) {
              return DropdownButtonFormField<String>(
                initialValue: controller.selectedGender,
                items: controller.genders
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(
                          gender,
                          style: AppStyles.font14w400.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: controller.onChangeGender,
                decoration: InputDecoration(
                  hintText: 'Gender',
                  hintStyle: AppStyles.font14w400.copyWith(
                    color: ColorManager.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 18.h,
                  ),
                  filled: true,
                  fillColor: ColorManager.greyDE,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: ColorManager.greyEE,
                      width: 1.3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: ColorManager.greyEE,
                      width: 1.3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: ColorManager.primary,
                      width: 1.3,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: Colors.red, width: 1.3),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: Colors.red, width: 1.3),
                  ),
                ),
              );
            },
          ),
          VerticalSpace(15),
          GetBuilder<AuthController>(
            id: 'password',
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
            id: 'confirmPassword',
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
                            await controller.onRegister();
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
