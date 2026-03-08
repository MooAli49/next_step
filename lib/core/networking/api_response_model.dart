class ApiResponseModel<T> {
  bool? success;
  String? message;
  T? data;
  String? timestamp;
  int? statusCode;

  ApiResponseModel({
    this.success,
    this.message,
    this.data,
    this.timestamp,
    this.statusCode,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponseModel<T>(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
      timestamp: json['timestamp'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }

  @override
  String toString() {
    return 'ApiResponseModel{success: $success, message: $message, data: $data, timestamp: $timestamp, statusCode: $statusCode}';
  }
}
