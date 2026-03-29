import '../../../../core/networking/api_result.dart';
import '../../data/models/apply_request_model.dart';

abstract class ApplyRepo {
  Future<ApiResult<void>> createApplication(ApplyRequestModel request);
}
