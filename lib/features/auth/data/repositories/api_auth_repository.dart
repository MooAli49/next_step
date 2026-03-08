import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class ApiAuthRepository extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  ApiAuthRepository(this.authRemoteDataSource);

  @override
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    return await authRemoteDataSource.login(request);
  }

  @override
  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    return await authRemoteDataSource.register(request);
  }
}
