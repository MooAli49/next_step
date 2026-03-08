import '../../../../core/networking/api_result.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request);
  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  );
}
