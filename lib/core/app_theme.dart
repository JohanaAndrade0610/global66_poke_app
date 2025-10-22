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
  static const Color blue1E88E5 = Color(0xFF1E88E5); // Azul principal
  static const Color blue173EA5 = Color(0xFF173EA5); // Azul oscuro
  static const Color blue0D47A1 = Color(0xFF0D47A1); // Azul oscuro

  // Tonos tema claro y oscuro
  static const Color whiteFFFFFF = Color(0xFFFFFFFF); // Blanco
  static const Color backgroundDark = Color(
    0xFF292A36,
  ); // Gris oscuro para dark mode

  // Tonos grises y negros
  static const Color black121212 = Color(0xFF121212); // Negro principal
  static const Color black424242 = Color(0xFF424242); // Negro secundario

  // Tipo de negrita aplicada a los textos
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;

  // Estilos de texto
  static TextStyle textPoppins26Medium121212 = GoogleFonts.poppins(
    fontSize: 26,
    color: black121212,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins14Regular424242 = GoogleFonts.poppins(
    fontSize: 14,
    color: black424242,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins16SemiBoldFFFFFF = GoogleFonts.poppins(
    fontSize: 16,
    color: whiteFFFFFF,
    fontWeight: fontWeightSemiBold,
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
