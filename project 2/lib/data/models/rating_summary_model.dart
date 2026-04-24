class RatingSummaryModel {
  final double averageRating;
  final int totalRatings;

  /// breakdown[0] = count for 1 star, breakdown[4] = count for 5 stars
  final List<int> breakdown;

  const RatingSummaryModel({
    required this.averageRating,
    required this.totalRatings,
    required this.breakdown,
  });

  RatingSummaryModel copyWith({
    double? averageRating,
    int? totalRatings,
    List<int>? breakdown,
  }) {
    return RatingSummaryModel(
      averageRating: averageRating ?? this.averageRating,
      totalRatings: totalRatings ?? this.totalRatings,
      breakdown: breakdown ?? this.breakdown,
    );
  }
}
