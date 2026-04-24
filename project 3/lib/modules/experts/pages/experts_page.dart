import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimens.dart';
import '../widgets/expert_card.dart';
import '../widgets/filters_bottom_sheet.dart';

class ExpertsPage extends StatelessWidget {
  const ExpertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: const FiltersSideSheet(),
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(AppDimens.d8),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDarkGrey, size: AppDimens.iconSm),
          ),
        ),
        title: Text(
          'Meet our Experts',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/Heart.svg', width: AppDimens.iconMd),
            onPressed: () {},
          ),
          IconButton(
            // Try to use vuesax.svg if it's the bell, otherwise fallback to material icon
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textPrimary, size: AppDimens.d30),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.textDarkGrey.withOpacity(0.05),
              blurRadius: AppDimens.d16,
              offset: const Offset(0, -AppDimens.d4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: AppDimens.d64,
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/exchange 1.svg', width: AppDimens.d20, colorFilter: const ColorFilter.mode(AppColors.textDarkGrey, BlendMode.srcIn)),
                    label: Text('Sort By', style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.textPrimary)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimens.d12),
                  child: VerticalDivider(width: 1, color: AppColors.border),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: SvgPicture.asset('assets/icons/setting-4.svg', width: AppDimens.d20, colorFilter: const ColorFilter.mode(AppColors.textDarkGrey, BlendMode.srcIn)),
                    label: Text('Filter', style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.textPrimary)),
                  ),
                ),
              ],
                );
              }
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.4, 1.0],
            colors: [
              AppColors.bgGradientStart,
              AppColors.bgGradientMiddle,
              AppColors.bgGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16, vertical: AppDimens.d8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withOpacity(0.05),
                        blurRadius: AppDimens.d16,
                        offset: const Offset(0, AppDimens.d4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'What are you looking for?',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textGrey),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(AppDimens.d16),
                        child: SvgPicture.asset('assets/icons/search.svg', width: AppDimens.iconMd),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.d20, vertical: AppDimens.d16),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppDimens.d16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppDimens.d12,
                    mainAxisSpacing: AppDimens.d12,
                    mainAxisExtent: AppDimens.expertCardHeight,
                  ),
                  itemCount: 6, // Show 6 cards
                  itemBuilder: (context, index) {
                    return const ExpertCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
