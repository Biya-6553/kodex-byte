import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';

class ProviderHeroCard extends StatelessWidget {
  const ProviderHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: AppDimens.heroCardHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.heroGradientStart, AppColors.heroGradientEnd],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppDimens.radiusLg),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppDimens.radiusLg),
            ),
            child: Image.asset(
              AppAssets.heroBg,
              fit: BoxFit.cover,
              color: AppColors.heroGradientEnd.withValues(alpha: 0.30),
              colorBlendMode: BlendMode.overlay,
              errorBuilder: (_, error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
        ),
        Positioned(
          bottom: -(AppDimens.profileAvatarSize / 2),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width:
                    AppDimens.profileAvatarSize + AppDimens.profileAvatarBorder * 2,
                height:
                    AppDimens.profileAvatarSize + AppDimens.profileAvatarBorder * 2,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.woman,
                    width: AppDimens.profileAvatarSize,
                    height: AppDimens.profileAvatarSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stackTrace) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: AppDimens.d4,
                right: AppDimens.d4,
                child: _VerifiedBadge(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.badgeSize,
      height: AppDimens.badgeSize,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.verifiedGreen,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: AppColors.textWhite,
          size: AppDimens.iconSm,
        ),
      ),
    );
  }
}
