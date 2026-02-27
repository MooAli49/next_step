import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_image.dart';
import '../../../../core/extension/spacer.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/theme/color_manager.dart';

class AuthLogoWidget extends StatelessWidget {
  const AuthLogoWidget({
    super.key,
    required this.title,
    required this.description,
  });
  final Widget title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(20),
        Image.asset(AppImage.logoGreen, height: 60.h, width: 120.w),
        VerticalSpace(20),
        Center(child: title),
        VerticalSpace(10),
        Text(
          description,
          style: AppStyles.font13w500.copyWith(
            color: ColorManager.grey,
            height: 1.5.sp,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpace(20),
      ],
    );
  }
}
