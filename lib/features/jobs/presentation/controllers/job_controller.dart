import 'dart:developer';

import 'package:get/get.dart';

import '../../data/models/job_model.dart';
import '../../domain/repositories/jobs_repository.dart';

class JobController extends GetxController {
  final JobsRepository _jobsRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  JobModel? _currentJob;
  JobModel? get currentJob => _currentJob;

  JobController(this._jobsRepository);

  @override
  void onInit() {
    super.onInit();
    // Get jobId from route parameters
    final jobId = Get.parameters['jobId'];
    if (jobId != null && jobId.isNotEmpty) {
      getJobDetails(jobId);
    }
  }

  Future<void> getJobDetails(String jobId) async {
    _isLoading = true;
    update();

    final result = await _jobsRepository.getJobDetails(jobId);
    result.when(
      onSuccess: (data) {
        _currentJob = data;
        _isLoading = false;
        log('Job details loaded: ${data.title}');
        update();
      },
      onError: (error) {
        _isLoading = false;
        log('Error loading job details: ${error.message}');
        update();
      },
    );
  }

  // Future<void> toggleFavorite() async {
  //   if (_currentJob?.id == null) return;

  //   final isFavorite = _currentJob?.isFavorite ?? false;
  //   final result = isFavorite
  //       ? await _jobsRepository.removeFavoriteJob(_currentJob!.id!)
  //       : await _jobsRepository.addFavoriteJob(_currentJob!.id!);

  //   result.when(
  //     onSuccess: (_) {
  //       _currentJob?.isFavorite = !isFavorite;
  //       log('Favorite toggled: ${_currentJob?.isFavorite}');
  //       update();
  //     },
  //     onError: (error) {
  //       log('Error toggling favorite: ${error.message}');
  //     },
  //   );
  // }

  Future<void> applyToJob() async {
    if (_currentJob?.id == null) return;

    _isLoading = true;
    update();

    final result = await _jobsRepository.applyToJob(_currentJob!.id!);
    result.when(
      onSuccess: (_) {
        _isLoading = false;
        log('Applied to job successfully');
        Get.snackbar(
          'Success',
          'You have successfully applied to this job!',
          duration: const Duration(seconds: 2),
        );
        update();
      },
      onError: (error) {
        _isLoading = false;
        log('Error applying to job: ${error.message}');
        Get.snackbar(
          'Error',
          error.message ?? 'Failed to apply to job',
          duration: const Duration(seconds: 2),
        );
        update();
      },
    );
  }
}
