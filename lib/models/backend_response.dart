class BackendResponse {
  final String message;
  final int status;
  final dynamic data;

  BackendResponse({
    required this.message,
    required this.status,
    this.data,
  });

  factory BackendResponse.fromJson(Map<String, dynamic> json) {
    return BackendResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      data: json['data'],
    );
  }
}
