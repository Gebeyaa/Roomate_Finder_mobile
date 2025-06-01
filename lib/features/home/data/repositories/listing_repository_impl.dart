import 'package:dartz/dartz.dart';

import '../../domain/entities/listing_entity.dart';
import '../../domain/repositories/listing_repository.dart';
import '../datasources/listing_remote_data_source.dart';
import '../models/listing_model.dart';

class ListingRepositoryImpl implements ListingRepository {
  final ListingRemoteDataSource remoteDataSource;

  ListingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<ListingEntity>>> getListings() async {
    try {
      final result = await remoteDataSource.fetchListings();
      return Right(result);
    } catch (e) {
      return Left(Exception('Error loading listings: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> addListing(ListingEntity entity) async {
    try {
      final model = ListingModel(
        title: entity.title,
        description: entity.description,
        location: entity.location,
        pricing: entity.pricing,
        photos: entity.photos,
      );
      await remoteDataSource.createListing(model);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Error creating listing: $e'));
    }
  }
}
