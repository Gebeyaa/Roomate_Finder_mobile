import 'package:arhibu/features/chat/presentation/screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/listing_entity.dart';
import '../bloc/listing_bloc.dart';
import '../bloc/listing_event.dart';
import '../bloc/listing_state.dart';
import 'filter_screen.dart';
import 'home_page_detail.dart';
import 'search_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late ListingBloc _listingBloc;
  bool _showSearchBar = false;
  String _searchQuery = "";
  List<ListingEntity> _allListings = [];

  @override
  void initState() {
    super.initState();
    _listingBloc = BlocProvider.of<ListingBloc>(context);
    _listingBloc.add(LoadListings());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildHomePageContent() {
    return BlocBuilder<ListingBloc, ListingState>(
      builder: (context, state) {
        if (state is ListingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListingLoaded) {
          _allListings = state.listings;
          final listings =
              state.listings.where((listing) {
                if (_searchQuery.isEmpty) return true;
                final query = _searchQuery.toLowerCase();
                return listing.title.toLowerCase().contains(query) ||
                    listing.location.toLowerCase().contains(query) ||
                    listing.description.toLowerCase().contains(query);
              }).toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listing = listings[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePageDetailScreen(listing: listing),
                    ),
                  );
                },
                child: _buildRoommateCard(listing),
              );
            },
          );
        } else if (state is ListingError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRoommateCard(ListingEntity listing) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("images/home2.png"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listing.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "10 min ago",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${listing.pricing.basePrice} ${listing.pricing.currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              listing.location,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              listing.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePageDetailScreen(listing: listing),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  listing.photos.first.url,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Message",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ChatDetailScreen(
                              name: listing.title.split(' - ').first,
                              avatarUrl: listing.photos.first.url,
                              isOnline: true,
                            ),
                      ),
                    );
                  },
                  child: Icon(Icons.chat_bubble_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchSubmitted(String value) {
    if (value.trim().isNotEmpty && _allListings.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => SearchScreen(searchQuery: value, listings: _allListings),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('images/Vector.svg', color: Colors.white),
        ),
        title:
            _showSearchBar
                ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search listings...",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSubmitted: _onSearchSubmitted,
                  textInputAction: TextInputAction.search,
                )
                : const Text("Roommates"),
        actions: [
          if (!_showSearchBar) ...[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.search, size: 24),
                onPressed: () {
                  setState(() {
                    _showSearchBar = true;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.filter_list, size: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
          if (_showSearchBar)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () {
                  setState(() {
                    _showSearchBar = false;
                    _searchQuery = "";
                  });
                },
              ),
            ),
        ],
      ),
      body: _buildHomePageContent(),
    );
  }
}
