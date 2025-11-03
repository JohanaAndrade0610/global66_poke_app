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
import '../../../l10n/app_localizations.dart';
import '../provider/profile_provider.dart';
import '../widgets/rounded_selector.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo PokéApp
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Image.asset(
                    'assets/profile/pokeapp_logo.png', // Cambia la ruta si tienes el logo en otro asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 6),
              // Nombre del usuario
              Text(
                l10n.profileGuest,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 26),
              // Card desplegable para preferencias del usuario
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.greyE0E0E0, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide.none,
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide.none,
                    ),
                    iconColor: isDark
                        ? AppColors.whiteFAFAFA
                        : AppColors.grey757575,
                    collapsedIconColor: isDark
                        ? AppColors.whiteFAFAFA
                        : AppColors.grey757575,
                    title: Text(
                      l10n.profilePreferences,
                      style: AppTextStyles.textPoppins15Medium424242.copyWith(
                        color: isDark
                            ? AppColors.whiteFAFAFA
                            : AppColors.grey424242,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 1,
                              color: AppColors.greyE0E0E0,
                            ),
                            const SizedBox(height: 20),
                            // Idioma
                            Row(
                              children: [
                                // Icono de idioma
                                const Icon(Icons.language),
                                const SizedBox(width: 12),
                                // Etiqueta "Idioma"
                                Text(
                                  l10n.profileLanguage,
                                  style: AppTextStyles
                                      .textPoppins14Regular424242
                                      .copyWith(
                                        color: isDark
                                            ? AppColors.whiteFAFAFA
                                            : AppColors.grey424242,
                                      ),
                                ),
                                const Spacer(),
                                // Selector de idiomas
                                SizedBox(
                                  width: 100,
                                  child: RoundedSelector<Locale>(
                                    options: const [Locale('es'), Locale('en')],
                                    selected: locale,
                                    onChanged: (newLocale) =>
                                        logic.setLocale(newLocale),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text('ES'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text('EN'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Tema
                            Row(
                              children: [
                                // Icono de tema
                                const Icon(Icons.contrast_outlined),
                                const SizedBox(width: 12),
                                // Etiqueta "Tema"
                                Text(
                                  l10n.profileTheme,
                                  style: AppTextStyles
                                      .textPoppins14Regular424242
                                      .copyWith(
                                        color: isDark
                                            ? AppColors.whiteFAFAFA
                                            : AppColors.grey424242,
                                      ),
                                ),
                                const Spacer(),
                                // Selector de tema
                                SizedBox(
                                  width: 100,
                                  child: RoundedSelector<ThemeMode>(
                                    options: const [
                                      ThemeMode.light,
                                      ThemeMode.dark,
                                    ],
                                    selected: themeMode,
                                    onChanged: (mode) =>
                                        logic.setThemeMode(mode),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Icon(Icons.light_mode),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Icon(Icons.dark_mode),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Card desplegable Ayuda y soporte
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.greyE0E0E0, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide.none,
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide.none,
                    ),
                    iconColor: isDark
                        ? AppColors.whiteFAFAFA
                        : AppColors.grey757575,
                    collapsedIconColor: isDark
                        ? AppColors.whiteFAFAFA
                        : AppColors.grey757575,
                    title: Text(
                      l10n.profileSupport,
                      style: AppTextStyles.textPoppins15Medium424242.copyWith(
                        color: isDark
                            ? AppColors.whiteFAFAFA
                            : AppColors.grey424242,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 1,
                              color: AppColors.greyE0E0E0,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final ok = await logic.openWhatsApp();
                                    if (!ok) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'No se pudo abrir WhatsApp',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/profile/whatsapp_icon.png',
                                        height: 28,
                                        width: 28,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        l10n.profileConnectWhatsapp,
                                        style: AppTextStyles
                                            .textPoppins14Regular424242
                                            .copyWith(
                                              color: isDark
                                                  ? AppColors.whiteFAFAFA
                                                  : AppColors.grey424242,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
