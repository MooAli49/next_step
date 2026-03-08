import '../../../../core/networking/api_result.dart';
import '../../data/models/complete_profile_request_model.dart';
import '../../data/models/user_model.dart';

abstract class ProfileRepo {
  Future<ApiResult<UserModel>> completeProfile(
    CompleteProfileRequestModel profileModel,
  );
}
