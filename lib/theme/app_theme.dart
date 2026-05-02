import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dark · Mystery · Vintage palette + typography.
///
/// Centralized so every screen pulls from the same look.
class AppTheme {
  // Palette
  static const Color ink         = Color(0xFF0E0B08); // near-black background
  static const Color smoke       = Color(0xFF1B1612); // panels
  static const Color parchment   = Color(0xFFE9DCC0); // aged paper text
  static const Color sepia       = Color(0xFFB89F76); // muted gold
  static const Color blood       = Color(0xFF7A1B1B); // deep crimson accent
  static const Color rust        = Color(0xFF5A3A2A); // worn leather
  static const Color shadow      = Color(0xFF000000);

  static ThemeData build() {
    final base = ThemeData.dark(useMaterial3: true);

    // Vintage typography: typewriter for body, engraved serif for headings.
    final textTheme = TextTheme(
      // Headings — Cinzel is a chiseled Roman serif (vintage book covers)
      displayLarge: GoogleFonts.cinzel(
        color: parchment, fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: 2,
      ),
      headlineMedium: GoogleFonts.cinzel(
        color: parchment, fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: 1.5,
      ),
      titleLarge: GoogleFonts.imFellEnglishSc(
        color: sepia, fontSize: 20, letterSpacing: 1.2,
      ),
      // Body — Special Elite is a battered typewriter face
      bodyLarge: GoogleFonts.specialElite(
        color: parchment, fontSize: 17, height: 1.55,
      ),
      bodyMedium: GoogleFonts.specialElite(
        color: parchment, fontSize: 15, height: 1.5,
      ),
      labelLarge: GoogleFonts.imFellEnglishSc(
        color: parchment, fontSize: 16, letterSpacing: 1.4,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: ink,
      colorScheme: const ColorScheme.dark(
        primary: sepia,
        onPrimary: ink,
        secondary: blood,
        onSecondary: parchment,
        surface: smoke,
        onSurface: parchment,
        error: blood,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: ink,
        foregroundColor: parchment,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cinzel(
          color: parchment, fontSize: 18, letterSpacing: 3, fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: smoke,
        elevation: 6,
        shadowColor: shadow,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: sepia, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: rust,
          foregroundColor: parchment,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: sepia, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          textStyle: GoogleFonts.imFellEnglishSc(
            fontSize: 16, letterSpacing: 1.6,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: sepia,
          textStyle: GoogleFonts.imFellEnglishSc(fontSize: 15, letterSpacing: 1.4),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: smoke,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: sepia, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
