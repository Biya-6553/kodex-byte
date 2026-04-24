import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'typography.dart';

ThemeData buildAppTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, primary: AppColors.primary),
  scaffoldBackgroundColor: AppColors.background,
  textTheme: buildTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.surface,
  ),
);
