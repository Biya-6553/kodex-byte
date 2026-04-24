class ReviewModel {
  final String id;
  final String authorName;
  final String? authorAvatarUrl;
  final double rating;
  final String date;
  final String body;
  final int helpfulCount;
  final bool hasPhoto;

  const ReviewModel({
    required this.id,
    required this.authorName,
    this.authorAvatarUrl,
    required this.rating,
    required this.date,
    required this.body,
    this.helpfulCount = 0,
    this.hasPhoto = false,
  });

  ReviewModel copyWith({
    String? id,
    String? authorName,
    String? authorAvatarUrl,
    double? rating,
    String? date,
    String? body,
    int? helpfulCount,
    bool? hasPhoto,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      body: body ?? this.body,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      hasPhoto: hasPhoto ?? this.hasPhoto,
    );
  }
}
