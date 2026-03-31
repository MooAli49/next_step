import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/models/apply_request_model.dart';
import '../domain/repositories/apply_repo.dart';

class ApplyController extends GetxController {
  final ApplyRepo applyRepo;

  ApplyController(this.applyRepo);

  final formKey = GlobalKey<FormState>();
  final coverLetterController = TextEditingController();

  String? cvPath;

  late String jobId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    jobId = Get.arguments['jobId'] as String;
    debugPrint('Received jobId: $jobId');
  }

  void pickCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _isLoading = true;
      update();

      final file = File(result.files.single.path!);
      final fileName =
          'cv_${DateTime.now().millisecondsSinceEpoch}_${result.files.single.name}';

      try {
        await Supabase.instance.client.storage
            .from('cv-storage')
            .upload(fileName, file);

        cvPath = Supabase.instance.client.storage
            .from('cv-storage')
            .getPublicUrl(fileName);

        _isLoading = false;
        update();

        Get.snackbar(
          'Success',
          'CV uploaded successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        _isLoading = false;
        update();

        debugPrint('CV upload error: $e');
        String errorMessage = 'Failed to upload CV';

        if (e.toString().contains('404')) {
          errorMessage = 'Upload bucket not found. Please contact support.';
        } else if (e.toString().contains('403')) {
          errorMessage = 'Permission denied. Please check your account.';
        } else if (e.toString().contains('413')) {
          errorMessage = 'File is too large. Please use a smaller file.';
        }

        Get.snackbar(
          'Error',
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void removeCV() {
    cvPath = null;
    update();
  }

  Future<void> submitApplication() async {
    if (cvPath == null) {
      Get.snackbar(
        'Error',
        'Please upload your CV/Resume',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    final request = ApplyRequestModel(
      jobId: jobId,
      resumeUrl: cvPath!,
      coverLetter: coverLetterController.text.trim(),
    );

    final result = await applyRepo.createApplication(request);

    _isLoading = false;
    update();

    result.when(
      onSuccess: (data) {
        Get.offNamed(
          '/apply-result',
          arguments: {'isSuccess': true, 'jobId': jobId},
        );
      },
      onError: (error) {
        Get.offNamed(
          '/apply-result',
          arguments: {'isSuccess': false, 'jobId': jobId},
        );
      },
    );
  }
}
