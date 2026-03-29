import '../../../../core/networking/api_result.dart';
import '../models/apply_request_model.dart';
import '../models/user_applications_model/user_applications_model.dart';

abstract class ApplyRemoteDataSource {
  Future<ApiResult<void>> createApplication(ApplyRequestModel request);
  Future<ApiResult<List<UserApplicationsModel>>> getUserApplications();
  Future<ApiResult<void>> deleteApplication(String applicationId);
  Future<ApiResult<String>> deleteAllApplications();
}
