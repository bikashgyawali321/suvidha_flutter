class BackendResponse {
  final String title;
  final String message;
  final dynamic data;

  BackendResponse({
    required this.title,
    required this.message,
    this.data,
  });

  factory BackendResponse.fromJson(Map<String, dynamic> json) {
    return BackendResponse(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      data: json['data'], // This is optional and may be null
    );
  }

  bool get isError => title == 'error';
}
