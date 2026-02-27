import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/cache_constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class SupabaseRepositoryImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  SupabaseRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<AuthResponse> login(LoginRequestModel request) async {
    final response = await authRemoteDataSource.login(request);

    return response.when(
      onSuccess: (data) async {
        await _cacheTokens(data);

        return data;
      },
      onError: (error) {
        throw Exception(error);
      },
    );
  }

  @override
  Future<void> logout() async {
    await authRemoteDataSource.logout();
    await _clearCache();
  }

  @override
  Future<AuthResponse> register(RegisterRequestModel request) async {
    final response = await authRemoteDataSource.register(request);
    return response.when(
      onSuccess: (data) async {
        await _cacheTokens(data);

        return data;
      },
      onError: (error) {
        throw Exception(error);
      },
    );
  }

  Future<void> _cacheTokens(AuthResponse data) async {
    if (data.session != null) {
      await CacheHelper.setSecureData(
        key: CacheConstants.accessToken,
        value: data.session!.accessToken,
      );
      await CacheHelper.setSecureData(
        key: CacheConstants.refreshToken,
        value: data.session!.refreshToken!,
      );
    }

    if (data.user != null) {
      await CacheHelper.set(
        key: CacheConstants.userData,
        value: data.user!.toJson(),
      );
      await CacheHelper.set(key: CacheConstants.isUserLoggedIn, value: true);
    }

    log('Auth data cached successfully');
  }

  Future<void> _clearCache() async {
    await CacheHelper.deleteSecureData(key: CacheConstants.accessToken);
    await CacheHelper.deleteSecureData(key: CacheConstants.refreshToken);
    await CacheHelper.delete(key: CacheConstants.userData);
    await CacheHelper.delete(key: CacheConstants.isUserLoggedIn);
    log('Auth cache cleared');
  }
}
