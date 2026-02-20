import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/profile_setup/complete_profile_screen.dart';
import '../../features/splash%20&%20onboarding/presentation/onboarding_screen.dart';
import '../../features/splash%20&%20onboarding/presentation/splash_screen.dart';
import '../middleware/onboarding_middleware.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String home = '/home';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      middlewares: [OnboardingMiddleware()],
    ),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: profile, page: () => CompleteProfileScreen()),
    // GetPage(name: home, page: () => HomeScreen()),
  ];
}
