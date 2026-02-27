import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routing/routes.dart';
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
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

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
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    update();
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  Future<bool> login(LoginRequestModel request) async {
    isLoading = true;
    update();
    try {
      await authRepo.login(request);
      log('AuthController.login: success');
      isLoading = false;
      update();
      return true;
    } catch (e) {
      log('AuthController.login error: $e');
      isLoading = false;
      update();
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> register(RegisterRequestModel request) async {
    isLoading = true;
    update();
    try {
      log('AuthController.register: request: ${request.toString()}');
      await authRepo.register(request);
      log('AuthController.register: success');
      isLoading = false;
      update();
      return true;
    } catch (e) {
      log('AuthController.register error: $e');
      isLoading = false;
      update();
      Get.snackbar(
        'Registration Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    Get.offAllNamed(Routes.login);
  }
}
