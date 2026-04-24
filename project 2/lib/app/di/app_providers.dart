import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../data/repositories/review_repository.dart';
import '../../modules/reviews/viewmodels/rating_review_viewmodel.dart';

/// Composition root — the ONLY place where dependencies are wired.
/// Nothing else creates repositories or services.
List<SingleChildWidget> appProviders() => [
      // Repositories
      Provider<ReviewRepository>(
        create: (_) => ReviewRepository(),
      ),

      // Feature-level ViewModel — provided at route level (see app_router.dart)
      // For demo, we expose it app-wide so the standalone demo works.
      ChangeNotifierProvider<RatingReviewViewModel>(
        create: (ctx) => RatingReviewViewModel(ctx.read<ReviewRepository>()),
      ),
    ];
