import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import '../models/user_model.dart';

class UserLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedUser";
  UserLocalDataSource({required this.cache});

  cacheUser(UserModel? UserToCache) {
    if (UserToCache != null) {
      cache.saveData(
        key: key,
        value: json.encode(
          UserToCache.toJson(),
        ),
      );
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<UserModel> getLastUser() {
    final jsonString = cache.getDataString(key: key);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
}
