
import '../../domain/entities/listing_entity.dart';

abstract class ListingState {}

class ListingInitial extends ListingState {}

class ListingLoading extends ListingState {}

class ListingLoaded extends ListingState {
  final List<ListingEntity> listings;
  ListingLoaded(this.listings);
}

class ListingError extends ListingState {
  final String message;
  ListingError(this.message);
}
