import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/provider_model.dart';

class RatingsReviewsCard extends StatelessWidget {
  final RatingBreakdown breakdown;
  final ReviewModel? review;

  const RatingsReviewsCard({super.key, required this.breakdown, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: AppDimens.d4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.d12,
          AppDimens.d12,
          AppDimens.d12,
          AppDimens.d16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AppDimens.d24,
                  height: AppDimens.d24,
                  decoration: BoxDecoration(
                    color: AppColors.ratingCardHeader,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    size: 14,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(width: AppDimens.d8),
                Text(
                  'Ratings & Reviews',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.d12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 84,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        breakdown.averageRating.toStringAsFixed(1),
                        style: AppTextStyles.heading1.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (_) => const Icon(
                            Icons.star,
                            color: AppColors.starGreen,
                            size: AppDimens.iconSm,
                          ),
                        )..add(
                            const Icon(
                              Icons.star_half,
                              color: AppColors.starGreen,
                              size: AppDimens.iconSm,
                            ),
                          ),
                      ),
                      const SizedBox(height: AppDimens.d4),
                      Text(
                        '${breakdown.totalReviews} Reviews',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimens.d12),
                Expanded(
                  child: Column(
                    children: [
                      _RatingBar(
                        star: 5,
                        fraction: breakdown.star5,
                        color: AppColors.barStar5,
                      ),
                      _RatingBar(
                        star: 4,
                        fraction: breakdown.star4,
                        color: AppColors.barStar4,
                      ),
                      _RatingBar(
                        star: 3,
                        fraction: breakdown.star3,
                        color: AppColors.barStar2,
                      ),
                      _RatingBar(
                        star: 2,
                        fraction: breakdown.star2,
                        color: AppColors.barStar2,
                      ),
                      _RatingBar(
                        star: 1,
                        fraction: breakdown.star1,
                        color: AppColors.barStar2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (review != null) ...[
              const SizedBox(height: AppDimens.d20),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      review!.reviewerAvatar,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorBuilder: (_, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(width: AppDimens.d12),
                  Text(
                    review!.reviewerName,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.d12),
              Row(
                children: List.generate(
                  review!.rating.toInt(),
                  (_) => const Icon(
                    Icons.star,
                    color: AppColors.starGreen,
                    size: AppDimens.iconMd,
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.d8),
              Text(
                review!.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.d4),
              Text(
                review!.body,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.d12),
              Row(
                children: review!.imageAssets.take(3).map((asset) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppDimens.d8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                      child: Image.asset(
                        asset,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        errorBuilder: (_, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final int star;
  final double fraction;
  final Color color;

  const _RatingBar({
    required this.star,
    required this.fraction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text(
              '$star',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.d4),
          Icon(
            Icons.star,
            color: color == AppColors.barStar5
                ? AppColors.starGreen
                : (color == AppColors.barStar4
                    ? AppColors.starYellow
                    : AppColors.barStar2),
            size: AppDimens.iconSm,
          ),
          const SizedBox(width: AppDimens.d8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
