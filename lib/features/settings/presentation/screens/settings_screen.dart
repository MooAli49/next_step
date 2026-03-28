import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../widgets/menu_item_widget.dart';
import '../widgets/profile_header_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const ProfileHeaderWidget(showEditIcon: false),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  MenuItemWidget(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () => Get.toNamed(Routes.updateProfile),
                  ),
                  MenuItemWidget(
                    icon: Icons.folder_open,
                    title: 'My Applications',
                    onTap: () => Get.toNamed(Routes.myApplications),
                    iconColor: Colors.orange,
                  ),
                  MenuItemWidget(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () => Get.toNamed(Routes.privacyPolicy),
                    iconColor: Colors.green,
                  ),
                  MenuItemWidget(
                    icon: Icons.description_outlined,
                    title: 'Terms and Conditions',
                    onTap: () => Get.toNamed(Routes.termsConditions),
                    iconColor: Colors.orangeAccent,
                  ),
                  SizedBox(height: 24.h),
                  MenuItemWidget(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: _logout,
                    isLogout: true,
                    iconColor: ColorManager.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    final authController = Get.find<AuthController>();
    await authController.logout();
  }
}
