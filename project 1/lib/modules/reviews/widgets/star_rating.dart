import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int count;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 14,
    this.count = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        if (index < rating.floor()) {
          return SvgPicture.asset(
            'assets/icons/s1.svg', 
            width: size, 
            height: size,
          );
        } else if (index == rating.floor() && rating % 1 != 0) {
          // You can apply a clip rect or use half icon for half star
          return Icon(Icons.star_half, color: AppColors.starFilled, size: size);
        } else {
          return Icon(Icons.star_outline, color: AppColors.starEmpty, size: size);
        }
      }),
    );
  }
}
