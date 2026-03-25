import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/cache_constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../../data/models/update_profile_request_model.dart';
import '../../domain/repositories/settings_repo.dart';

class UpdateProfileController extends GetxController {
  final SettingsRepo settingsRepo;
  UpdateProfileController(this.settingsRepo);

  bool isUpdating = false;

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController genderController;

  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    user = _getCachedUser();
    _initTextEditingControllers();
  }

  UserModel? _getCachedUser() {
    final userMap = CacheHelper.getMap(key: CacheConstants.userData);
    if (userMap != null) {
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  void _initTextEditingControllers() {
    emailController = TextEditingController(text: user?.email ?? '');
    nameController = TextEditingController(text: user?.fullName ?? '');
    phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    addressController = TextEditingController(text: user?.address ?? '');
    genderController = TextEditingController(text: user?.gender ?? '');
  }

  Future<void> onUpdateProfile() async {
    if (isUpdating) return;

    isUpdating = true;
    update();

    String? imageUrl = user?.imageUrl;

    if (imageUrl != null &&
        imageUrl.isNotEmpty &&
        !imageUrl.startsWith('http://') &&
        !imageUrl.startsWith('https://')) {
      imageUrl = await uploadProfilePicture();

      if (imageUrl == null) {
        isUpdating = false;
        update();
        Get.snackbar(
          'Upload Failed',
          'Could not upload profile picture. Please try again.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    final result = await settingsRepo.updateProfile(
      UpdateProfileRequestModel(
        email: emailController.text.trim(),
        fullName: nameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        address: addressController.text.trim(),
        gender: genderController.text.trim(),
        imageUrl: imageUrl,
      ),
    );

    result.when(
      onSuccess: (data) {
        user = data;
        CacheHelper.set(key: CacheConstants.userData, value: data.toJson());

        // Clear image cache to force refresh of updated profile picture
        imageCache.clear();
        imageCache.clearLiveImages();

        Get.snackbar(
          'Success',
          'Profile updated successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onError: (error) {
        log('Error updating profile: ${error.message}');
        Get.snackbar(
          'Error',
          error.message ?? 'An error occurred while updating your profile.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );

    isUpdating = false;
    update();
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    genderController.dispose();
    super.onClose();
  }

  Future<void> pickPictureFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await _updateProfilePicture(image.path);
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  Future<void> pickPictureFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        await _updateProfilePicture(image.path);
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  Future<void> _updateProfilePicture(String path) async {
    user ??= UserModel();
    user!.imageUrl = path;
    await CacheHelper.set(key: CacheConstants.userData, value: user!.toJson());
    update();
  }

  Future<String?> uploadProfilePicture() async {
    if (user?.imageUrl == null || user?.imageUrl == '') return null;

    if (user!.imageUrl!.startsWith('http://') ||
        user!.imageUrl!.startsWith('https://')) {
      return user!.imageUrl;
    }

    try {
      final file = File(user!.imageUrl!);
      if (!file.existsSync()) return null;

      final fileExt = file.path.split('.').last;
      final fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      final storage = Supabase.instance.client.storage;

      await storage
          .from('profile-pictures')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));

      final publicUrl = storage.from('profile-pictures').getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      log('Error uploading profile picture: $e');
      return null;
    }
  }
}
