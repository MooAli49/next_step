import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/cache_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../data/models/complete_profile_request_model.dart';
import '../../data/models/country_model.dart';
import '../../data/models/job_role_model.dart';
import '../../domain/repositories/profile_repo.dart';

class CompleteProfileController extends GetxController {
  final ProfileRepo profileRepo;

  CompleteProfileController(this.profileRepo);
  late PageController pageController;
  var currentPage = 0.obs;

  bool get isLastPage => currentPage.value == 2;

  var isLoading = false.obs;

  // Data Lists
  var countries = <CountryModel>[].obs;
  var jobRoles = <JobRoleModel>[].obs;

  // Selections
  var selectedJobRoles = <String>[].obs; // storing IDs
  var selectedCountries = <String>[].obs; // storing Codes
  var profilePicturePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    loadJobRoles();
    loadCountries();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      currentPage.value--;
    }
  }

  Future<void> loadCountries() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/countries.json',
      );
      final List<dynamic> data = json.decode(response);
      countries.value = data
          .map((json) => CountryModel.fromJson(json))
          .toList();
    } catch (e) {
      log("Error loading countries: $e");
    }
  }

  Future<void> loadJobRoles() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/jobRoles.json',
      );
      final List<dynamic> data = json.decode(response);
      jobRoles.value = data.map((json) => JobRoleModel.fromJson(json)).toList();
    } catch (e) {
      log("Error loading job roles: $e");
    }
  }

  void toggleJobRole(String id) {
    if (selectedJobRoles.contains(id)) {
      selectedJobRoles.remove(id);
    } else {
      selectedJobRoles.add(id);
    }
  }

  void toggleCountry(String code) {
    if (selectedCountries.contains(code)) {
      selectedCountries.remove(code);
    } else {
      selectedCountries.add(code);
    }
  }

  Future<void> pickPictureFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _updateProfilePicture(image.path);
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
        _updateProfilePicture(image.path);
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  void _updateProfilePicture(String path) {
    profilePicturePath.value = path;
  }

  Future<String?> _uploadProfilePicture() async {
    if (profilePicturePath.value.isEmpty) return null;

    try {
      final file = File(profilePicturePath.value);
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

  Future<void> completeProfile() async {
    isLoading.value = true;

    // Upload picture to Supabase storage first
    String? imageUrl;
    if (profilePicturePath.value.isNotEmpty) {
      imageUrl = await _uploadProfilePicture();
      if (imageUrl == null) {
        isLoading.value = false;
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

    final result = await profileRepo.completeProfile(
      CompleteProfileRequestModel(
        jobRoles: selectedJobRoles,
        countries: selectedCountries,
        imageUrl: imageUrl ?? '',
      ),
    );

    isLoading.value = false;

    result.when(
      onSuccess: (data) {
        // Cache the updated user data
        CacheHelper.set(key: CacheConstants.userData, value: data.toJson());
        CacheHelper.set(key: CacheConstants.isProfileCompleted, value: true);

        Get.snackbar(
          'Welcome ${data.fullName ?? 'Guest'}',
          'Your profile has been completed successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        log("Profile completed successfully: $data");
        Get.offAllNamed(Routes.layout);
      },
      onError: (error) {
        log("Error completing profile: ${error.message}");
        Get.snackbar(
          "Error",
          error.message ?? "An error occurred while completing your profile.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
