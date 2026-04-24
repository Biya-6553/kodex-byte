class ExpertModel {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isTopRated;
  final bool offersHomeVisit;
  final bool offersAtProvider;
  final String location;
  final String avatarUrl;

  ExpertModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.isTopRated,
    required this.offersHomeVisit,
    required this.offersAtProvider,
    required this.location,
    required this.avatarUrl,
  });
}
