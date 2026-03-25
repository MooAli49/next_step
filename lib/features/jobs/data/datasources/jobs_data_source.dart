import '../../../../core/networking/api_result.dart';
import '../models/job_model.dart';

abstract class JobsDataSource {
  /// Fetch all available jobs
  Future<ApiResult<List<JobModel>>> getAllJobs();

  /// Get details of a specific job by ID
  Future<ApiResult<JobModel>> getJobDetails(String jobId);

  /// Search jobs with filters
  Future<ApiResult<List<JobModel>>> searchJobs(
    JobModel searchRequest,
  );

  /// Add a job to favorites
  Future<ApiResult<void>> addFavoriteJob(String jobId);

  /// Remove a job from favorites
  Future<ApiResult<void>> removeFavoriteJob(String jobId);

  /// Get user's favorite jobs
  Future<ApiResult<List<JobModel>>> getFavoriteJobs();

  /// Apply to a job
  Future<ApiResult<void>> applyToJob(String jobId);
}
