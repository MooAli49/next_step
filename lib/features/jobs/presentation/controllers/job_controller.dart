import 'dart:developer';

import 'package:get/get.dart';

import '../../../../core/theme/color_manager.dart';
import '../../data/models/job_model.dart';
import '../../domain/repositories/jobs_repository.dart';

class JobController extends GetxController {
  final JobsRepository _jobsRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  JobModel? _currentJob;
  JobModel? get currentJob => _currentJob;

  List<JobModel> _jobs = [];
  List<JobModel> get jobs => _jobs;

  final List<JobModel> _favoriteJobs = [];
  List<JobModel> get favoriteJobs => _favoriteJobs;

  JobController(this._jobsRepository);

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Get jobId from route parameters
  //   final jobId = Get.parameters['jobId'];

  //   if (jobId != null && jobId.isNotEmpty) {
  //     getJobDetails(jobId);
  //   }
  // }

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

  // Local search filtering
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
        final id = job.id.toLowerCase();
        final title = job.title?.toLowerCase() ?? '';
        final location = job.location?.toLowerCase() ?? '';
        final jobType = job.jobType?.toLowerCase() ?? '';
        final jobLevel = job.jobLevel?.toLowerCase() ?? '';

        return id.contains(lowerQuery) ||
            title.contains(lowerQuery) ||
            location.contains(lowerQuery) ||
            jobType.contains(lowerQuery) ||
            jobLevel.contains(lowerQuery);
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
        Get.snackbar(
          'Added to Favorites',
          'Job has been added to your favorites.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.green,
          snackPosition: SnackPosition.BOTTOM,
        );
        update();
      },
      onError: (error) {
        log('Error adding favorite: ${error.message}');
        Get.snackbar(
          'Error',
          'Failed to add job to favorites.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  Future<void> removeFavoriteJob(String jobId) async {
    final result = await _jobsRepository.removeFavoriteJob(jobId);
    result.when(
      onSuccess: (_) {
        _favoriteJobs.removeWhere((job) => job.id == jobId);
        log('Job removed from favorites: $jobId');
        Get.snackbar(
          'Removed from Favorites',
          'Job has been removed from your favorites.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        update();
      },
      onError: (error) {
        log('Error removing favorite: ${error.message}');
        Get.snackbar(
          'Error',
          'Failed to remove job from favorites.',
          duration: const Duration(seconds: 2),
          backgroundColor: ColorManager.red,
          snackPosition: SnackPosition.BOTTOM,
        );
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
    // Capture the current state before toggle
    final wasFavorite = _currentJob?.isFavorite ?? false;

    // Update the current job if it matches
    if (_currentJob?.id == jobId) {
      _currentJob!.isFavorite = !wasFavorite;
    }

    // Also update in jobs list if it exists there
    final jobInList = _jobs.firstWhereOrNull((job) => job.id == jobId);
    if (jobInList != null) {
      jobInList.isFavorite = !wasFavorite;
    }

    // Update UI immediately
    update();

    // Call the API based on the original state
    if (wasFavorite) {
      await removeFavoriteJob(jobId);
    } else {
      await addFavoriteJob(jobId);
    }
  }

  bool isFavorite(String jobId) {
    return _favoriteJobs.any((job) => job.id == jobId);
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

  Future<void> loadMoreJobs() async {
    if (_isLoadingMore) return; // Prevent multiple simultaneous loads

    _isLoadingMore = true;
    update();

    final result = await _jobsRepository.getAllJobs(
      limit: '10',
      page:
          (_jobs.length ~/ 10) +
          1, // Calculate next page based on current count
    );

    result.when(
      onSuccess: (data) {
        _isLoadingMore = false;
        _jobs.addAll(data);
        log('Loaded more jobs: ${data.length} new jobs');
        update();
      },
      onError: (error) {
        _isLoadingMore = false;
        log('Error loading more jobs: ${error.message}');
        update();
      },
    );
  }
}
