import '../../../../core/networking/api_result.dart';
import '../models/apply_request_model.dart';

abstract class ApplyRemoteDataSource {
  Future<ApiResult<void>> createApplication(ApplyRequestModel request);
}
