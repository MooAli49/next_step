import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/apply_request_model.dart';
import 'apply_remote_data_source.dart';

class ApiApplyDataSource extends ApplyRemoteDataSource {
  Dio dio = DioFactory().dio;

  @override
  Future<ApiResult<void>> createApplication(ApplyRequestModel request) async {
    try {
      final response = await dio.post(
        ApiConstant.createApplicationEp,
        data: request.toJson(),
      );

      final apiResponse = ApiResponseModel<dynamic>.fromJson(response.data, (
        json,
      ) {
        // We don't need to parse the response data into a model since we're only interested in success/failure
        return null;
      });

      log(
        'ApiApplyDataSource.createApplication: response: ${apiResponse.message}',
      );

      if (apiResponse.success == true) {
        return ApiResult.success(null);
      } else {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: apiResponse.message ?? 'Application failed',
            statusCode: apiResponse.statusCode,
          ),
        );
      }
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel<dynamic>.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => null,
      );

      log(
        'ApiApplyDataSource.createApplication: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }
}
