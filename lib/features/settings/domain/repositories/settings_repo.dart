import '../../../../core/networking/api_result.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../../data/models/update_profile_request_model.dart';

abstract class SettingsRepo {
  Future<ApiResult<UserModel>> updateProfile(
    UpdateProfileRequestModel requestModel,
  );
}
