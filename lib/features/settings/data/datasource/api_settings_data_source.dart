import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../profile_setup/data/models/user_model.dart';
import '../models/update_profile_request_model.dart';
import 'settings_data_source.dart';

class ApiSettingsDataSource extends SettingsDataSource {
  final Dio _dio = DioFactory().dio;

  @override
  Future<ApiResult<UserModel>> updateProfile(
    UpdateProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _dio.patch(
        ApiConstant.patchUserProfileEP,
        data: requestModel.toJson(),
      );

      final apiResponse = ApiResponseModel<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      log('Update Profile Response: ${apiResponse.data}');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Update profile failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (data) => UserModel.fromJson(data),
      );

      log('Update Profile Error: $apiResponse');

      return ApiResult.error(apiResponse);
    }
  }
}
