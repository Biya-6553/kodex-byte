import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';

class ProviderInfoSection extends StatelessWidget {
  final String location;
  final int yearsExperience;

  const ProviderInfoSection({
    super.key,
    required this.location,
    required this.yearsExperience,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Provider Information',
          style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppDimens.d12),
        Row(
          children: [
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
            const SizedBox(width: AppDimens.d8),
            Text(
              location,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.d8),
        Row(
          children: [
            Image.asset(
              AppAssets.icTwentyFourHour,
              width: AppDimens.iconMd,
              height: AppDimens.iconMd,
              errorBuilder: (_, error, stackTrace) => const Icon(
                Icons.home_outlined,
                size: AppDimens.iconMd,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppDimens.d8),
            const _VisitChip(
              label: 'Home visit',
              bg: AppColors.chipHomeVisitBg,
              textColor: AppColors.chipHomeVisitText,
              icon: Icons.home_outlined,
              iconPngAsset: AppAssets.icHome,
            ),
            const SizedBox(width: AppDimens.d8),
            const _VisitChip(
              label: 'At Provider',
              bg: AppColors.chipProviderBg,
              textColor: AppColors.chipProviderText,
              icon: Icons.place_outlined,
              iconAsset: AppAssets.icLocation,
            ),
          ],
        ),
        const SizedBox(height: AppDimens.d8),
        Row(
          children: [
            SvgPicture.asset(
              AppAssets.icExperience,
              width: AppDimens.iconMd,
              height: AppDimens.iconMd,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (_) => const Icon(
                Icons.workspace_premium_outlined,
                size: AppDimens.iconMd,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppDimens.d8),
            Text(
              '$yearsExperience+ Years of Experience',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

class _VisitChip extends StatelessWidget {
  final String label;
  final Color bg;
  final Color textColor;
  final IconData icon;
  final String? iconAsset;
  final String? iconPngAsset;

  const _VisitChip({
    required this.label,
    required this.bg,
    required this.textColor,
    required this.icon,
    this.iconAsset,
    this.iconPngAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.d8,
        vertical: AppDimens.d4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPngAsset != null)
            Image.asset(
              iconPngAsset!,
              width: AppDimens.iconSm,
              height: AppDimens.iconSm,
              errorBuilder: (_, error, stackTrace) => Icon(
                icon,
                size: AppDimens.iconSm,
                color: textColor,
              ),
            )
          else if (iconAsset != null)
            SvgPicture.asset(
              iconAsset!,
              width: AppDimens.iconSm,
              height: AppDimens.iconSm,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              placeholderBuilder: (_) => Icon(
                icon,
                size: AppDimens.iconSm,
                color: textColor,
              ),
            )
          else
            Icon(icon, size: AppDimens.iconSm, color: textColor),
          const SizedBox(width: AppDimens.d4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
