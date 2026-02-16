import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:next_step/features/splash%20&%20onboarding/presentation/onboarding_screen.dart';
import 'package:next_step/features/splash%20&%20onboarding/presentation/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static List<GetPage> getPages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    // GetPage(name: login, page: () => LoginScreen()),
    // GetPage(name: register, page: () => RegisterScreen()),
    // GetPage(name: home, page: () => HomeScreen()),
  ];
}
