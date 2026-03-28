import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/jobs/presentation/screens/job_detail_screen.dart';
import '../../features/layout/layout_screen.dart';
import '../../features/profile_setup/presentation/complete_profile_screen.dart';
import '../../features/settings/presentation/screens/my_applications_screen.dart';
import '../../features/settings/presentation/screens/privacy_policy_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/terms_conditions_screen.dart';
import '../../features/settings/presentation/screens/update_profile_screen.dart';
import '../../features/splash & onboarding/presentation/onboarding_screen.dart';
import '../../features/splash & onboarding/presentation/splash_screen.dart';
import '../middleware/auth_middleware.dart';
import '../middleware/guest_middleware.dart';
import '../middleware/onboarding_middleware.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String profileSetup = '/profile-setup';
  static const String layout = '/layout';
  static const String jobDetails = '/job-details';
  static const String settings = '/settings';
  static const String updateProfile = '/update-profile';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';
  static const String myApplications = '/my-applications';

  static List<GetPage> getPages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(
      name: onboarding,
      page: () => OnboardingScreen(),
      middlewares: [OnboardingMiddleware()],
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: profileSetup,
      page: () => CompleteProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: layout,
      page: () => LayoutScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: jobDetails, page: () => JobDetailScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),
    GetPage(name: updateProfile, page: () => UpdateProfileScreen()),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditions, page: () => TermsConditionsScreen()),
    GetPage(name: myApplications, page: () => MyApplicationsScreen()),
  ];
}
