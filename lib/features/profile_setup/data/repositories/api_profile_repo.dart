import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/profile_repo.dart';
import '../datasources/profile_data_source.dart';
import '../models/complete_profile_request_model.dart';
import '../models/user_model.dart';

class ApiProfileRepo extends ProfileRepo {
  final ProfileDataSource profileDataSource;

  ApiProfileRepo(this.profileDataSource);

  @override
  Future<ApiResult<UserModel>> completeProfile(
    CompleteProfileRequestModel profileModel,
  ) async {
    return await profileDataSource.completeProfile(profileModel);
  }
}
