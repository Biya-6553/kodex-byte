import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';

TextTheme buildTextTheme() {
  return const TextTheme(
    displayLarge: AppTextStyles.heading1,
    displayMedium: AppTextStyles.heading2,
    displaySmall: AppTextStyles.heading3,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.button,
    labelMedium: AppTextStyles.label,
    labelSmall: AppTextStyles.caption,
  );
}
