import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/routes/app_router.dart';
import 'core/routes/route_names.dart';
import 'core/theme/app_theme.dart';
import 'features/home/data/datasources/listing_remote_data_source.dart';
import 'features/home/data/repositories/listing_repository_impl.dart';
import 'features/home/domain/repositories/listing_repository.dart';
import 'features/home/domain/usecases/get_listings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ListingRemoteDataSource remoteDataSource = ListingRemoteDataSourceImpl(
    http.Client(),
  );

  late final ListingRepository listingRepository = ListingRepositoryImpl(
    remoteDataSource,
  );

  late final GetListings getListings = GetListings(listingRepository);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ListingRepository>.value(value: listingRepository),
        RepositoryProvider<GetListings>.value(value: getListings),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arhibu',
        initialRoute: RouteNames.getstarted,
        onGenerateRoute: AppRouter.generateRoute,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
