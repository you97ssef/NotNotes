import 'package:flutter/material.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color initialSeedColor = Colors.redAccent;
  static bool initialInDarkMode = false;

  static ThemeData theme(ConfigEntity? config) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: config?.seedColor ?? initialSeedColor, brightness: config?.inDarkMode ?? initialInDarkMode ? Brightness.dark : Brightness.light),
        useMaterial3: true,
        fontFamily: GoogleFonts.kalam().fontFamily,
      );

  static bool visibleDebugBanner = false;
}
