import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../viewmodels/service_provider_view_model.dart';
import '../widgets/provider_hero_card.dart';
import '../widgets/provider_info_section.dart';
import '../widgets/ratings_reviews_card.dart';
import '../widgets/service_listing_card.dart';

class ServiceProviderPage extends StatelessWidget {
  const ServiceProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ServiceProviderViewModel(),
      child: const _ServiceProviderView(),
    );
  }
}

class _ServiceProviderView extends StatelessWidget {
  const _ServiceProviderView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _TopMergedSection(),
            _BodyDivider(),
            _InfoSection(),
            _BodyDivider(),
            _AboutSection(),
            _BodyDivider(),
            _LanguagesSection(),
            _BodyDivider(),
            _CertificationsSection(),
            _BodyDivider(),
            _RatingsSection(),
            _BodyDivider(),
            _ListedServicesSection(),
            SizedBox(height: AppDimens.d80),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomActions(),
    );
  }
}

class _TopMergedSection extends StatelessWidget {
  const _TopMergedSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceGrey,
      child: const Column(
        children: [
          _AppBar(),
          _HeroSection(),
          SizedBox(height: AppDimens.d48),
          _ProviderHeader(),
          SizedBox(height: AppDimens.d12),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.d16,
          vertical: AppDimens.d12,
        ),
        child: Row(
          children: [
            _CircleIconButton(
              onTap: vm.onBack,
              asset: AppAssets.icBack,
              fallback: Icons.arrow_back_ios_new,
            ),
            const SizedBox(width: AppDimens.d12),
            Expanded(
              child: Text(
                'Service Provider',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _PlainIconButton(
              onTap: vm.onFavourite,
              icon: Icons.favorite_border,
            ),
            const SizedBox(width: AppDimens.d12),
            _PlainIconButton(
              onTap: vm.onNotification,
              icon: Icons.notifications_none_rounded,
              showDot: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlainIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool showDot;

  const _PlainIconButton({
    required this.onTap,
    required this.icon,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppDimens.iconLg,
        height: AppDimens.iconLg,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                icon,
                size: AppDimens.iconLg - AppDimens.d8,
                color: AppColors.textPrimary,
              ),
            ),
            if (showDot)
              const Positioned(
                top: AppDimens.d4,
                right: AppDimens.d4,
                child: _NotificationDot(),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationDot extends StatelessWidget {
  const _NotificationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.d8,
      height: AppDimens.d8,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  final IconData fallback;

  const _CircleIconButton({
    required this.onTap,
    required this.asset,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimens.appBarIconSize + AppDimens.d4,
        height: AppDimens.appBarIconSize + AppDimens.d4,
        decoration: BoxDecoration(
          color: AppColors.appBarIconBg,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: AppDimens.iconMd - AppDimens.d4,
            height: AppDimens.iconMd - AppDimens.d4,
            colorFilter: const ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
            placeholderBuilder: (_) => Icon(
              fallback,
              size: AppDimens.iconMd - AppDimens.d4,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return const ProviderHeroCard();
  }
}

class _ProviderHeader extends StatelessWidget {
  const _ProviderHeader();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: Column(
        children: [
          Text(
            vm.provider.name,
            style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.d4),
          Text(
            vm.provider.specialty,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.d8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                vm.provider.rating.toString(),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppDimens.d4),
              ...List.generate(
                4,
                (_) => const Icon(
                  Icons.star,
                  color: AppColors.starYellow,
                  size: AppDimens.iconSm,
                ),
              ),
              const Icon(
                Icons.star_half,
                color: AppColors.starYellow,
                size: AppDimens.iconSm,
              ),
              const SizedBox(width: AppDimens.d4),
              Text(
                '(${vm.provider.reviewCount})',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyDivider extends StatelessWidget {
  const _BodyDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.ratingCardHeader,
      height: AppDimens.d32,
      thickness: 0.5,
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: ProviderInfoSection(
        location: vm.provider.location,
        yearsExperience: vm.provider.yearsExperience,
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Provider',
            style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.d8),
          Text(
            vm.provider.aboutText,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _LanguagesSection extends StatelessWidget {
  const _LanguagesSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Languages Spoken',
            style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.d12),
          ...vm.provider.languages.map(
            (lang) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.d8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.d4),
                    child: Image.asset(
                      lang.flagAsset,
                      width: AppDimens.d24,
                      height: AppDimens.d16,
                      fit: BoxFit.cover,
                      errorBuilder: (_, error, stackTrace) => const Icon(
                        Icons.flag,
                        size: AppDimens.iconMd,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimens.d8),
                  Text(
                    lang.name,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.d8),
          Text(
            'Dr. Rahman communicates effortlessly in both English and Arabic, ensuring a comfortable and welcoming environment for all her clients.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificationsSection extends StatelessWidget {
  const _CertificationsSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Certifications',
            style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.d12),
          ...vm.provider.certifications.map(
            (cert) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.d8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: AppDimens.iconMd,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppDimens.d8),
                  Expanded(
                    child: Text(
                      cert,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.d8),
          Text(
            "These credentials reflect Dr. Rahman's commitment to ongoing education and the highest standards of care, ensuring the best outcomes for her clients.",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingsSection extends StatelessWidget {
  const _RatingsSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
      child: RatingsReviewsCard(
        breakdown: vm.provider.ratingBreakdown,
        review: vm.provider.reviews.isNotEmpty ? vm.provider.reviews.first : null,
      ),
    );
  }
}

class _ListedServicesSection extends StatelessWidget {
  const _ListedServicesSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Listed Services',
                style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
              ),
              GestureDetector(
                onTap: vm.onSeeAllServices,
                child: Text(
                  'See all',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.d12),
        SizedBox(
          height: 360,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: AppDimens.d16),
            itemCount: vm.provider.listedServices.length,
            itemBuilder: (_, i) =>
                ServiceListingCard(service: vm.provider.listedServices[i]),
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ServiceProviderViewModel>();
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimens.d16,
        AppDimens.d12,
        AppDimens.d16,
        AppDimens.d24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: vm.onChat,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.borderDark, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppDimens.d16),
              ),
              child: Text(
                "Let's Chat",
                style: AppTextStyles.button.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: AppDimens.d12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.bookNowStart, AppColors.bookNowEnd],
                ),
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              ),
              child: ElevatedButton(
                onPressed: vm.onBookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.d16),
                ),
                child: Text(
                  'Book Now',
                  style: AppTextStyles.button.copyWith(color: AppColors.textWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
