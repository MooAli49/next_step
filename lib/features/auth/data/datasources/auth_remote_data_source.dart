import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/api_result.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<AuthResponse>> login(LoginRequestModel request);
  Future<ApiResult<AuthResponse>> register(RegisterRequestModel request);
  Future<void> logout();
  // forgotPassword(String email);
}
