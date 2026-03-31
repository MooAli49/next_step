import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/cache_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;

  late final GlobalKey<FormState> registerFormKey;
  late final GlobalKey<FormState> loginFormKey;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  String? selectedGender;
  final List<String> genders = ['MAN', 'WOMAN'];

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool isLoading = false;

  AuthController(this.authRepo);

  @override
  onInit() {
    _setupFormKeys();
    _setupTextEditingControllers();
    super.onInit();
  }

  void _setupFormKeys() {
    registerFormKey = GlobalKey<FormState>();
    loginFormKey = GlobalKey<FormState>();
  }

  void _setupTextEditingControllers() {
    nameController = TextEditingController(text: 'John Doe');
    emailController = TextEditingController(text: 'john.doe@example.com');
    phoneController = TextEditingController(text: '+1234567890');
    addressController = TextEditingController(text: '123 Main St');
    passwordController = TextEditingController(text: '123456');
    confirmPasswordController = TextEditingController(text: '123456');
    selectedGender = genders.first;
  }

  void onChangeGender(String? value) {
    if (value != null) {
      selectedGender = value;
      update();
    }
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    update(['password']);
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update(['confirmPassword']);
  }

  Future<void> onLogin() async {
    final request = LoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    isLoading = true;
    update();

    final result = await authRepo.login(request);

    return result.when(
      onSuccess: (data) async {
        // Save token and login state
        if (data.token != null) {
          await CacheHelper.setSecureData(
            key: CacheConstants.accessToken,
            value: data.token!,
          );
        }
        await CacheHelper.set(key: CacheConstants.isUserLoggedIn, value: true);
        await CacheHelper.set(
          key: CacheConstants.isProfileCompleted,
          value: data.isCompleted ?? false,
        );

        final userProfileResult = await authRepo.getAuthenticatedUser();
        userProfileResult.when(
          onSuccess: (completeUser) async {
            await CacheHelper.set(
              key: CacheConstants.userData,
              value: completeUser.toJson(),
            );
          },
          onError: (error) {
            log('Failed to fetch complete user profile: ${error.message}');
          },
        );

        isLoading = false;
        update();

        // Unfocus keyboard before routing to prevent focus node framework errors
        FocusManager.instance.primaryFocus?.unfocus();

        Get.snackbar(
          'Login Successful',
          'Welcome back, ${data.name ?? 'User'}! ${data.isCompleted ?? false ? '' : ' Please complete your profile setup.'}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        if (data.isCompleted == false) {
          Get.offAllNamed(Routes.profileSetup);
        } else {
          Get.offAllNamed(Routes.layout);
        }
      },
      onError: (error) {
        isLoading = false;
        update();
        Get.snackbar(
          'Login Failed',
          error.message ?? 'Unknown error occurred',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  Future<void> onRegister() async {
    final request = RegisterRequestModel(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text.trim(),
      address: addressController.text.trim(),
      gender: selectedGender ?? 'MAN',
      role: 'USER',
    );

    isLoading = true;
    update();

    final result = await authRepo.register(request);

    return result.when(
      onSuccess: (data) async {
        // Mark user as logged in so AuthMiddleware allows profile setup
        await CacheHelper.set(key: CacheConstants.isUserLoggedIn, value: true);
        await CacheHelper.set(
          key: CacheConstants.isProfileCompleted,
          value: false,
        );

        isLoading = false;
        update();

        // Unfocus keyboard before routing to prevent focus node framework errors
        FocusManager.instance.primaryFocus?.unfocus();

        Get.snackbar(
          'Registration',
          'Registration successful! Please Complete your profile setup.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(Routes.profileSetup);
      },
      onError: (error) {
        isLoading = false;
        update();
        Get.snackbar(
          'Registration Failed',
          error.message ?? 'Unknown error occurred',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  Future<void> logout() async {
    await _clearCache();
    Get.offAllNamed(Routes.login);
  }

  Future<void> _clearCache() async {
    await Future.wait([
      CacheHelper.delete(key: CacheConstants.accessToken),
      CacheHelper.delete(key: CacheConstants.isUserLoggedIn),
      CacheHelper.delete(key: CacheConstants.isProfileCompleted),
      CacheHelper.delete(key: CacheConstants.userData),
    ]);
  }
}
