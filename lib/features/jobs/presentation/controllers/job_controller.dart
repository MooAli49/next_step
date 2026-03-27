import 'dart:developer';

import 'package:get/get.dart';
import 'package:next_step/core/theme/color_manager.dart';

import '../../data/models/job_model.dart';
import '../../domain/repositories/jobs_repository.dart';

class JobController extends GetxController {
  final JobsRepository _jobsRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  JobModel? _currentJob;
  JobModel? get currentJob => _currentJob;

  List<JobModel> _jobs = [];
  List<JobModel> get jobs => _jobs;

  final List<JobModel> _favoriteJobs = [];
  List<JobModel> get favoriteJobs => _favoriteJobs;

  JobController(this._jobsRepository);

  @override
  void onInit() {
    super.onInit();
    // Get jobId from route parameters
    final jobId = Get.parameters['jobId'];
    log('JobController.onInit() - jobId from parameters: $jobId');
    log('JobController.onInit() - All parameters: ${Get.parameters}');
    if (jobId != null && jobId.isNotEmpty) {
      log('JobController.onInit() - Calling getJobDetails with jobId: $jobId');
      getJobDetails(jobId);
    } else {
      log('JobController.onInit() - jobId is null or empty!');
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

  Future<void> getAllJobs() async {
    _isLoading = true;
    update();

    final result = await _jobsRepository.getAllJobs();

    result.when(
      onSuccess: (data) {
        _isLoading = false;
        _jobs = data;
        update();
      },
      onError: (error) {
        _isLoading = false;
        log('Error loading all jobs: ${error.message}');
        update();
      },
    );
  }

  Future<void> searchJobs(JobModel searchRequest) async {
    // Search is performed locally via searchLocalJobs method
    // This method is kept for API compatibility but uses local search
    log('searchJobs: using local search instead of API');
    // No implementation needed as searchLocalJobs is used directly from UI
  }

  // Local search filtering (without API calls)
  void searchLocalJobs(String query) {
    if (query.isEmpty) {
      // If query is empty, show all jobs
      getAllJobs();
      return;
    }

    _isLoading = true;
    update();

    try {
      // Store original jobs list if not already stored
      // Filter jobs locally based on query
      final lowerQuery = query.toLowerCase();
      _jobs = _jobs.where((job) {
        final title = job.title?.toLowerCase() ?? '';
        final description = job.description?.toLowerCase() ?? '';
        final location = job.location?.toLowerCase() ?? '';
        final jobType = job.jobType?.toLowerCase() ?? '';
        final jobLevel = job.jobLevel?.toLowerCase() ?? '';
        final experience = job.experience?.toLowerCase() ?? '';
        final skillsStr = (job.skills ?? []).join(' ').toLowerCase();

        return title.contains(lowerQuery) ||
            description.contains(lowerQuery) ||
            location.contains(lowerQuery) ||
            jobType.contains(lowerQuery) ||
            jobLevel.contains(lowerQuery) ||
            experience.contains(lowerQuery) ||
            skillsStr.contains(lowerQuery);
      }).toList();

      _isLoading = false;
      log('Local search completed: found ${_jobs.length} jobs');
      update();
    } catch (e) {
      _isLoading = false;
      log('Error during local search: $e');
      update();
    }
  }

  // Favorites methods
  Future<void> addFavoriteJob(String jobId) async {
    final result = await _jobsRepository.addFavoriteJob(jobId);
    result.when(
      onSuccess: (_) {
        log('Job added to favorites: $jobId');
        // Also add to favorites list if not already there
        final favoriteIndex = _favoriteJobs.indexWhere(
          (job) => job.id == jobId,
        );
        if (favoriteIndex == -1) {
          final jobIndex = _jobs.indexWhere((job) => job.id == jobId);
          if (jobIndex != -1) {
            _favoriteJobs.add(_jobs[jobIndex]);
          }
        }
        update();
      },
      onError: (error) {
        log('Error adding favorite: ${error.message}');
      },
    );
  }

  Future<void> removeFavoriteJob(String jobId) async {
    final result = await _jobsRepository.removeFavoriteJob(jobId);
    result.when(
      onSuccess: (_) {
        _favoriteJobs.removeWhere((job) => job.id == jobId);
        log('Job removed from favorites: $jobId');
        update();
      },
      onError: (error) {
        log('Error removing favorite: ${error.message}');
      },
    );
  }

  Future<void> deleteAllFavorites() async {
    final result = await _jobsRepository.deleteAllFavorites();
    result.when(
      onSuccess: (_) {
        _favoriteJobs.clear();
        log('All favorite jobs deleted');
        update();
        Get.snackbar(
          'Deleted Successfully',
          'All favorite jobs have been deleted.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onError: (error) {
        log('Error deleting all favorites: ${error.message}');
        Get.snackbar(
          'Error',
          'Failed to delete favorite jobs.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  Future<void> toggleFavorite(String jobId) async {
    // Find the job in either list
    JobModel? job;
    bool isInFavorites = false;

    var jobIndex = _jobs.indexWhere((j) => j.id == jobId);
    if (jobIndex != -1) {
      job = _jobs[jobIndex];
      isInFavorites = job.isFavorite ?? false;
    } else {
      jobIndex = _favoriteJobs.indexWhere((j) => j.id == jobId);
      if (jobIndex != -1) {
        job = _favoriteJobs[jobIndex];
        isInFavorites =
            true; // If it's in _favoriteJobs, it's definitely a favorite
      }
    }

    if (job == null) return;

    // Update UI optimistically
    job.isFavorite = !isInFavorites;
    update();

    // Call the API
    if (isInFavorites) {
      await removeFavoriteJob(jobId);
    } else {
      await addFavoriteJob(jobId);
    }
  }

  Future<void> getFavoriteJobs() async {
    _isLoading = true;
    update();

    final result = await _jobsRepository.getFavoriteJobs();
    result.when(
      onSuccess: (data) {
        _favoriteJobs
          ..clear()
          ..addAll(data);
        _isLoading = false;
        log('Favorite jobs loaded: ${data.length} jobs');
        update();
      },
      onError: (error) {
        _isLoading = false;
        log('Error loading favorite jobs: ${error.message}');
        update();
      },
    );
  }
}
