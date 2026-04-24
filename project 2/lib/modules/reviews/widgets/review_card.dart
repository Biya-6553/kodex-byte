import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/review_model.dart';
import '../viewmodels/rating_review_viewmodel.dart';
import 'star_rating.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // ✅ FIXED avatar image type safely
    ImageProvider? avatarImage;
    if (review.authorAvatarUrl != null) {
      if (review.authorAvatarUrl!.startsWith('assets/')) {
        avatarImage = AssetImage(review.authorAvatarUrl!);
      } else {
        avatarImage = NetworkImage(review.authorAvatarUrl!);
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.d16,
            left: AppDimens.d16,
          ),
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
              // ✅ FIXED overflow Row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      review.authorName,
                      style: AppTextStyles.heading3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    review.date,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: AppDimens.d8),

              StarRating(
                rating: review.rating,
                size: AppDimens.iconSm,
              ),

              const SizedBox(height: AppDimens.d16),

              Text(
                review.body,
                style: AppTextStyles.bodyMediumHeight,
              ),

              if (review.photoPath != null) ...[
                const SizedBox(height: AppDimens.d12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  child: Image.file(
                    File(review.photoPath!),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: AppDimens.d16),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Helpful',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppDimens.d8),
                  InkWell(
                    onTap: () => context
                        .read<RatingReviewViewModel>()
                        .markHelpful(review.id),
                    child: Icon(
                      Icons.thumb_up,
                      size: AppDimens.iconSm,
                      color: review.helpfulCount > 0
                          ? AppColors.primary
                          : AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ✅ Avatar (fixed)
        Positioned(
          top: 0,
          left: 0,
          child: CircleAvatar(
            radius: AppDimens.avatarRadius,
            backgroundImage: avatarImage,
            child: avatarImage == null
                ? const Icon(Icons.person, size: AppDimens.iconSm)
                : null,
          ),
        ),
      ],
    );
  }
}
