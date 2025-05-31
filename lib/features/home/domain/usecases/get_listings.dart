
import 'package:dartz/dartz.dart';

import '../entities/listing_entity.dart';
import '../repositories/listing_repository.dart';

class GetListings {
  final ListingRepository repository;

  GetListings(this.repository);

  Future<Either<Exception, List<ListingEntity>>> call() {
    return repository.getListings();
  }
}

class CreateListing {
  final ListingRepository repository;

  CreateListing(this.repository);

  Future<Either<Exception, void>> call(ListingEntity entity) {
    return repository.addListing(entity);
  }
}
