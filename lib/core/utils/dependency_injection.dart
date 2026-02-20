import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../features/splash%20&%20onboarding/controller/onboarding_controller.dart';

void setupDependencyInjection() {
  // onboarding
  Get.lazyPut<OnboardingController>(() => OnboardingController());
}
