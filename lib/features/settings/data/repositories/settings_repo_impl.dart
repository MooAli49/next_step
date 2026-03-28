import '../../../../core/networking/api_result.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../../domain/repositories/settings_repo.dart';
import '../datasource/settings_data_source.dart';
import '../models/update_profile_request_model.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsDataSource settingsDataSource;

  SettingsRepoImpl(this.settingsDataSource);
  @override
  Future<ApiResult<UserModel>> updateProfile(
    UpdateProfileRequestModel requestModel,
  ) async {
    return await settingsDataSource.updateProfile(requestModel);
  }
}
