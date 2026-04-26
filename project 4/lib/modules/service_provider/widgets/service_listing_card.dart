import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/provider_model.dart';

class ServiceListingCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceListingCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width - (AppDimens.d16 * 2);
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: AppDimens.d12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimens.radiusMd),
                ),
                child: Image.asset(
                  service.imagePath,
                  width: double.infinity,
                  height: 176,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stackTrace) => Container(
                    height: 176,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              Positioned(
                top: AppDimens.d8,
                right: AppDimens.d8,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    size: 13,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 1 ? AppColors.textWhite : AppColors.border,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: AppDimens.d12,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.surface, width: 3),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          service.providerAvatar,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, error, stackTrace) => const SizedBox(
                            width: 64,
                            height: 64,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 2,
                      bottom: 2,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.surface,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: AppColors.verifiedGreen,
                          child: Icon(
                            Icons.check,
                            size: 10,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: AppDimens.d8,
                right: AppDimens.d8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  child: Text(
                    '${service.rating} \u2022 ${service.reviewCount}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.d12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        service.providerName,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const _Pill(
                      text: 'Home visit',
                      textColor: AppColors.chipHomeVisitText,
                      bg: AppColors.chipHomeVisitBg,
                    ),
                    const SizedBox(width: AppDimens.d8),
                    const _Pill(
                      text: 'At Provider',
                      textColor: AppColors.chipProviderText,
                      bg: AppColors.chipProviderBg,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.d8),
                Text(
                  service.title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.d4),
                Text(
                  service.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.d12),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_outlined,
                      size: AppDimens.iconMd,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimens.d4),
                    Text(
                      'Starting ${service.currency}${service.startingPrice.toInt()}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppDimens.d12),
                    const Icon(
                      Icons.access_time,
                      size: AppDimens.iconMd,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimens.d4),
                    Text(
                      '${service.durationMinutes} min ~',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      AppAssets.icLocation,
                      width: AppDimens.iconMd,
                      height: AppDimens.iconMd,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder: (_) => const Icon(
                        Icons.location_on_outlined,
                        size: AppDimens.iconMd,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppDimens.d4),
                    Text(
                      service.location,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bg;

  const _Pill({
    required this.text,
    required this.textColor,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
