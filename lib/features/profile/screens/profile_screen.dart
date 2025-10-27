/*
 * @class ProfileScreen
 * @description Clase encargada de mostrar la pantalla de perfil del usuario.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global66_poke_app/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import '../../../core/locale_notifier.dart';
import '../../../core/theme_mode_notifier.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Notificador de idioma de la aplicación
    final localeNotifier = ref.watch(localeNotifierProvider);
    // Notificador de modo de tema de la aplicación
    final themeModeNotifier = ref.watch(themeModeNotifierProvider);
    // Estado actual del idioma y tema
    final locale = localeNotifier.value;
    // Estado actual del modo de tema
    final themeMode = themeModeNotifier.value;
    // Verificar si el tema es oscuro
    final isDark = themeMode == ThemeMode.dark;
    // Internacionalización de los textos
    final l10n = AppLocalizations.of(context)!;

    // Lógica de la pantalla (provider)
    final logic = ref.read(profileLogicProvider);

    return Scaffold(
      // Appbar generico de la aplicación
      appBar: CustomAppBar(
        title: l10n.bottomNavigationBarProfile,
        showTitle: true,
        showFavoriteIcon: false,
        onBackTap: () => context.go('/pokedex'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo PokéApp
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset(
                  'assets/profile/pokeapp_logo.png', // Cambia la ruta si tienes el logo en otro asset
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Nombre del usuario
            Text(
              l10n.profileGuest,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Preferencias de usuario
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.profilePreferences,
                style: AppTextStyles.textPoppins15Medium424242Underline.copyWith(
                      color: isDark
                          ? AppColors.whiteFAFAFA
                          : AppColors.grey424242,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            // Idioma
            Row(
              children: [
                // Icono de idioma
                const Icon(Icons.language),
                const SizedBox(width: 12),
                // Etiqueta "Idioma"
                Text(l10n.profileLanguage, style: AppTextStyles.textPoppins14Regular424242.copyWith(
                      color: isDark
                          ? AppColors.whiteFAFAFA
                          : AppColors.grey424242,
                    ),),
                const Spacer(),
                // Botones de selección de idioma
                ToggleButtons(
                  isSelected: [
                    locale == const Locale('es'),
                    locale == const Locale('en'),
                  ],
                  onPressed: (index) {
                    final newLocale = index == 0
                        ? const Locale('es')
                        : const Locale('en');
                    logic.setLocale(newLocale);
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(l10n.profileSpanish),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(l10n.profileEnglish),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tema
            Row(
              children: [
                // Icono de tema
                const Icon(Icons.nightlight_round),
                const SizedBox(width: 12),
                // Etiqueta "Tema"
                Text(l10n.profileTheme, style: AppTextStyles.textPoppins14Regular424242.copyWith(
                      color: isDark
                          ? AppColors.whiteFAFAFA
                          : AppColors.grey424242,
                    ),),
                const Spacer(),
                // Switch para cambiar entre modo claro y oscuro
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    logic.toggleDark(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Etiqueta de soporte o ayuda
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.profileSupport,
                style:  AppTextStyles.textPoppins15Medium424242Underline.copyWith(
                      color: isDark
                          ? AppColors.whiteFAFAFA
                          : AppColors.grey424242,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            // Icono de whatsApp
            // WhatsApp
            ListTile(
              leading: Image.asset(
                'assets/profile/whatsapp_icon.png', // Asegúrate de tener este PNG en tus assets
                height: 32,
                width: 32,
              ),
              title: Text(l10n.profileConnectWhatsapp, style: AppTextStyles.textPoppins14Regular424242.copyWith(
                      color: isDark
                          ? AppColors.whiteFAFAFA
                          : AppColors.grey424242,
                    ),),
              onTap: () async {
                final ok = await logic.openWhatsApp();
                if (!ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No se pudo abrir WhatsApp')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      // Barra de navegación generica de la aplicación
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index == 0) {
            context.go('/pokedex');
          } else if (index == 1) {
            context.go('/regions');
          } else if (index == 2) {
            context.go('/favorites');
          } else if (index == 3) {
            // Ventana actual
          }
        },
      ),
    );
  }
}
