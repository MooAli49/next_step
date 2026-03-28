import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constant.dart';
import '../../../../core/networking/api_response_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/job_model.dart';
import 'jobs_data_source.dart';

class ApiJobsDataSource extends JobsDataSource {
  final Dio _dio = DioFactory().dio;

  @override
  Future<ApiResult<JobModel>> getJobDetails(String jobId) async {
    try {
      final response = await _dio.get(ApiConstant.getJobDetailsEp(jobId));

      final apiResponse = ApiResponseModel<JobModel>.fromJson(
        response.data,
        (json) => JobModel.fromJson(json),
      );

      log('ApiJobsDataSource.getJobDetails: response: ${apiResponse.message}');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Get job details failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => JobModel.fromJson(json),
      );

      log('ApiJobsDataSource.getJobDetails: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<void>> applyToJob(String jobId) async {
    try {
      await _dio.post(
        ApiConstant.getJobApplicationsEp(jobId),
        data: {'jobId': jobId},
      );

      log('ApiJobsDataSource.applyToJob: success for jobId: $jobId');
      return ApiResult.success(null);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => null,
      );

      log('ApiJobsDataSource.applyToJob: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<List<JobModel>>> getAllJobs({String limit = '10', int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.listJobsEp,
        queryParameters: {
          'limit': limit,
          'page': page,
        },
      );

      final apiResponse = ApiResponseModel<List<JobModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => JobModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      log('ApiJobsDataSource.getAllJobs: response: ${apiResponse.message}');

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Get all jobs failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => <JobModel>[],
      );

      log('ApiJobsDataSource.getAllJobs: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<void>> addFavoriteJob(String jobId) async {
    try {
      await _dio.post(ApiConstant.addFavoriteJobEp, data: {'jobId': jobId});

      log('ApiJobsDataSource.addFavoriteJob: success for jobId: $jobId');
      return ApiResult.success(null);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => null,
      );

      log('ApiJobsDataSource.addFavoriteJob: exception occurred: $apiResponse');
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<void>> removeFavoriteJob(String jobId) async {
    try {
      await _dio.delete(ApiConstant.removeFavoriteJobEp(jobId));

      log('ApiJobsDataSource.removeFavoriteJob: success for jobId: $jobId');
      return ApiResult.success(null);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => null,
      );

      log(
        'ApiJobsDataSource.removeFavoriteJob: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<void>> deleteAllFavorites() async {
    try {
      await _dio.delete(ApiConstant.batchDeleteUserFavoritesEp);

      log('ApiJobsDataSource.deleteAllFavorites: success');
      return ApiResult.success(null);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => null,
      );

      log(
        'ApiJobsDataSource.deleteAllFavorites: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }

  @override
  Future<ApiResult<List<JobModel>>> getFavoriteJobs() async {
    try {
      final response = await _dio.get(ApiConstant.listUserFavoritesEp);

      final apiResponse = ApiResponseModel<List<JobModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => JobModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      log(
        'ApiJobsDataSource.getFavoriteJobs: response: ${apiResponse.message}',
      );

      if (apiResponse.data == null) {
        return ApiResult.error(
          ApiResponseModel(
            success: false,
            message: 'Get favorite jobs failed: response data is null',
            statusCode: apiResponse.statusCode,
          ),
        );
      }

      return ApiResult.success(apiResponse.data!);
    } on Exception catch (e) {
      final apiResponse = ApiResponseModel.fromJson(
        e is DioException && e.response != null ? e.response!.data : null,
        (json) => <JobModel>[],
      );

      log(
        'ApiJobsDataSource.getFavoriteJobs: exception occurred: $apiResponse',
      );
      return ApiResult.error(apiResponse);
    }
  }
}
