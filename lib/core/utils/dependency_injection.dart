import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../features/auth/data/datasources/auth_api_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/api_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/profile_setup/controllers/complete_profile_controller.dart';
import '../../features/splash%20&%20onboarding/controller/onboarding_controller.dart';

void setupDependencyInjection() {
  setupOnboardingDI();
  _setupAuthDI();
  _setupProfileDI();
}

void _setupProfileDI() {
  Get.lazyPut<CompleteProfileController>(() => CompleteProfileController());
}

void setupOnboardingDI() {
  Get.lazyPut<OnboardingController>(() => OnboardingController());
}

void _setupAuthDI() {
  Get.lazyPut<AuthRemoteDataSource>(() => AuthApiDataSource(), fenix: true);
  Get.lazyPut<AuthRepo>(
    () => ApiAuthRepository(Get.find<AuthRemoteDataSource>()),
    fenix: true,
  );
  Get.lazyPut<AuthController>(
    () => AuthController(Get.find<AuthRepo>()),
    fenix: true,
  );
}
