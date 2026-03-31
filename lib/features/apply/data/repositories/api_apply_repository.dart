import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/apply_repo.dart';
import '../datasources/apply_remote_data_source.dart';
import '../models/apply_request_model.dart';
import '../models/user_application_job_model.dart';

class ApiApplyRepository extends ApplyRepo {
  final ApplyRemoteDataSource applyRemoteDataSource;
  ApiApplyRepository(this.applyRemoteDataSource);

  @override
  Future<ApiResult<void>> createApplication(ApplyRequestModel request) async {
    return await applyRemoteDataSource.createApplication(request);
  }

  @override
  Future<ApiResult<List<UserApplicationJobModel>>> getUserApplications() async {
    return await applyRemoteDataSource.getUserApplications();
  }

  @override
  Future<ApiResult<void>> deleteApplication(String applicationId) {
    return applyRemoteDataSource.deleteApplication(applicationId);
  }

  @override
  Future<ApiResult<String>> deleteAllApplications() {
    return applyRemoteDataSource.deleteAllApplications();
  }
}
