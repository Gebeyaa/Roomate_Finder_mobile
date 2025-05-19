// import 'package:dartz/dartz.dart';

// import '../../../../core/connection/network_info.dart';
// import '../../../../core/errors/expentions.dart';
// import '../../../../core/errors/failure.dart';
// import '../../../../core/params/params.dart';
// import '../../../auth/domain/entities/user_entitiy.dart';
// import '../../domain/repositories/user_repository.dart';
// import '../datasources/user_local_data_source.dart';
// import '../datasources/user_remote_data_source.dart';

// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource remoteDataSource;

//   UserRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, UserEntity>> getUser({
//     required UserParams params,
//   }) async {
//     try {
//       final user = await remoteDataSource.signupUser(
//         username: params.username,
//         email: params.email,
//         password: params.password,
//       );
//       return Right(user);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
