import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/country_model.dart';
import '../data/models/job_role_model.dart';

class CompleteProfileController extends GetxController {
  // Page Controller
  late PageController pageController;
  var currentPage = 0.obs;

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
}
