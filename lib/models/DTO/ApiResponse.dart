class ApiResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['code'] == 200, // Kiểm tra mã trạng thái
      message: json['message'] ?? 'Unknown error',
      data: json['data'] ?? {},
    );
  }
}
