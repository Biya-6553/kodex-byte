import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import 'star_rating.dart';

class RatingBarRow extends StatelessWidget {
  final int starCount;
  final double ratio;
  final int count;

  const RatingBarRow({
    super.key,
    required this.starCount,
    required this.ratio,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.d8),
      child: Row(
        children: [
          SizedBox(
            width: AppDimens.starBreakdownWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: StarRating(rating: starCount.toDouble(), size: AppDimens.iconXs, count: starCount),
            ),
          ),
          const SizedBox(width: AppDimens.d8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: AppDimens.progressBarHeight,
                backgroundColor: Colors.transparent,
                color: AppColors.ratingBar,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.d16),
          SizedBox(
            width: AppDimens.countWidth,
            child: Text(
              count.toString(),
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
