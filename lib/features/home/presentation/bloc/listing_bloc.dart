

import 'package:flutter_bloc/flutter_bloc.dart';
import 'listing_event.dart';
import 'listing_state.dart';
import '../../domain/usecases/get_listings.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final GetListings getListings;

  ListingBloc(this.getListings) : super(ListingInitial()) {
    on<LoadListings>((event, emit) async {
      emit(ListingLoading());
      final result = await getListings();
      result.fold(
        (error) => emit(ListingError(error.toString())),
        (listings) => emit(ListingLoaded(listings)),
      );
    });
  }
}
