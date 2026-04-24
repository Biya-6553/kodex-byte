import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_assets.dart';
import '../viewmodels/rating_review_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/rating_bar_row.dart';
import '../widgets/review_card.dart';
import '../widgets/write_review_bottom_sheet.dart';

class RatingReviewPage extends StatefulWidget {
  const RatingReviewPage({super.key});

  @override
  State<RatingReviewPage> createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RatingReviewViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RatingReviewViewModel>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.ratingBar))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fake Status Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.d16,
                        vertical: AppDimens.d8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '9:41',
                            style: AppTextStyles.statusTime,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.icSignal, width: AppDimens.statusIconSignal),
                              const SizedBox(width: AppDimens.d4),
                              SvgPicture.asset(AppAssets.icWifi, width: AppDimens.statusIconWifi),
                              const SizedBox(width: AppDimens.d4),
                              SvgPicture.asset(AppAssets.icBattery, width: AppDimens.statusIconBattery),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Back Button
                    IconButton(
                      padding: const EdgeInsets.only(left: AppDimens.d8),
                      icon: const Icon(Icons.arrow_back_ios_new, size: AppDimens.iconLg),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppDimens.d8),
                          const Text('Rating&Reviews', style: AppTextStyles.heading1),
                          const SizedBox(height: AppDimens.d32),
                  
                  // Rating Summary
                  if (vm.ratingSummary != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vm.ratingSummary!.averageRating.toStringAsFixed(1),
                              style: AppTextStyles.averageRating,
                            ),
                            Text(
                              '${vm.ratingSummary!.totalRatings} ratings',
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(width: AppDimens.d24),
                        // Right side (Progress bars)
                        Expanded(
                          child: Column(
                            children: List.generate(5, (index) {
                              final star = 5 - index;
                              final count = vm.ratingSummary!.breakdown[star - 1];
                              final total = vm.ratingSummary!.totalRatings;
                              final ratio = total == 0 ? 0.0 : count / total;
                              
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
                  
                  const SizedBox(height: AppDimens.d40),
                  
                  // Reviews Header
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
                            onChanged: (_) => context.read<RatingReviewViewModel>().toggleWithPhoto(),
                          ),
                          const Text('With photo', style: AppTextStyles.bodyMedium),
                        ],
                      )
                    ],
                  ),
                  
                  const SizedBox(height: AppDimens.d24),
                  
                  // Reviews List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.filteredReviews.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppDimens.d24),
                    itemBuilder: (context, index) {
                      return ReviewCard(review: vm.filteredReviews[index]);
                    },
                  ),
                  
                  const SizedBox(height: AppDimens.d120), // Bottom padding for fab
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => WriteReviewBottomSheet(
              onSubmit: (name, rating, text) {
                context.read<RatingReviewViewModel>().submitReview(
                  authorName: name,
                  rating: rating,
                  body: text,
                );
              },
            ),
          );
        },
        backgroundColor: AppColors.fabColor,
        icon: const Icon(Icons.edit, size: AppDimens.iconLg),
        label: const Text('Write a review', style: AppTextStyles.button),
      ),
    );
  }
}
