import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../features/auth/data/datasources/auth_api_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/api_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/home/data/datasource/api_home_data_source.dart';
import '../../features/home/data/datasource/home_data_source.dart';
import '../../features/home/data/repositories/home_repo_impl.dart';
import '../../features/home/domain/repositories/home_repos.dart';
import '../../features/home/presentation/controllers/home_controller.dart';
import '../../features/profile_setup/controllers/complete_profile_controller.dart';
import '../../features/profile_setup/data/datasources/profile_api_data_source.dart';
import '../../features/profile_setup/data/datasources/profile_data_source.dart';
import '../../features/profile_setup/data/repositories/api_profile_repo.dart';
import '../../features/profile_setup/domain/repositories/profile_repo.dart';
import '../../features/settings/data/datasource/api_settings_data_source.dart';
import '../../features/settings/data/datasource/settings_data_source.dart';
import '../../features/settings/data/repositories/settings_repo_impl.dart';
import '../../features/settings/domain/repositories/settings_repo.dart';
import '../../features/settings/presentation/controllers/update_profile_controller.dart';
import '../../features/splash%20&%20onboarding/controller/onboarding_controller.dart';

void setupDependencyInjection() {
  setupOnboardingDI();
  _setupAuthDI();
  _setupProfileDI();
  _setupHomeDI();
  _setupSettingsDI();
}

void _setupProfileDI() {
  Get.lazyPut<ProfileDataSource>(() => ProfileApiDataSource(), fenix: true);
  Get.lazyPut<ProfileRepo>(() => ApiProfileRepo(Get.find<ProfileDataSource>()));
  Get.lazyPut<CompleteProfileController>(
    () => CompleteProfileController(Get.find<ProfileRepo>()),
  );
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

void _setupHomeDI() {
  Get.lazyPut<HomeDataSource>(() => ApiHomeDataSource(), fenix: true);
  Get.lazyPut<HomeRepos>(
    () => HomeRepoImpl(Get.find<HomeDataSource>()),
    fenix: true,
  );
  Get.lazyPut<HomeController>(
    () => HomeController(Get.find<HomeRepos>()),
    fenix: true,
  );
}

void _setupSettingsDI() {
  Get.lazyPut<SettingsDataSource>(() => ApiSettingsDataSource(), fenix: true);
  Get.lazyPut<SettingsRepo>(
    () => SettingsRepoImpl(Get.find<SettingsDataSource>()),
    fenix: true,
  );
  Get.lazyPut<UpdateProfileController>(
    () => UpdateProfileController(Get.find<SettingsRepo>()),
    fenix: true,
  );
}
