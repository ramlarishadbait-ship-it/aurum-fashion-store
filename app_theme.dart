import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Brand Palette ───────────────────────────────────────────
  static const Color ivory = Color(0xFFF9F6F0);
  static const Color champagne = Color(0xFFEDE0C8);
  static const Color gold = Color(0xFFC9A84C);
  static const Color darkGold = Color(0xFF9C7A2E);
  static const Color obsidian = Color(0xFF0E0E0E);
  static const Color charcoal = Color(0xFF1C1C1C);
  static const Color smoke = Color(0xFF3A3A3A);
  static const Color muted = Color(0xFF8A8A8A);
  static const Color divider = Color(0xFFE8E0D0);
  static const Color surface = Color(0xFFFFFDF9);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color errorRed = Color(0xFFB94040);

  // ─── Light Theme ─────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: ivory,
      primaryColor: obsidian,
      colorScheme: const ColorScheme.light(
        primary: obsidian,
        secondary: gold,
        surface: surface,
        error: errorRed,
      ),

      // Typography
      textTheme: GoogleFonts.cormorantGaramondTextTheme().copyWith(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          color: obsidian,
          letterSpacing: 2.0,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: obsidian,
          letterSpacing: 1.5,
        ),
        displaySmall: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: obsidian,
          letterSpacing: 1.0,
        ),
        headlineLarge: GoogleFonts.cormorantGaramond(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: obsidian,
          letterSpacing: 0.8,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: obsidian,
          letterSpacing: 0.5,
        ),
        titleLarge: GoogleFonts.jost(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: obsidian,
          letterSpacing: 1.5,
        ),
        titleMedium: GoogleFonts.jost(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: smoke,
          letterSpacing: 1.2,
        ),
        bodyLarge: GoogleFonts.jost(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: charcoal,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.jost(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: smoke,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.jost(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: muted,
          letterSpacing: 0.8,
        ),
        labelLarge: GoogleFonts.jost(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: obsidian,
          letterSpacing: 2.0,
        ),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: ivory,
        elevation: 0,
        iconTheme: const IconThemeData(color: obsidian),
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: obsidian,
          letterSpacing: 2.0,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: obsidian,
          foregroundColor: ivory,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          textStyle: GoogleFonts.jost(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: obsidian,
          side: const BorderSide(color: obsidian, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          textStyle: GoogleFonts.jost(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: divider, width: 1),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: divider, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: obsidian, width: 1.5),
        ),
        labelStyle: GoogleFonts.jost(
          fontSize: 13,
          color: muted,
          letterSpacing: 1.2,
        ),
        hintStyle: GoogleFonts.jost(fontSize: 13, color: muted),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      ),

      dividerTheme: const DividerThemeData(color: divider, thickness: 0.5),
    );
  }
}
