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
  static const Color blue2551C3 = Color(0xFF2551C3);
  static const Color blue0D47A1 = Color(0xFF0D47A1);

  // Tonos rojizos
  static const Color redCD3131 = Color(0xFFCD3131);
  static const Color pinkFF7596 = Color(0xFFFF7596);

  // Tonos blancos y claros
  static const Color whiteFFFFFF = Color(0xFFFFFFFF);
  static const Color whiteFAFAFA = Color(0xFFFAFAFA);

  // Tonos grises y negros
  static const Color greyE0E0E0 = Color(0xFFE0E0E0);
  static const Color greyEEEEEE = Color(0xFFEEEEEE);
  static const Color grey9E9E9E = Color(0xFF9E9E9E);
  static const Color grey121212 = Color(0xFF121212);
  static const Color grey424242 = Color(0xFF424242);
  static const Color grey333333 = Color(0xFF333333);
  static const Color grey4D4D4D = Color(0xFF4D4D4D);
  static const Color grey757575 = Color(0xFF757575);
  static const Color grey292A36 = Color(0xFF292A36);
  static const Color blackDD000000 = Color(0xDD000000);
  static const Color black8A000000 = Color(0x8A000000);
}

// Estilos de texto de la aplicación
class AppTextStyles {
  AppTextStyles._();

  // Tipo de negrita aplicada a los textos
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  static TextStyle textPoppins11MediumFAFAFA = GoogleFonts.poppins(
    fontSize: 11,
    color: AppColors.whiteFAFAFA,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins12Medium424242 = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.grey424242,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins12SemiBoldFFFFFF = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.whiteFFFFFF,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins12SemiBold121212 = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.grey121212,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins12Semibold424242 = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.grey424242,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins12Regular9E9E9E = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.grey9E9E9E,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins12Bold9E9E9E = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.grey9E9E9E,
    fontWeight: fontWeightBold,
  );

  static TextStyle textPoppins12Medium1E88E5Underline = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.blue1E88E5,
    fontWeight: fontWeightMedium,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.blue1E88E5,
  );

  static TextStyle textPoppins14SemiBoldFAFAFA = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.whiteFAFAFA,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins14Regular9E9E9E = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.grey9E9E9E,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins14Regular424242 = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.grey424242,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins14Regular4D4D4D = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.grey4D4D4D,
    fontWeight: fontWeightRegular,
  );

  static TextStyle textPoppins14SemiBold121212 = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.grey121212,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textPoppins14Medium8A000000 = TextStyle(
    fontSize: 14,
    color: AppColors.black8A000000,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins14Medium424242 = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.grey424242,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppinsBold0D47A1 = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.blue0D47A1,
    fontWeight: fontWeightBold,
  );

  static TextStyle textPoppins16SemiBoldFFFFFF = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.whiteFFFFFF,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins16Medium424242 = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.grey424242,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins16SemiBold121212 = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.grey121212,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins18Medium121212 = GoogleFonts.poppins(
    fontSize: 18,
    color: AppColors.grey121212,
    fontWeight: fontWeightMedium,
  );

  static const TextStyle textPoppins20SemiboldDD000000 = TextStyle(
    fontSize: 20,
    color: AppColors.blackDD000000,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textPoppins20Semibold333333 = TextStyle(
    fontSize: 20,
    color: AppColors.grey333333,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins21Semibold121212 = GoogleFonts.poppins(
    fontSize: 21,
    color: AppColors.grey121212,
    fontWeight: fontWeightSemiBold,
  );

  static TextStyle textPoppins26Medium121212 = GoogleFonts.poppins(
    fontSize: 26,
    color: AppColors.grey121212,
    fontWeight: fontWeightMedium,
  );

  static TextStyle textPoppins32Medium121212 = GoogleFonts.poppins(
    fontSize: 32,
    color: AppColors.grey121212,
    fontWeight: fontWeightMedium,
  );
}

// Colores de los tipos de Pokémon
class PokemonTypeColors {
  PokemonTypeColors._();
  // Mapa de colores asociados a cada tipo de Pokémon
  static const Map<String, Color> typeColors = {
    'bug': Color(0xFF43A047),
    'dark': Color(0xFF8BC34A),
    'dragon': Color(0xFF00ACC1),
    'electric': Color(0xFFFDD835),
    'fairy': Color(0xFFE91E63),
    'fighting': Color(0xFFE53935),
    'fire': Color(0xFFFF9800),
    'flying': Color(0xFF00BCD4),
    'ghost': Color(0xFF8E24AA),
    'grass': Color(0xFF8BC34A),
    'ground': Color(0xFFFDD835),
    'ice': Color(0xFF3D8BFF),
    'normal': Color(0xFF8BC34A),
    'poison': Color(0xFF9C27B0),
    'psychic': Color(0xFF673AB7),
    'rock': Color(0xFF795548),
    'steel': Color(0xFF8BC34A),
    'water': Color(0xFF2196F3),
  };

  // Se obtiene el color correspondiente al tipo de Pokémon
  static Color getTypeColor(String type) {
    return typeColors[type.toLowerCase()]!;
  }

  // Se obtiene la ruta del asset del logo de la imagen según el tipo de Pokémon
  static String getTypeLogoPath(String type) {
    final typeKey = type.toLowerCase();
    return 'assets/pokedex/types/$typeKey.svg';
  }

  // Se obtiene la ruta del asset del logo del label según el tipo de Pokémon
  static String getTypeLabelLogoPath(String type) {
    final typeKey = type.toLowerCase();
    return 'assets/pokedex/labels/$typeKey.svg';
  }
}

// Temas de la aplicación
class AppTheme {
  AppTheme._();

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.light,
    primaryColor: AppColors.blue1E88E5,
    scaffoldBackgroundColor: AppColors.whiteFFFFFF,
  );

  // Tema oscuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    brightness: Brightness.dark,
    primaryColor: AppColors.blue1E88E5,
    scaffoldBackgroundColor: AppColors.grey292A36,
  );
}
