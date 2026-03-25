import '../../../../core/networking/api_result.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/register_response_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request);
  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  );
  Future<ApiResult<UserModel>> getAuthenticatedUser();
}
