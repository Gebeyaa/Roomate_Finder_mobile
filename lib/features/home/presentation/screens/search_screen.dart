import 'package:flutter/material.dart';

import '../../domain/entities/listing_entity.dart';
import 'home_page_detail.dart';

class SearchScreen extends StatelessWidget {
  final String searchQuery;
  final List<ListingEntity> listings;

  const SearchScreen({
    Key? key,
    required this.searchQuery,
    required this.listings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredListings =
        listings
            .where(
              (listing) => listing.location.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$searchQuery"')),
      body:
          filteredListings.isEmpty
              ? const Center(child: Text("No listings found."))
              : ListView.separated(
                itemCount: filteredListings.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  final listing = filteredListings[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          listing.photos.first.url,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(listing.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listing.location),
                          const SizedBox(height: 4),
                          Text(
                            listing.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${listing.pricing.basePrice} ${listing.pricing.currency}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => HomePageDetailScreen(listing: listing),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
