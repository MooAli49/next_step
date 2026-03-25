import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import 'auth_remote_data_source.dart';

class AuthApiDataSource extends AuthRemoteDataSource {
  Dio dio = DioFactory().dio;

  @override
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        ApiConstant.loginEp,
        data: request.toJson(),
      );

      final apiResponse = ApiResponseModel<LoginResponseModel>.fromJson(
        response.data,
        (json) => LoginResponseModel.fromJson(json),
      );

      log('AuthRemoteDataSource.login: response: ${apiResponse.message}');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Login failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => LoginResponseModel.fromJson(json),
      );

      log('AuthRemoteDataSource.login: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstant.registerEp,
        data: request.toJson(),
      );

      final apiResponse = ApiResponseModel<RegisterResponseModel>.fromJson(
        response.data,
        (json) => RegisterResponseModel.fromJson(json),
      );

      log('AuthRemoteDataSource.register: response: ${apiResponse.message}');

      if (response.statusCode != 201) {
        log(
          'AuthRemoteDataSource.register: non-201 status code: ${response.statusCode}',
        );
        return ApiResult.error(apiResponse);
      }

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Register failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => RegisterResponseModel.fromJson(json),
      );

      log('AuthRemoteDataSource.register: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<UserModel>> getAuthenticatedUser() async {
    try {
      final response = await dio.get(ApiConstant.getAuthauthenticatedUserEp);

      final apiResponse = ApiResponseModel<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );

      log(
        'AuthRemoteDataSource.getAuthenticatedUser: response: ${apiResponse.message}',
      );

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Get authenticated user failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => UserModel.fromJson(json),
      );

      log(
        'AuthRemoteDataSource.getAuthenticatedUser: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }
}
