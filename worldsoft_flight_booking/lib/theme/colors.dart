import 'package:flutter/material.dart';

class AppColors {
  // Modern Aviation-Inspired Primary Colors
  static const Color primary = Color(0xFF1E40AF); // Deep aviation blue
  static const Color primaryLight = Color(0xFF3B82F6); // Bright sky blue
  static const Color primaryDark = Color(0xFF1E3A8A); // Dark navy
  static const Color primaryAccent = Color(0xFF60A5FA); // Light sky accent
  
  // Sophisticated Accent Colors - Aviation & Travel Theme
  static const Color accentBlue = Color(0xFF06B6D4); // Cyan blue (sky)
  static const Color accentOrange = Color(0xFFF59E0B); // Sunset orange
  static const Color accentGreen = Color(0xFF10B981); // Success green
  static const Color accentPurple = Color(0xFF8B5CF6); // Royal purple
  static const Color accentRed = Color(0xFFEF4444); // Alert red
  static const Color accentTeal = Color(0xFF14B8A6); // Ocean teal
  
  // Modern Neutral Palette - Clean & Professional
  static const Color background = Color(0xFFF8FAFC); // Soft white
  static const Color backgroundSecondary = Color(0xFFF1F5F9); // Light gray
  static const Color surface = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceLight = Color(0xFFF8FAFC); // Very light gray
  static const Color surfaceDark = Color(0xFFE2E8F0); // Medium gray
  static const Color surfaceElevated = Color(0xFFFFFFFF); // Elevated surface
  
  // Status Colors - Modern & Accessible
  static const Color success = Color(0xFF10B981); // Emerald green
  static const Color successLight = Color(0xFFD1FAE5); // Light emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color warningLight = Color(0xFFFEF3C7); // Light amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorLight = Color(0xFFFEE2E2); // Light red
  static const Color info = Color(0xFF06B6D4); // Cyan
  static const Color infoLight = Color(0xFFCFFAFE); // Light cyan
  
  // Text Colors - High Contrast & Readable
  static const Color textPrimary = Color(0xFF0F172A); // Almost black
  static const Color textSecondary = Color(0xFF64748B); // Medium gray
  static const Color textTertiary = Color(0xFF94A3B8); // Light gray
  static const Color textDisabled = Color(0xFFCBD5E1); // Very light gray
  static const Color textInverse = Color(0xFFFFFFFF); // White text
  
  // Special Surface Colors
  static const Color onPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color onSecondary = Color(0xFF0F172A); // Dark on secondary
  static const Color glass = Color(0x1AFFFFFF); // Glass effect
  static const Color glassBorder = Color(0x33FFFFFF); // Glass border
  static const Color divider = Color(0xFFE2E8F0); // Subtle divider
  static const Color border = Color(0xFFE2E8F0); // Default border
  static const Color borderFocus = Color(0xFF3B82F6); // Focus border
  
  // Modern Gradient Collection - Aviation & Travel Inspired
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6), Color(0xFF60A5FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  static const Gradient skyGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF0891B2), Color(0xFF0E7490)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const Gradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient oceanGradient = LinearGradient(
    colors: [Color(0xFF14B8A6), Color(0xFF0D9488), Color(0xFF0F766E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const Gradient glassGradient = LinearGradient(
    colors: [
      Color(0x1AFFFFFF),
      Color(0x0DFFFFFF),
      Color(0x1AFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Card & Surface Gradients
  static const Gradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient elevatedGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF1F5F9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Special Effect Colors
  static const Color shimmer = Color(0xFFE2E8F0);
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
}