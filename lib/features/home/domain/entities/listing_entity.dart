

class ListingEntity {
  final String title;
  final String description;
  final String location;
  final Pricing pricing;
  final List<Photo> photos;

  ListingEntity({
    required this.title,
    required this.description,
    required this.location,
    required this.pricing,
    required this.photos,
  });
}

class Pricing {
  final int basePrice;
  final String currency;

  Pricing({required this.basePrice, required this.currency});
}

class Photo {
  final String id;
  final String url;
  final bool isPrimary;

  Photo({required this.id, required this.url, required this.isPrimary});
}
