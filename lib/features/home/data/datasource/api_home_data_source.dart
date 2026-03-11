import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:next_step/core/networking/api_constant.dart';
import 'package:next_step/core/networking/api_response_model.dart';
import 'package:next_step/core/networking/api_result.dart';
import 'package:next_step/core/networking/dio_factory.dart';
import 'package:next_step/features/home/data/models/home_stats_model/home_stats_model.dart';

import 'home_data_source.dart';

class ApiHomeDataSource extends HomeDataSource {
  final Dio _dio = DioFactory().dio;

  @override
  Future<ApiResult<HomeStatsModel>> getjobsStats() async {
    try {
      final reponse = await _dio.get(ApiConstant.getPlatformStatsEp);

      final apiResponse = ApiResponseModel<HomeStatsModel>.fromJson(
        reponse.data,
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
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (data) => HomeStatsModel.fromJson(data),
      );
      return ApiResult.error(apiResponse);
    }
  }
}
