// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../../../../core/params/params.dart';
// import '../models/user_model.dart';

// class UserRemoteDataSource {
//   final ApiConsumer api;

//   UserRemoteDataSource({required this.api});
//   Future<UserModel> getUser(UserParams params) async {
//     final response = await api.get("${EndPoints.user}/");
//     return UserModel.fromJson(response);
//   }

//   Future<UserModel> signupUser
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class RegisterResult {
  final bool success;
  final String? errorMessage;
  RegisterResult(this.success, {this.errorMessage});
}

class LoginResult {
  final bool success;
  final String? errorMessage;
  LoginResult(this.success, {this.errorMessage});
}

class RemoteDatasource {
  Future<RegisterResult> register(UserModel user) async {
    final userToJson = user.toJson();
    final uri = Uri.parse(
      "https://visit-addis.onrender.com/api/v1/auth/register",
    );
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userToJson),
      );
      if (response.statusCode == 201) {
        return RegisterResult(true);
      } else {
        String errorMsg = 'Registration failed. Please try again.';
        try {
          final data = json.decode(response.body);
          if (data is Map && data['message'] != null) {
            errorMsg = data['message'];
          }
        } catch (_) {}
        return RegisterResult(false, errorMessage: errorMsg);
      }
    } catch (e) {
      return RegisterResult(
        false,
        errorMessage: 'Network error. Please try again.',
      );
    }
  }

  Future<LoginResult> login(String email, String password) async {
    final uri = Uri.parse("https://visit-addis.onrender.com/api/v1/auth/login");
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        return LoginResult(true);
      } else {
        String errorMsg = 'Login failed. Please try again.';
        try {
          final data = json.decode(response.body);
          if (data is Map && data['message'] != null) {
            errorMsg = data['message'];
          }
        } catch (_) {}
        return LoginResult(false, errorMessage: errorMsg);
      }
    } catch (e) {
      return LoginResult(
        false,
        errorMessage: 'Network error. Please try again.',
      );
    }
  }
}
