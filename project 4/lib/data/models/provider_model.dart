class ProviderModel {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String reviewCount;
  final String location;
  final int yearsExperience;
  final String aboutText;
  final List<LanguageModel> languages;
  final List<String> certifications;
  final RatingBreakdown ratingBreakdown;
  final List<ReviewModel> reviews;
  final List<ServiceModel> listedServices;

  const ProviderModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.yearsExperience,
    required this.aboutText,
    required this.languages,
    required this.certifications,
    required this.ratingBreakdown,
    required this.reviews,
    required this.listedServices,
  });
}

class LanguageModel {
  final String flagAsset;
  final String name;

  const LanguageModel({required this.flagAsset, required this.name});
}

class RatingBreakdown {
  final double averageRating;
  final int totalReviews;
  final double star5;
  final double star4;
  final double star3;
  final double star2;
  final double star1;

  const RatingBreakdown({
    required this.averageRating,
    required this.totalReviews,
    required this.star5,
    required this.star4,
    required this.star3,
    required this.star2,
    required this.star1,
  });
}

class ReviewModel {
  final String id;
  final String reviewerName;
  final String reviewerAvatar;
  final double rating;
  final String title;
  final String body;
  final List<String> imageAssets;

  const ReviewModel({
    required this.id,
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.rating,
    required this.title,
    required this.body,
    required this.imageAssets,
  });
}

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String providerName;
  final String providerAvatar;
  final double startingPrice;
  final String currency;
  final int durationMinutes;
  final String location;
  final double rating;
  final String reviewCount;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.providerName,
    required this.providerAvatar,
    required this.startingPrice,
    required this.currency,
    required this.durationMinutes,
    required this.location,
    required this.rating,
    required this.reviewCount,
  });
}
