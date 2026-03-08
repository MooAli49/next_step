import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/complete_profile_request_model.dart';
import '../models/user_model.dart';
import 'profile_data_source.dart';

class ProfileApiDataSource extends ProfileDataSource {
  final Dio _dio = DioFactory().dio;

  @override
  Future<ApiResult<UserModel>> completeProfile(
    CompleteProfileRequestModel profileModel,
  ) async {
    try {
      final response = await _dio.patch(
        ApiConstant.patchUserProfileEP,
        data: profileModel.toJson(),
      );

      final apiResponse = ApiResponseModel.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      log('ProfileApiDataSource completeProfile response: $apiResponse');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Complete profile failed: response data is null',
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
      log('ProfileApiDataSource completeProfile error: $e');
      return ApiResult.error(apiResponse);
    }
  }
}
