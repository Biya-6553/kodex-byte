import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../viewmodels/rating_review_viewmodel.dart';
import '../widgets/rating_bar_row.dart';
import '../widgets/review_card.dart';
import '../widgets/write_review_bottom_sheet.dart';

class RatingReviewPage extends StatefulWidget {
  const RatingReviewPage({super.key});

  @override
  State<RatingReviewPage> createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  int _selectedNavIndex = 3; // Reviews tab active by default

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RatingReviewViewModel>().init();
    });
  }

  // ── Open write-review sheet and handle result ─────────────────────────────
  void _openWriteReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WriteReviewBottomSheet(
        onSubmit: (name, rating, text, photoPath) async {
          // Pop sheet first for snappy UX
          if (mounted) Navigator.pop(context);

          final ok = await context.read<RatingReviewViewModel>().submitReview(
                authorName: name,
                rating: rating,
                body: text,
                photoPath: photoPath,
              );

          if (ok && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.surface),
                    SizedBox(width: AppDimens.d8),
                    Text(
                      'Review added successfully!',
                      style: AppTextStyles.label,
                    ),
                  ],
                ),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                margin: const EdgeInsets.fromLTRB(
                  AppDimens.d16,
                  0,
                  AppDimens.d16,
                  AppDimens.d24,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      ),
    );
  }

  // ── Bottom nav items ──────────────────────────────────────────────────────
  static const _navItems = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.search_outlined, activeIcon: Icons.search_rounded, label: 'Search'),
    _NavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart_rounded, label: 'Cart'),
    _NavItem(icon: Icons.star_outline_rounded, activeIcon: Icons.star_rounded, label: 'Reviews'),
    _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RatingReviewViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      // ── Bottom Nav ─────────────────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (i) => setState(() => _selectedNavIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.ratingBar,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyles.caption,
        elevation: 8,
        items: _navItems
            .asMap()
            .entries
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.value.icon),
                activeIcon: Icon(e.value.activeIcon),
                label: e.value.label,
              ),
            )
            .toList(),
      ),
      body: SafeArea(
        child: vm.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.ratingBar),
              )
            : Column(
                children: [
                  // ── App Bar ──────────────────────────────────────────────
                  Container(
                    color: AppColors.surface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.d8,
                      vertical: AppDimens.d4,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: AppDimens.iconMd,
                          ),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Rating and reviews',
                              style: AppTextStyles.heading3,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimens.d48), // balance back button
                      ],
                    ),
                  ),

                  // ── Scrollable content ────────────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.d16,
                        vertical: AppDimens.d16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Reviews header + filter ───────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${vm.filteredReviews.length} reviews',
                                style: AppTextStyles.heading2,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: vm.withPhotoFilter,
                                    activeColor: AppColors.textPrimary,
                                    onChanged: (_) => context
                                        .read<RatingReviewViewModel>()
                                        .toggleWithPhoto(),
                                  ),
                                  const Text(
                                    'With photo',
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimens.d16),

                          // ── Rating Summary card ───────────────────────────
                          if (vm.ratingSummary != null)
                            Container(
                              padding: const EdgeInsets.all(AppDimens.d16),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.radiusLg),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.cardShadow,
                                    blurRadius: AppDimens.cardShadowBlur,
                                    offset: const Offset(
                                        0, AppDimens.cardShadowOffset),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Average
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vm.ratingSummary!.averageRating
                                                .toStringAsFixed(1),
                                            style:
                                                AppTextStyles.averageRating,
                                          ),
                                          Text(
                                            '${vm.ratingSummary!.totalRatings} ratings',
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: AppDimens.d24),
                                      // Bar breakdown
                                      Expanded(
                                        child: Column(
                                          children:
                                              List.generate(5, (index) {
                                            final star = 5 - index;
                                            final count = vm.ratingSummary!
                                                .breakdown[star - 1];
                                            final total = vm
                                                .ratingSummary!.totalRatings;
                                            final ratio = total == 0
                                                ? 0.0
                                                : count / total;
                                            return RatingBarRow(
                                              starCount: star,
                                              ratio: ratio,
                                              count: count,
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppDimens.d16),
                                  // Write a Review button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _openWriteReview,
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        size: AppDimens.iconSm,
                                      ),
                                      label: const Text(
                                        'Write a Review',
                                        style: AppTextStyles.button,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.fabColor,
                                        foregroundColor: AppColors.surface,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: AppDimens.d12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  AppDimens.radiusFull),
                                        ),
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: AppDimens.d24),

                          // ── Review list ───────────────────────────────────
                          if (vm.filteredReviews.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppDimens.d40),
                                child: Text(
                                  'No reviews with photos yet.',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary),
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: vm.filteredReviews.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: AppDimens.d24),
                              itemBuilder: (_, i) =>
                                  ReviewCard(review: vm.filteredReviews[i]),
                            ),

                          const SizedBox(height: AppDimens.d32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ── Simple data class for nav items ──────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
