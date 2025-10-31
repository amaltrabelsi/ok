import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Display Styles - Large Headlines
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1.2,
    height: 1.1,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.8,
    height: 1.2,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.6,
    height: 1.3,
  );
  
  // Headline Styles - Section Titles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
    height: 1.3,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.4,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
    height: 1.4,
  );
  
  // Title Styles - Card Headers & Subheadings
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.0,
    height: 1.4,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.5,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.5,
  );
  
  // Body Styles - Main Content
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
    height: 1.6,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.3,
    height: 1.5,
  );
  
  // Label Styles - Buttons & UI Elements
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
    letterSpacing: 0.2,
    height: 1.4,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
    letterSpacing: 0.3,
    height: 1.4,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
    letterSpacing: 0.4,
    height: 1.3,
  );
  
  // Utility Styles
  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.3,
    height: 1.4,
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textDisabled,
    letterSpacing: 0.8,
    height: 1.2,
  );
  
  // Specialized Styles for Flight Booking App
  static TextStyle get heroTitle => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    letterSpacing: -1.5,
    height: 1.0,
  );
  
  static TextStyle get sectionTitle => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );
  
  static TextStyle get cardTitle => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
    height: 1.3,
  );
  
  static TextStyle get priceLarge => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: -0.5,
    height: 1.2,
  );
  
  static TextStyle get priceMedium => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: -0.3,
    height: 1.3,
  );
  
  static TextStyle get priceSmall => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    letterSpacing: -0.1,
    height: 1.4,
  );
  
  static TextStyle get timeDisplay => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.2,
  );
  
  static TextStyle get airportCode => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
    height: 1.3,
  );
  
  static TextStyle get airportName => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.2,
    height: 1.4,
  );
  
  static TextStyle get badgeText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textInverse,
    letterSpacing: 0.8,
    height: 1.0,
  );
  
  static TextStyle get buttonText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
    letterSpacing: 0.2,
    height: 1.2,
  );
  
  static TextStyle get inputLabel => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
    height: 1.4,
  );
  
  static TextStyle get inputText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
    height: 1.5,
  );
  
  static TextStyle get glassText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textInverse,
    letterSpacing: 0.2,
    height: 1.4,
  );
  
  static TextStyle get gradientText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    foreground: Paint()
      ..shader = AppColors.primaryGradient.createShader(
        const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
      ),
    letterSpacing: -0.1,
    height: 1.3,
  );
  
  static TextStyle get promoText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.accentGreen,
    letterSpacing: 0.5,
    height: 1.2,
  );
  
  static TextStyle get errorText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
    letterSpacing: 0.2,
    height: 1.4,
  );
  
  static TextStyle get successText => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
    letterSpacing: 0.2,
    height: 1.4,
  );
}