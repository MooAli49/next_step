import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../models/country_model.dart';
import '../models/job_role_model.dart';

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
    loadCountries();
    loadJobRoles();
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
    } else {
      // Submit or Finish
      print("Profile Completed");
      // Navigate or API call
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
      print("Error loading countries: $e");
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
      print("Error loading job roles: $e");
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

  void updateProfilePicture(String path) {
    profilePicturePath.value = path;
  }
}
