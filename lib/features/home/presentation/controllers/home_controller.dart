import 'dart:developer';

import 'package:get/get.dart';
import 'package:next_step/core/theme/color_manager.dart';
import 'package:next_step/features/home/domain/repositories/home_repos.dart';

import '../../data/models/home_stats_model/suggested_job.dart';

class HomeController extends GetxController {
  final HomeRepos homeRepos;
  HomeController(this.homeRepos);

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  bool get hasError =>
      remoteJobCount == null ||
      partTimeJobCount == null ||
      fullTimeJobCount == null;

  List<SuggestedJob>? _suggestedJobs;
  List<SuggestedJob>? get suggestedJobs => _suggestedJobs;

  int? remoteJobCount = 0;
  int? partTimeJobCount = 0;
  int? fullTimeJobCount = 0;

  @override
  void onInit() {
    super.onInit();
    getJobsStats();
  }

  Future<void> getJobsStats() async {
    _isLoading.value = true;

    final result = await homeRepos.getjobsStats();

    result.when(
      onSuccess: (data) {
        _isLoading.value = false;

        remoteJobCount = data.totalJobs?.freelance;
        partTimeJobCount = data.totalJobs?.partTime;
        fullTimeJobCount = data.totalJobs?.fullTime;

        _suggestedJobs = data.suggestedJobs;
        log('Suggested Jobs: ${_suggestedJobs?.length ?? 0}');
      },
      onError: (error) {
        _isLoading.value = false;

        log('Error fetching job stats: ${error.message}');
        Get.snackbar(
          '',
          'Failed to fetch job stats. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorManager.white,
          backgroundColor: ColorManager.red,
        );
      },
    );
  }
}
