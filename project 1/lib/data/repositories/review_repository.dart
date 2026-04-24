import '../models/review_model.dart';
import '../models/rating_summary_model.dart';

/// ReviewRepository is the single source of truth for review data.
/// It calls ApiClient (mocked here with in-memory data for demo).
/// ViewModels NEVER call ApiClient directly — they go through this repository.
class ReviewRepository {
  // ── Simulated remote data ──────────────────────────────────────────────────
  final List<ReviewModel> _reviews = [
    const ReviewModel(
      id: '1',
      authorName: 'Helene Moore',
      rating: 4,
      date: 'June 5, 2019',
      body:
          "The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7\" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.",
      helpfulCount: 3,
      hasPhoto: false,
      authorAvatarUrl: 'assets/images/g1.png',
    ),
    const ReviewModel(
      id: '2',
      authorName: 'Kate Doe',
      rating: 5,
      date: 'July 12, 2019',
      body:
          'Absolutely love this product! Would definitely buy again. Great quality and fast shipping.',
      helpfulCount: 1,
      hasPhoto: true,
      authorAvatarUrl: 'assets/images/g1.png',
    ),
    const ReviewModel(
      id: '3',
      authorName: 'Anna Smith',
      rating: 3,
      date: 'August 3, 2019',
      body:
          'Decent product. The sizing runs a bit small. Color is exactly as shown in pictures.',
      helpfulCount: 0,
      hasPhoto: false,
      authorAvatarUrl: 'assets/images/g1.png',
    ),
  ];

  Future<List<ReviewModel>> getReviews() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.unmodifiable(_reviews);
  }

  Future<RatingSummaryModel> getRatingSummary() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _computeSummary();
  }

  Future<ReviewModel> addReview(ReviewModel review) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _reviews.insert(0, review);
    return review;
  }

  Future<ReviewModel> markHelpful(String reviewId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final idx = _reviews.indexWhere((r) => r.id == reviewId);
    if (idx == -1) throw Exception('Review not found');
    final updated = _reviews[idx].copyWith(
      helpfulCount: _reviews[idx].helpfulCount + 1,
    );
    _reviews[idx] = updated;
    return updated;
  }

  // ── Private helpers ────────────────────────────────────────────────────────
  RatingSummaryModel _computeSummary() {
    final breakdown = List<int>.filled(5, 0);
    for (final r in _reviews) {
      final idx = (r.rating.clamp(1, 5) - 1).toInt();
      breakdown[idx]++;
    }
    final avg = _reviews.isEmpty
        ? 0.0
        : _reviews.map((r) => r.rating).reduce((a, b) => a + b) /
            _reviews.length;
    return RatingSummaryModel(
      averageRating: double.parse(avg.toStringAsFixed(1)),
      totalRatings: _reviews.length,
      breakdown: breakdown,
    );
  }
}
