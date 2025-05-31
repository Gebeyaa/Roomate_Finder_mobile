import 'dart:convert';

import '../../domain/entities/listing_entity.dart';

class ListingModel extends ListingEntity {
  ListingModel({
    required super.title,
    required super.description,
    required super.location,
    required super.pricing,
    required super.photos,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> photosJson = jsonDecode(json['photos']);

    return ListingModel(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      pricing: Pricing(
        basePrice: json['basePrice'],
        currency: json['currency'],
      ),
      photos:
          photosJson
              .map(
                (p) => Photo(
                  id: p['id'],
                  url: p['url'],
                  isPrimary: p['isPrimary'],
                ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "location": location,
      "pricing": {"basePrice": pricing.basePrice, "currency": pricing.currency},
      "photos":
          photos
              .map((p) => {"id": p.id, "url": p.url, "isPrimary": p.isPrimary})
              .toList(),
    };
  }
}
