import '../../../../core/networking/api_result.dart';
import '../../data/models/apply_request_model.dart';
import '../../data/models/user_application_job_model.dart';

abstract class ApplyRepo {
  Future<ApiResult<void>> createApplication(ApplyRequestModel request);
  Future<ApiResult<List<UserApplicationJobModel>>> getUserApplications();
  Future<ApiResult<void>> deleteApplication(String applicationId);
  Future<ApiResult<String>> deleteAllApplications();
}
