import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../core/extension/spacer.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../controllers/update_profile_controller.dart';
import '../widgets/profile_header_widget.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  static const List<String> _genderOptions = ['MAN', 'WOMAN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Profile', style: AppStyles.font20w700),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const ProfileHeaderWidget(showEditIcon: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _buildTextField(
                    'Email',
                    'Enter your email',
                    controller.emailController,
                    readOnly: true,
                  ),
                  VerticalSpace(16),
                  _buildTextField(
                    'Name',
                    'Enter your name',
                    controller.nameController,
                  ),
                  VerticalSpace(16),
                  _buildTextField(
                    'Mobile Number',
                    'Enter your mobile number',
                    controller.phoneController,
                  ),
                  VerticalSpace(16),
                  _buildTextField(
                    'Address',
                    'Enter your address',
                    maxLines: 2,
                    controller.addressController,
                  ),
                  VerticalSpace(16),
                  _buildGenderDropdown(),
                  VerticalSpace(32),
                  GetBuilder<UpdateProfileController>(
                    builder: (controller) {
                      return ElevatedButton(
                        onPressed: controller.isUpdating
                            ? null
                            : controller.onUpdateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: controller.isUpdating
                            ? SizedBox(
                                height: 22.h,
                                width: 22.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    final selectedGender =
        _genderOptions.contains(controller.genderController.text)
        ? controller.genderController.text
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        VerticalSpace(8),
        DropdownButtonFormField<String>(
          initialValue: selectedGender,
          items: _genderOptions
              .map(
                (gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ),
              )
              .toList(),
          onChanged: (value) {
            controller.genderController.text = value ?? '';
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.primary,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.greyDE,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            filled: true,
            fillColor: ColorManager.greyF3,
            hintText: 'Select gender',
            hintStyle: AppStyles.font13w500.copyWith(color: ColorManager.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hintText,
    TextEditingController controller, {
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        VerticalSpace(8),
        AppTextFormField(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
