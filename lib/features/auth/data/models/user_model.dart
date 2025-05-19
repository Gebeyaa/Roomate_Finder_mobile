import '../../domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  UserModel({
    required String userName,
    required String email,
    required String password,
  }) : super(userName: userName, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'email': email, 'password': password};
  }
}
