import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import 'star_rating.dart';

/// Bottom sheet for submitting a new review.
///
/// Architecture notes (skill.md):
///   • No business logic here — pure UI widget.
///   • Calls [onSubmit] callback; ViewModel/Repository handle persistence.
///   • Uses design tokens only (AppColors, AppDimens, AppTextStyles).
class WriteReviewBottomSheet extends StatefulWidget {
  /// Called when the user taps "SEND REVIEW".
  /// Arguments: authorName, rating (1–5), reviewText, optional photoPath.
  final void Function(String name, double rating, String text, String? photoPath) onSubmit;

  const WriteReviewBottomSheet({super.key, required this.onSubmit});

  @override
  State<WriteReviewBottomSheet> createState() => _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState extends State<WriteReviewBottomSheet> {
  final TextEditingController _textController = TextEditingController();
  double _rating = 0;
  XFile? _pickedImage;
  bool _submitting = false;

  // Opens gallery via image_picker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  void _removeImage() => setState(() => _pickedImage = null);

  Future<void> _handleSubmit() async {
    if (_rating == 0 || _submitting) return;
    setState(() => _submitting = true);
    widget.onSubmit(
      'You',
      _rating,
      _textController.text.trim(),
      _pickedImage?.path,
    );
    // Pop is handled by the page after success
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: AppDimens.d24,
        right: AppDimens.d24,
        top: AppDimens.d12,
        bottom: bottomPad + AppDimens.d32,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.radiusLg),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Handle bar ──────────────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.d20),

            // ── Title ───────────────────────────────────────────────────────
            const Text('What is your rate?', style: AppTextStyles.heading2),
            const SizedBox(height: AppDimens.d16),

            // ── Interactive star rating (tap + slide) ────────────────────────
            SizedBox(
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  width: AppDimens.iconLg * 5 + 4.0 * 4,
                  child: StarRating(
                    rating: _rating,
                    size: AppDimens.iconLg,
                    count: 5,
                    interactive: true,
                    onChanged: (v) => setState(() => _rating = v),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.d20),

            // ── Subtitle ────────────────────────────────────────────────────
            const Text(
              'Please share your opinion\nabout the product',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: AppDimens.d16),

            // ── Review text field (real-time) ────────────────────────────────
            TextField(
              controller: _textController,
              maxLines: 5,
              onChanged: (_) => setState(() {}), // triggers rebuild for char count
              decoration: InputDecoration(
                hintText: 'Your review',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  borderSide: const BorderSide(color: AppColors.ratingBar, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(AppDimens.d12),
              ),
            ),
            const SizedBox(height: AppDimens.d20),

            // ── Photo row ────────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Camera FAB
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.fabColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.surface,
                      size: AppDimens.iconMd,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.d12),

                // Label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add your photos',
                        style: AppTextStyles.label,
                      ),
                      Text(
                        'Tap to open gallery',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Picked image thumbnail
                if (_pickedImage != null) ...[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                        child: Image.file(
                          File(_pickedImage!.path),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: -6,
                        right: -6,
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: AppColors.textPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 11,
                              color: AppColors.surface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppDimens.d24),

            // ── Send button ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rating > 0 && !_submitting ? _handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fabColor,
                  disabledBackgroundColor: AppColors.disabled,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.d16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  elevation: 0,
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.surface,
                        ),
                      )
                    : const Text('SEND REVIEW', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
