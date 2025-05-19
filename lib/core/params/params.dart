class TemplateParams {
  final String id;
  TemplateParams({required this.id});
}

// core/params/params.dart
class UserParams {
  final String username;
  final String email;
  final String password;

  UserParams({
    required this.username,
    required this.email,
    required this.password,
  });
}

class PostParams {
  final String id;
  PostParams({required this.id});
}
