class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isEmailVerified;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isEmailVerified: json['isEmailVerified'],
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'isEmailVerified': isEmailVerified,
    };
  }
}
