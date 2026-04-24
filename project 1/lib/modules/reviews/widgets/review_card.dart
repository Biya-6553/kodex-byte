import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/review_model.dart';
import '../viewmodels/rating_review_viewmodel.dart';
import 'package:provider/provider.dart';
import 'star_rating.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: AppDimens.d16, left: AppDimens.d16),
          padding: const EdgeInsets.all(AppDimens.d24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: AppDimens.cardShadowBlur,
                offset: const Offset(0, AppDimens.cardShadowOffset),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(review.authorName, style: AppTextStyles.heading3),
              const SizedBox(height: AppDimens.d8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StarRating(rating: review.rating),
                  Text(
                    review.date,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.d16),
              Text(
                review.body,
                style: AppTextStyles.bodyMediumHeight,
              ),
              const SizedBox(height: AppDimens.d16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Helpful', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(width: AppDimens.d8),
                  InkWell(
                    onTap: () {
                      context.read<RatingReviewViewModel>().markHelpful(review.id);
                    },
                    child: Icon(
                      Icons.thumb_up,
                      size: AppDimens.iconSm,
                      color: review.helpfulCount > 0 ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: CircleAvatar(
            radius: AppDimens.avatarRadius,
            backgroundImage: review.authorAvatarUrl != null
                ? (review.authorAvatarUrl!.startsWith('assets/')
                    ? AssetImage(review.authorAvatarUrl!) as ImageProvider
                    : NetworkImage(review.authorAvatarUrl!))
                : null,
            child: review.authorAvatarUrl == null
                ? const Icon(Icons.person, size: AppDimens.iconSm)
                : null,
          ),
        ),
      ],
    );
  }
}
