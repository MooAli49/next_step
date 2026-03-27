import '../../../../core/networking/api_result.dart';
import '../../../jobs/data/models/job_model.dart';

abstract class JobsRepository {
  Future<ApiResult<JobModel>> getJobDetails(String jobId);

  Future<ApiResult<void>> applyToJob(String jobId);

  Future<ApiResult<List<JobModel>>> getAllJobs();

  Future<ApiResult<void>> addFavoriteJob(String jobId);

  Future<ApiResult<void>> removeFavoriteJob(String jobId);

  Future<ApiResult<void>> deleteAllFavorites();

  Future<ApiResult<List<JobModel>>> getFavoriteJobs();
}
