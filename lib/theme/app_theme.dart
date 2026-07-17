import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Creamish + wine palette. Headings use a warm serif (Lora) for a bit of
/// personality; body text uses a clean sans (Inter) close to what Notion
/// itself uses, so the app reads "Notion-like" without being a literal copy.
///
/// Note: google_fonts fetches font files from Google's CDN on first use if
/// they aren't bundled as assets. That means the very first launch needs
/// internet to render the custom fonts correctly; it falls back to the
/// system font gracefully if offline, so this never breaks the app, just
/// looks slightly different until it can fetch once.
class AppColors {
  static const background = Color(0xFFFBF3E7); // warm cream
  static const surface = Color(0xFFF3E8D7); // slightly deeper cream, cards
  static const primary = Color(0xFF6D2E46); // wine
  static const primaryLight = Color(0xFF8C4560); // lighter wine, hover/accents
  static const secondary = Color(0xFFC9A66B); // muted gold, highlights
  static const textPrimary = Color(0xFF2E2420); // near-black warm brown
  static const textSecondary = Color(0xFF6B5E56);
  static const danger = Color(0xFFA43C3C);
  static const success = Color(0xFF3F6B4A);
}

class AppTheme {
  static ThemeData get themeData {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
    );

    final headingFont = GoogleFonts.loraTextTheme();
    final bodyFont = GoogleFonts.interTextTheme();

    return base.copyWith(
      textTheme: bodyFont.copyWith(
        titleLarge: headingFont.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: headingFont.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: bodyFont.bodyLarge?.copyWith(color: AppColors.textPrimary),
        bodyMedium:
            bodyFont.bodyMedium?.copyWith(color: AppColors.textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        titleTextStyle: headingFont.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.surface),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
