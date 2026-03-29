import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/apply_request_model.dart';
import '../models/user_applications_model/user_applications_model.dart';
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

  @override
  Future<ApiResult<List<UserApplicationsModel>>> getUserApplications() async {
    try {
      final response = await dio.get(ApiConstant.getUserApplicationsEp);

      final apiResponse =
          ApiResponseModel<List<UserApplicationsModel>>.fromJson(
            response.data,
            (json) => (json as List)
                .map(
                  (item) => UserApplicationsModel.fromJson(
                    item as Map<String, dynamic>,
                  ),
                )
                .toList(),
          );

      log(
        'ApiApplyDataSource.getUserApplications: response: ${apiResponse.message}',
      );

      if (apiResponse.success == true) {
        return ApiResult.success(apiResponse.data ?? []);
      } else {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: apiResponse.message ?? 'Failed to fetch applications',
            statusCode: apiResponse.statusCode,
          ),
        );
      }
    } on Exception catch (e) {
      final apiResponse =
          ApiResponseModel<List<UserApplicationsModel>>.fromJson(
            e is DioException && e.response != null ? e.response!.data : null,
            (json) => [],
          );

      log(
        'ApiApplyDataSource.getUserApplications: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<void>> deleteApplication(String applicationId) async {
    try {
      final response = await dio.delete(
        ApiConstant.deleteApplicationEp(applicationId),
      );

      if (response.statusCode == 200) {
        return ApiResult.success(null);
      } else {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: response.data['message'] ?? 'Failed to delete application',
            statusCode: response.statusCode,
          ),
        );
      }
    } on Exception catch (e) {
      log(
        'ApiApplyDataSource.deleteApplication: exception occurred: ${e.toString()}',
      );
      return ApiResult.error(e.toString());
    }
  }

  @override
  Future<ApiResult<String>> deleteAllApplications() async {
    try {
      final response = await dio.delete(
        ApiConstant.batchDeleteUserApplicationsEp,
      );

      if (response.statusCode == 200) {
        return ApiResult.success(
          response.data['message'] ?? 'All applications deleted successfully',
        );
      } else {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: response.data['message'] ?? 'Failed to delete application',
            statusCode: response.statusCode,
          ),
        );
      }
    } on Exception catch (e) {
      log(
        'ApiApplyDataSource.deleteApplication: exception occurred: ${e.toString()}',
      );
      return ApiResult.error(e.toString());
    }
  }
}
