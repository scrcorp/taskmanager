class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool isSuccess;
  final int? statusCode;

  const ApiResponse({
    this.data,
    this.message,
    this.isSuccess = true,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      message: message,
      isSuccess: true,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      message: message,
      isSuccess: false,
      statusCode: statusCode,
    );
  }
}
