import 'dart:developer';

import 'package:get/get.dart';

import '../../../../core/theme/color_manager.dart';
import '../../data/models/home_stats_model/suggested_job.dart';
import '../../domain/repositories/home_repos.dart';

class HomeController extends GetxController {
  final HomeRepos homeRepos;
  HomeController(this.homeRepos);

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  bool get hasError =>
      remoteJobCount.value == null ||
      partTimeJobCount.value == null ||
      fullTimeJobCount.value == null;

  final Rxn<List<SuggestedJob>> _suggestedJobs = Rxn<List<SuggestedJob>>();
  List<SuggestedJob>? get suggestedJobs => _suggestedJobs.value;

  final remoteJobCount = Rxn<int>(0);
  final partTimeJobCount = Rxn<int>(0);
  final fullTimeJobCount = Rxn<int>(0);

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

        remoteJobCount.value = data.totalJobs?.freelance;
        partTimeJobCount.value = data.totalJobs?.partTime;
        fullTimeJobCount.value = data.totalJobs?.fullTime;

        _suggestedJobs.value = data.suggestedJobs;
        log('Suggested Jobs: ${_suggestedJobs.value?.length ?? 0}');
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
