/*
 * @class ProfileScreen
 * @description Clase encargada de mostrar la pantalla de perfil del usuario.
 * @autor Angela Andrade
 * @version 1.0 27/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config.dart';
import '../../../core/locale_notifier.dart';
import '../../../core/theme_mode_notifier.dart';

part 'profile_provider.g.dart';

/// Clase de ayuda con las operaciones de la pantalla de perfil.
class ProfileLogic {
  ProfileLogic(this.ref);
  // Referencia al provider
  final Ref ref;

  // Get idioma actual
  Locale get currentLocale => ref.read(localeNotifierProvider).value;
  // Get tema actual
  ThemeMode get currentThemeMode => ref.read(themeModeNotifierProvider).value;

  /*
  *@method setLocale
  *@description Cambia el idioma de la app.
  *@param locale Nuevo idioma a establecer.
  */
  void setLocale(Locale locale) {
    ref.read(localeNotifierProvider).value = locale;
  }

  /*
  *@method setThemeMode
  *@description Cambia el modo de tema de la app.
  *@param mode Nuevo modo de tema a establecer.
  */
  void setThemeMode(ThemeMode mode) {
    ref.read(themeModeNotifierProvider).value = mode;
  }

  /*
  *@method toggleDark
  *@description Cambia el modo de tema entre claro y oscuro.
  */
  void toggleDark(bool isDark) {
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /*
  *@method openWhatsApp
  *@description Abre la aplicación de WhatsApp para contactar soporte.
  */
  Future<bool> openWhatsApp() async {
    final url = Uri.parse('https://wa.me/${AppConfig.whatsappNumber}');
    try {
      final ok = await launchUrl(url, mode: LaunchMode.externalApplication);
      return ok;
    } catch (_) {
      return false;
    }
  }
}

/// Provider generado con anotaciones que expone la lógica.
@riverpod
ProfileLogic profileLogic(ProfileLogicRef ref) => ProfileLogic(ref);
