import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // ===== Tipografías generales con Google Fonts =====

  static final TextStyle blueMindtitle = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorLight,
  );

  static final TextStyle h1TitulosPrincipales = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorLight,
  );

  static final TextStyle h2SubtitulosImportantes = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorLight,
  );

  static final TextStyle h3Menus = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorLight,
  );

  static final TextStyle parrafos = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorLight,
  );

  static final TextStyle textoSecundario = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.black54,
  );

  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonTextLight,
  );
}
