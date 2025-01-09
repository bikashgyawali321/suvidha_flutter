class RegisterRequest {
  String name;
  String email;
  String password;
  double phoneNumber;

  final String role = "User";

  RegisterRequest(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'phoneNumber': phoneNumber
    };
  }
}
