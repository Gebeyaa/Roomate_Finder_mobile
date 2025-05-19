class User {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String? token;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
} 