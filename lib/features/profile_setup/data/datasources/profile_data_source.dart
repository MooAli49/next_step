import '../../../../core/networking/api_result.dart';
import '../models/complete_profile_request_model.dart';
import '../models/user_model.dart';

abstract class ProfileDataSource {
  Future<ApiResult<UserModel>> completeProfile(
    CompleteProfileRequestModel profileModel,
  );
}
