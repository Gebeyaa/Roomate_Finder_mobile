
import 'package:dartz/dartz.dart';

import '../entities/listing_entity.dart';

abstract class ListingRepository {
  Future<Either<Exception, List<ListingEntity>>> getListings();
  Future<Either<Exception, void>> addListing(ListingEntity entity);
}
