import 'api_response_model.dart';

class ApiResult<T> {
  ApiResult._();
  factory ApiResult.success(T data) = ApiSuccess<T>;
  factory ApiResult.error(Object error) = ApiError<T>;
  dynamic when({
    required Function(T data) onSuccess,
    required Function(ApiResponseModel error) onError,
  }) {
    if (this is ApiSuccess<T>) {
      return onSuccess((this as ApiSuccess<T>).data);
    } else {
      return onError((this as ApiError<T>).error as ApiResponseModel);
    }
  }
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  ApiSuccess(this.data) : super._();
}

class ApiError<T> extends ApiResult<T> {
  final Object error;

  ApiError(this.error) : super._();
}
