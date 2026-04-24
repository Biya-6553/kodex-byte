import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimens.dart';

class ExpertCard extends StatelessWidget {
  const ExpertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: AppDimens.d24,
            spreadRadius: 0,
            offset: const Offset(0, AppDimens.d8),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cardBorderGradientStart,
            AppColors.cardBorderGradientEnd,
            AppColors.cardBorderGradientBottom,
          ],
          stops: [0.0, 0.3, 1.0],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg - 1.5),
        ),
        padding: const EdgeInsets.all(AppDimens.d12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top: CircleAvatar with Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: AppDimens.d40,
                  backgroundColor: AppColors.border,
                  backgroundImage: AssetImage('assets/images/Group 2085664557.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.d2),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppColors.secondary,
                      size: AppDimens.d20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.d12),
            
            // Chip: "Top Rated"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.d12, vertical: AppDimens.d4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              ),
              child: Text(
                'Top Rated',
                style: AppTextStyles.captionBold.copyWith(color: AppColors.primaryText),
              ),
            ),
            const SizedBox(height: AppDimens.d12),
            
            // Provider name
            Text(
              'Dr. Aisha Rahman',
              style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimens.d4),
            
            // Specialty
            Text(
              'Prenatal Massage Specialist',
              style: AppTextStyles.caption.copyWith(color: AppColors.textGrey),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimens.d12),
            
            // Rating Row
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('4.9', style: AppTextStyles.labelBold.copyWith(color: AppColors.textDarkGrey)),
                const SizedBox(width: AppDimens.d4),
                SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d2),
                SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d2),
                SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d2),
                SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d2),
                SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d4),
                Text('(1.6k)', style: AppTextStyles.caption.copyWith(color: AppColors.textGrey)),
              ],
              ),
            ),
            const SizedBox(height: AppDimens.d8),
            
            // Tags Row
            Wrap(
              spacing: AppDimens.d8,
              runSpacing: AppDimens.d8,
              alignment: WrapAlignment.center,
              children: [
                _buildTag('Prenatal'),
                _buildTag('Postpartum'),
              ],
            ),
            
            const Spacer(),
            
            // Service type row
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(AppColors.homeVisit),
                const SizedBox(width: AppDimens.d4),
                Text('Home visit', style: AppTextStyles.captionBold.copyWith(color: AppColors.homeVisit)),
                const SizedBox(width: AppDimens.d8),
                _buildDot(AppColors.atProvider),
                const SizedBox(width: AppDimens.d4),
                Text('At Provider', style: AppTextStyles.captionBold.copyWith(color: AppColors.atProvider)),
              ],
              ),
            ),
            const SizedBox(height: AppDimens.d4),
            
            // Location row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.textDarkGrey, size: AppDimens.iconSm),
                const SizedBox(width: AppDimens.d4),
                Text('Dubai', style: AppTextStyles.label.copyWith(color: AppColors.textDarkGrey)),
              ],
            ),
            const SizedBox(height: AppDimens.d4),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d12, vertical: AppDimens.d4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(color: AppColors.textGrey),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: AppDimens.d6,
      height: AppDimens.d6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
