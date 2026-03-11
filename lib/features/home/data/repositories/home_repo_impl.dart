import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/home_repos.dart';
import '../datasource/home_data_source.dart';
import '../models/home_stats_model/home_stats_model.dart';

class HomeRepoImpl extends HomeRepos {
  final HomeDataSource homeDataSource;
  HomeRepoImpl(this.homeDataSource);

  @override
  Future<ApiResult<HomeStatsModel>> getjobsStats() {
    return homeDataSource.getjobsStats();
  }
}
