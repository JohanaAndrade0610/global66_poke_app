/*
 * @class App
 * @description Clase encargada de contener la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'core/app_router.dart';
import 'core/connectivity/connectivity_handler.dart';
import 'core/connectivity/connectivity_service.dart';
import 'core/locale_notifier.dart';
import 'core/theme_mode_notifier.dart';

// Servicio de conectividad para toda la aplicación
final ConnectivityService _connectivityService = ConnectivityService();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración del router
    final router = AppRouter.instance.router;
    return
    // Retornar la aplicación con el router configurado, temas e idiomas de la aplicación
    ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, locale, _) {
            return MaterialApp.router(
              title: 'global66_poke_app',
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.white,
              ),
              // Gris personalizado para el modo oscuro
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: const Color(0xFF292A36),
              ),
              themeMode: mode,
              locale: locale,
              routerConfig: router,
              // Manejo de la conectividad en toda la aplicación
              builder: (context, child) => ConnectivityHandler(
                service: _connectivityService,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
