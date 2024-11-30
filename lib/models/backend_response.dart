class BackendResponse<T> {
  int statusCode;
  T? result;
  String? error;

  BackendResponse({required this.statusCode, this.result, this.error});

  factory BackendResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return BackendResponse<T>(
      statusCode: json['statusCode'],
      result: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'],
    );
  }
}
