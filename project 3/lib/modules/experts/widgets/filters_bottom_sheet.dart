import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimens.dart';

class FiltersSideSheet extends StatelessWidget {
  const FiltersSideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      width: MediaQuery.of(context).size.width * 0.85,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(AppDimens.radiusLg)),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16, vertical: AppDimens.d24),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.border.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: AppDimens.iconSm, color: AppColors.textDarkGrey),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Filters',
                          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.d48), // Balance the back button
                  ],
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.d24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimens.d8),
                      // Section - Booking Type
                      Text('Booking Type', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: AppDimens.d16),
                      Row(
                        children: [
                          Expanded(child: _buildBookingTypeToggle('Home Visit', true, true)),
                          const SizedBox(width: AppDimens.d12),
                          Expanded(child: _buildBookingTypeToggle('At Provider', false, true)), // Assuming both are active in UI or just styled based on image
                        ],
                      ),
                      const SizedBox(height: AppDimens.d32),
                      
                      // Section - Language
                      Text('Language', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: AppDimens.d16),
                      DropdownButtonFormField<String>(
                        value: 'English',
                        decoration: InputDecoration(
                          hintText: 'Select Language',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
                        ),
                        icon: SvgPicture.asset('assets/icons/expand_more.svg', colorFilter: const ColorFilter.mode(AppColors.textDarkGrey, BlendMode.srcIn)),
                        items: [
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: AppDimens.d32),
                      
                      // Section - Location
                      Text('Location', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: AppDimens.d16),
                      TextField(
                        controller: TextEditingController(text: 'Al Rawdah - W54 - Abu Dhabi...'),
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Location',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textGrey),
                          prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hotPink),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            borderSide: const BorderSide(color: AppColors.hotPink),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            borderSide: const BorderSide(color: AppColors.hotPink),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            borderSide: const BorderSide(color: AppColors.hotPink, width: AppDimens.d2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.d16),
                        ),
                      ),
                      const SizedBox(height: AppDimens.d24),
                      Row(
                        children: [
                          // Custom near me icon or fallback to target icon
                          Container(
                            padding: const EdgeInsets.all(AppDimens.d4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textDarkGrey),
                              borderRadius: BorderRadius.circular(AppDimens.d4),
                            ),
                            child: const Icon(Icons.near_me_outlined, size: AppDimens.d14, color: AppColors.textDarkGrey),
                          ),
                          const SizedBox(width: AppDimens.d12),
                          Text('Near Me', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
                          const Spacer(),
                          CupertinoSwitch(
                            value: true,
                            activeColor: AppColors.hotPink,
                            onChanged: (v) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.d32),
                      
                      // Section - Rating
                      Text('Rating', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: AppDimens.d16),
                      Wrap(
                        spacing: AppDimens.d12,
                        runSpacing: AppDimens.d12,
                        children: [
                          _buildRatingChip('5', true),
                          _buildRatingChip('4', false),
                          _buildRatingChip('3', false),
                          _buildRatingChip('2', false),
                          _buildRatingChip('1', false),
                        ],
                      ),
                      const SizedBox(height: AppDimens.d32),
                      
                      // Reset Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Reset',
                            style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.hotPink),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.d32),
                    ],
                  ),
                ),
              ),
              
              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(AppDimens.d24),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.hotPink,
                    foregroundColor: AppColors.surface,
                    minimumSize: const Size(double.infinity, AppDimens.d56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Apply filters',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.surface),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingTypeToggle(String text, bool isHomeVisit, bool isSelected) {
    Color color = isHomeVisit ? AppColors.homeVisit : AppColors.atProvider;
    Color bgColor = isHomeVisit ? AppColors.homeVisitBg : AppColors.atProviderBg;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.d12),
      decoration: BoxDecoration(
        color: isSelected ? bgColor : AppColors.surface,
        border: Border.all(color: isSelected ? color.withOpacity(0.5) : AppColors.border),
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isHomeVisit ? Icons.location_on_outlined : Icons.location_on_outlined, color: isSelected ? color : AppColors.textGrey, size: AppDimens.iconSm),
          const SizedBox(width: AppDimens.d8),
          Text(text, style: AppTextStyles.label.copyWith(color: isSelected ? color : AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _buildRatingChip(String rating, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.d16, vertical: AppDimens.d8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: isSelected ? AppColors.hotPink : AppColors.border),
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(rating, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
          const SizedBox(width: AppDimens.d4),
          SvgPicture.asset('assets/icons/Star 1.svg', width: AppDimens.d14),
        ],
      ),
    );
  }
}
