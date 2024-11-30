class User {
  String name;
  String email;
  String password;
  String phonenumber;

  User(
      {
    required this.name,
      required this.email,
      required this.password,
    required this.phonenumber,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      name: json['name'],
        email: json['email'],
        password: json['password'],
      phonenumber: json['phonenumber'],
    );
  }

//factory constructoor to map the user object to json
  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
    };
  }
}
