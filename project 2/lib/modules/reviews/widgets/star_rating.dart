import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int count;
  final bool interactive;
  final ValueChanged<double>? onChanged;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 14,
    this.count = 5,
    this.interactive = false,
    this.onChanged,
  });

  double _ratingFromOffset(double localX, double totalWidth) {
    final perStar = totalWidth / count;
    final raw = (localX / perStar).ceil();
    return raw.clamp(1, count).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    Widget stars = LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : (size * count);

        return GestureDetector(
          onTapDown: (d) {
            onChanged?.call(
              _ratingFromOffset(d.localPosition.dx, totalWidth),
            );
          },
          onHorizontalDragUpdate: (d) {
            onChanged?.call(
              _ratingFromOffset(d.localPosition.dx, totalWidth),
            );
          },
          child: FittedBox(
            fit: BoxFit.scaleDown, // ✅ prevents overflow always
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(count, (index) {
                final filled = index < rating.floor();
                final half =
                    !filled && index == rating.floor() && rating % 1 != 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Icon(
                    filled
                        ? Icons.star_rounded
                        : half
                            ? Icons.star_half_rounded
                            : Icons.star_outline_rounded,
                    color: (filled || half)
                        ? AppColors.starFilled
                        : AppColors.starEmpty,
                    size: size,
                  ),
                );
              }),
            ),
          ),
        );
      },
    );

    return stars;
  }
}
