import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apply/data/models/user_application_job_model.dart';
import '../../../apply/domain/repositories/apply_repo.dart';
import '../../domain/repositories/settings_repo.dart';

class MyApplicationsController extends GetxController {
  final SettingsRepo settingsRepo;
  final ApplyRepo applyRepo;

  MyApplicationsController({
    required this.settingsRepo,
    required this.applyRepo,
  });

  List<UserApplicationJobModel> allApplications = [];
  List<UserApplicationJobModel> filteredApplications = [];

  String selectedStatus = 'ALL';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    _isLoading = true;
    update();

    final result = await applyRepo.getUserApplications();

    result.when(
      onSuccess: (data) {
        allApplications = data;
        filterApplications('ALL');
        _isLoading = false;
        update();
      },
      onError: (error) {
        _isLoading = false;
        update();
        Get.snackbar(
          'Error',
          error.message ?? 'Failed to fetch applications',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
    );
  }

  void filterApplications(String status) {
    selectedStatus = status;

    if (status == 'ALL') {
      filteredApplications = allApplications;
    } else {
      filteredApplications = allApplications
          .where((app) => app.status?.toUpperCase() == status.toUpperCase())
          .toList();
    }

    update();
  }

  String getStatusBadgeColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'ACCEPTED':
        return 'green';
      case 'REJECTED':
        return 'red';
      case 'PENDING':
        return 'orange';
      default:
        return 'grey';
    }
  }

  int getApplicationCount(String status) {
    if (status == 'ALL') {
      return allApplications.length;
    }
    return allApplications
        .where((app) => app.status?.toUpperCase() == status.toUpperCase())
        .length;
  }

  Future<void> deleteApplication(String applicationId) async {
    final result = await applyRepo.deleteApplication(applicationId);

    result.when(
      onSuccess: (_) {
        Get.snackbar(
          'Success',
          'Application deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        fetchApplications();
      },
      onError: (error) {
        final errorMessage = error.message ?? 'Failed to delete application';
        Get.snackbar(
          'Error',
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
    );
  }

  Future<void> deleteAllApplications() async {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Delete All Applications'),
        content: const Text(
          'Are you sure you want to delete all applications? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();
              _isLoading = true;
              update();

              final result = await applyRepo.deleteAllApplications();

              _isLoading = false;
              update();

              result.when(
                onSuccess: (message) {
                  Get.snackbar(
                    'Success',
                    message,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                onError: (error) {
                  final errorMessage =
                      error.message ?? 'Failed to delete applications';
                  Get.snackbar(
                    'Error',
                    errorMessage,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
              );

              await fetchApplications();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
