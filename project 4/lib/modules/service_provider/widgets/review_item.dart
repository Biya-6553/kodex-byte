import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/provider_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  review.reviewerAvatar,
                  width: AppDimens.reviewAvatarSize,
                  height: AppDimens.reviewAvatarSize,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stackTrace) => Container(
                    width: AppDimens.reviewAvatarSize,
                    height: AppDimens.reviewAvatarSize,
                    color: AppColors.primaryLight,
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.d12),
              Text(
                review.reviewerName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.d8),
          Row(
            children: List.generate(
              review.rating.toInt(),
              (_) => const Icon(
                Icons.star,
                color: AppColors.starGreen,
                size: AppDimens.iconSm,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.d8),
          Text(
            review.title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.d4),
          Text(
            review.body,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.d12),
          Row(
            children: review.imageAssets
                .map(
                  (asset) => Padding(
                    padding: const EdgeInsets.only(right: AppDimens.d8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                      child: Image.asset(
                        asset,
                        width: AppDimens.reviewThumbSize,
                        height: AppDimens.reviewThumbSize,
                        fit: BoxFit.cover,
                        errorBuilder: (_, error, stackTrace) => Container(
                          width: AppDimens.reviewThumbSize,
                          height: AppDimens.reviewThumbSize,
                          color: AppColors.border,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
