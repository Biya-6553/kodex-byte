import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WriteReviewBottomSheet extends StatefulWidget {
  final Function(String, double, String) onSubmit;

  const WriteReviewBottomSheet({super.key, required this.onSubmit});

  @override
  State<WriteReviewBottomSheet> createState() => _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState extends State<WriteReviewBottomSheet> {
  final _textController = TextEditingController();
  double _rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimens.d24,
        right: AppDimens.d24,
        top: AppDimens.d24,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppDimens.d24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.radiusLg)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('What is your rate?', style: AppTextStyles.heading2),
          const SizedBox(height: AppDimens.d16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: index < _rating
                    ? SvgPicture.asset(
                        'assets/icons/s1.svg', 
                        width: AppDimens.iconLg, 
                        height: AppDimens.iconLg,
                      )
                    : const Icon(
                        Icons.star_border,
                        color: AppColors.starEmpty,
                        size: AppDimens.iconLg,
                      ),
                onPressed: () {
                  setState(() => _rating = index + 1.0);
                },
              );
            }),
          ),
          const SizedBox(height: AppDimens.d24),
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Share your opinion...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppDimens.d24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit('You', _rating, _textController.text);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fabColor,
                foregroundColor: AppColors.surface,
                padding: const EdgeInsets.symmetric(vertical: AppDimens.d16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
              ),
              child: const Text('SEND REVIEW', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
