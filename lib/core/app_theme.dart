/*
 * @class AppTheme
 * @description Clase encargada de contener los temas, colores y tipografías de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colores de la aplicación
class AppColors {
  AppColors._();

  // Tonos azules
  static const Color blue1E88E5 = Color(0xFF1E88E5);
  static const Color blue173EA5 = Color(0xFF173EA5);
  static const Color blue0D47A1 = Color(0xFF0D47A1);

  // Tonos tema claro y oscuro
  static const Color whiteFFFFFF = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF292A36);

  // Tonos grises y negros
  static const Color black121212 = Color(0xFF121212);
  static const Color black424242 = Color(0xFF424242);
  static const Color black333333 = Color(0xFF333333);
  static const Color black4D4D4D = Color(0xFF4D4D4D);
  static const Color blackDD000000 = Color(0xDD000000);
  static const Color black8A000000 = Color(0x8A000000);

  // Tipo de negrita aplicada a los textos
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Estilos de texto
  static TextStyle textPoppins14Regular424242 = GoogleFonts.poppins(
    fontSize: 14,
    color: black424242,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins14Regular4D4D4D = GoogleFonts.poppins(
    fontSize: 14,
    color: black4D4D4D,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textPoppins14Medium8A000000 = TextStyle(
    fontSize: 14,
    color: black8A000000,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins14Medium424242 = GoogleFonts.poppins(
    fontSize: 14,
    color: black424242,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppinsBold0D47A1 = GoogleFonts.poppins(
    fontSize: 14,
    color: blue0D47A1,
    fontWeight: fontWeightBold,
  );

  static TextStyle textPoppins16SemiBoldFFFFFF = GoogleFonts.poppins(
    fontSize: 16,
    color: whiteFFFFFF,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textPoppins20SemiboldDD000000 = TextStyle(
    fontSize: 20,
    color: blackDD000000,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textPoppins20Semibold333333 = TextStyle(
    fontSize: 20,
    color: black333333,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins26Medium121212 = GoogleFonts.poppins(
    fontSize: 26,
    color: black121212,
    fontWeight: fontWeightMedium,
  );
}

/// Temas de la aplicación
class AppTheme {
  AppTheme._();

  /// Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.light,
    primaryColor: AppColors.blue1E88E5,
    scaffoldBackgroundColor: AppColors.whiteFFFFFF,
  );

  /// Tema oscuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    brightness: Brightness.dark,
    primaryColor: AppColors.blue1E88E5,
    scaffoldBackgroundColor: AppColors.backgroundDark,
  );
}
