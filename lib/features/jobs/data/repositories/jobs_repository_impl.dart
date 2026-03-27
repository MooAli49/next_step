import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/jobs_repository.dart';
import '../datasources/jobs_data_source.dart';
import '../models/job_model.dart';

class JobsRepositoryImpl extends JobsRepository {
  final JobsDataSource jobsDataSource;

  JobsRepositoryImpl(this.jobsDataSource);

  @override
  Future<ApiResult<JobModel>> getJobDetails(String jobId) async {
    return await jobsDataSource.getJobDetails(jobId);
  }

  @override
  Future<ApiResult<void>> applyToJob(String jobId) async {
    return await jobsDataSource.applyToJob(jobId);
  }

  @override
  Future<ApiResult<List<JobModel>>> getAllJobs() async {
    return await jobsDataSource.getAllJobs();
  }

  @override
  Future<ApiResult<void>> addFavoriteJob(String jobId) async {
    return await jobsDataSource.addFavoriteJob(jobId);
  }

  @override
  Future<ApiResult<void>> removeFavoriteJob(String jobId) async {
    return await jobsDataSource.removeFavoriteJob(jobId);
  }

  @override
  Future<ApiResult<void>> deleteAllFavorites() async {
    return await jobsDataSource.deleteAllFavorites();
  }

  @override
  Future<ApiResult<List<JobModel>>> getFavoriteJobs() async {
    return await jobsDataSource.getFavoriteJobs();
  }
}
