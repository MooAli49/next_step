import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/home_stats_model/home_stats_model.dart';
import 'home_data_source.dart';

class ApiHomeDataSource extends HomeDataSource {
  final Dio _dio = DioFactory().dio;

  @override
  Future<ApiResult<HomeStatsModel>> getjobsStats() async {
    try {
      final reponse = await _dio.get(ApiConstant.getPlatformStatsEp);

      if (reponse.data is! Map<String, dynamic>) {
        return ApiResult.error(
          ApiResponseModel(success: false, message: 'Invalid response format'),
        );
      }

      final apiResponse = ApiResponseModel<HomeStatsModel>.fromJson(
        reponse.data as Map<String, dynamic>,
        (data) => HomeStatsModel.fromJson(data),
      );

      log('ApiHomeDataSource.getjobsStats: response: $apiResponse');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Failed to fetch job stats: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      log('ApiHomeDataSource.getjobsStats: error: $e');
      final responseData =
          e is DioException && e.response?.data is Map<String, dynamic>
          ? e.response!.data as Map<String, dynamic>
          : null;
      if (responseData == null) {
        return ApiResult.error(
          ApiResponseModel(success: false, message: e.toString()),
        );
      }
      final apiResponse = ApiResponseModel.fromJson(
        responseData,
        (data) => HomeStatsModel.fromJson(data),
      );
      return ApiResult.error(apiResponse);
    }
  }
}
