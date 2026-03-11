import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/cache_constants.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../core/theme/color_manager.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../profile_setup/data/models/user_model.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  UserModel? _getCachedUser() {
    final userMap = CacheHelper.getMap(key: CacheConstants.userData);
    if (userMap != null) {
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = _getCachedUser();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: ColorManager.greyF3,
              backgroundImage: user?.imageUrl != null
                  ? CachedNetworkImageProvider(user!.imageUrl!)
                  : null,
              child: user?.imageUrl == null
                  ? Icon(Icons.person, size: 26.r, color: ColorManager.grey99)
                  : null,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back !',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.grey99,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${user?.fullName ?? 'User'} 👋',
                  style: AppStyles.font20w700.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorManager.greyF3,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.notifications_none,
            size: 24.sp,
            color: ColorManager.black,
          ),
        ),
      ],
    );
  }
}
