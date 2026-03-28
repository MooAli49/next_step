import '../models/update_profile_request_model.dart';

abstract class SettingsDataSource {
  Future<dynamic> updateProfile(UpdateProfileRequestModel requestModel);
}
