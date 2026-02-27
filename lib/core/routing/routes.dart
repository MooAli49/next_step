import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile_setup/complete_profile_screen.dart';
import '../../features/splash%20&%20onboarding/presentation/onboarding_screen.dart';
import '../../features/splash%20&%20onboarding/presentation/splash_screen.dart';
import '../middleware/auth_middleware.dart';
import '../middleware/guest_middleware.dart';
import '../middleware/onboarding_middleware.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';

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
      name: home,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
