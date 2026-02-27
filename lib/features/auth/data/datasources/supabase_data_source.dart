import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/api_result.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import 'auth_remote_data_source.dart';

class SupabaseDataSource extends AuthRemoteDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequestModel request) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );
      if (response.user != null) {
        return ApiResult.success(
          AuthResponse(user: response.user!, session: response.session),
        );
      } else {
        return ApiResult.error('Login failed: User is null');
      }
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequestModel request) async {
    try {
      final response = await supabase.auth.signUp(
        email: request.email,
        password: request.password,
        data: {'name': request.name},
      );

      if (response.user != null) {
        return ApiResult.success(
          AuthResponse(user: response.user!, session: response.session),
        );
      } else {
        return ApiResult.error('Registration failed: User is null');
      }
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // CacheHelper.delete();
    await supabase.auth.signOut();
  }
}
