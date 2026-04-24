import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/review_repository.dart';
import '../../modules/reviews/pages/rating_review_page.dart';
import '../../modules/reviews/viewmodels/rating_review_viewmodel.dart';
import 'app_routes.dart';

/// All route transitions use fadePage() — no custom per-route transitions.
CustomTransitionPage<T> fadePage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.ratingReviews,
  routes: [
    GoRoute(
      path: AppRoutes.ratingReviews,
      pageBuilder: (context, state) => fadePage(
        state: state,
        // ViewModels are provided at route level (preferred per blueprint)
        child: ChangeNotifierProvider(
          create: (ctx) => RatingReviewViewModel(ctx.read<ReviewRepository>()),
          child: const RatingReviewPage(),
        ),
      ),
    ),
  ],
);
