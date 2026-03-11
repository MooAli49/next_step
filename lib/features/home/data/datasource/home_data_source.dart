import '../../../../core/networking/api_result.dart';
import '../models/home_stats_model/home_stats_model.dart';

abstract class HomeDataSource {
  Future<ApiResult<HomeStatsModel>> getjobsStats();
}