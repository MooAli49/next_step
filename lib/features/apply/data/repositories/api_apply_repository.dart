import '../../../../core/networking/api_result.dart';
import '../../domain/repositories/apply_repo.dart';
import '../datasources/apply_remote_data_source.dart';
import '../models/apply_request_model.dart';

class ApiApplyRepository extends ApplyRepo {
  final ApplyRemoteDataSource applyRemoteDataSource;
  ApiApplyRepository(this.applyRemoteDataSource);

  @override
  Future<ApiResult<void>> createApplication(ApplyRequestModel request) async {
    return await applyRemoteDataSource.createApplication(request);
  }
}
