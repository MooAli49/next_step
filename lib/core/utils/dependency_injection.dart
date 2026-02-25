import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/supabase_data_source.dart';
import '../../features/auth/data/repositories/supabase_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/splash%20&%20onboarding/controller/onboarding_controller.dart';

void setupDependencyInjection() {
  setupOnboardingDI();
  _setupAuthDI();
}

void setupOnboardingDI() {
  Get.lazyPut<OnboardingController>(() => OnboardingController());
}

void _setupAuthDI() {
  Get.lazyPut<AuthRemoteDataSource>(() => SupabaseDataSource(), fenix: true);
  Get.lazyPut<AuthRepo>(
    () => SupabaseRepositoryImpl(Get.find<AuthRemoteDataSource>()),
    fenix: true,
  );
  Get.lazyPut<AuthController>(
    () => AuthController(Get.find<AuthRepo>()),
    fenix: true,
  );
}
