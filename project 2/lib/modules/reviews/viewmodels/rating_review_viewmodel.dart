import 'package:flutter/foundation.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/rating_summary_model.dart';
import '../../../data/repositories/review_repository.dart';
import '../../../core/errors/failure.dart';

class RatingReviewViewModel extends ChangeNotifier {
  final ReviewRepository _repo;
  RatingReviewViewModel(this._repo);

  // ── State ──────────────────────────────────────────────────────────────────
  List<ReviewModel> reviews = [];
  RatingSummaryModel? ratingSummary;
  bool isLoading = false;
  bool isSubmitting = false;
  Failure? error;
  bool withPhotoFilter = false;

  // ── Derived ───────────────────────────────────────────────────────────────
  List<ReviewModel> get filteredReviews =>
      withPhotoFilter ? reviews.where((r) => r.hasPhoto).toList() : reviews;

  // ── Init ──────────────────────────────────────────────────────────────────
  Future<void> init() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repo.getReviews(),
        _repo.getRatingSummary(),
      ]);
      reviews = results[0] as List<ReviewModel>;
      ratingSummary = results[1] as RatingSummaryModel;
      error = null;
    } catch (e) {
      error = const UnknownFailure();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ── Toggle filter ─────────────────────────────────────────────────────────
  void toggleWithPhoto() {
    withPhotoFilter = !withPhotoFilter;
    notifyListeners();
  }

  // ── Mark helpful ──────────────────────────────────────────────────────────
  Future<void> markHelpful(String reviewId) async {
    try {
      final updated = await _repo.markHelpful(reviewId);
      final idx = reviews.indexWhere((r) => r.id == reviewId);
      if (idx != -1) {
        reviews = List.from(reviews)..[idx] = updated;
        notifyListeners();
      }
    } catch (_) {
      // silent — helpful tap is non-critical
    }
  }

  // ── Submit new review (now accepts optional photoPath) ────────────────────
  Future<bool> submitReview({
    required String authorName,
    required double rating,
    required String body,
    String? photoPath,
  }) async {
    isSubmitting = true;
    error = null;
    notifyListeners();
    try {
      final saved = await _repo.addReviewWithPhoto(
        authorName: authorName,
        rating: rating,
        body: body,
        photoPath: photoPath,
      );
      reviews = [saved, ...reviews];
      ratingSummary = await _repo.getRatingSummary();
      return true;
    } catch (e) {
      error = const UnknownFailure();
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
