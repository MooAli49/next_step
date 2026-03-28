import '../../../../core/networking/api_result.dart';
import '../../data/models/home_stats_model/home_stats_model.dart';

abstract class HomeRepos {
  Future<ApiResult<HomeStatsModel>> getjobsStats();
}
