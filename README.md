# Resumen del proyecto

PokéApp es una aplicación móvil desarrollada con Flutter cuyo objetivo principal es ofrecer un catálogo de Pokemons con funcionalidades como splash, onboarding, listado y filtrado de Pokemons, gestión de favoritos, perfil de usuario, exploración por regiones y finalmente manejo de temas claro y oscuro, soporte multilenguaje (inglés y español) y un acceso directo para soporte vía WhatsApp. La app sigue una arquitectura inspirada en Clean Architecture y usa generación de código (Freezed, Json Serializable) y providers para la gestión de estados.

## Estructura general ampliada de `lib/`

A continuación se listan los archivos y carpetas más relevantes por área y por feature:

### Archivos raíz

- `main.dart` — Punto de entrada: inicializa Flutter, carga `di/injection.dart`, y arranca la app.
- `app.dart` — Configuración global: `MaterialApp`/`CupertinoApp`, temas, localización, router y providers a nivel de app.

### Core — infraestructura y utilidades

- `core/app_router.dart` — Rutas y navegación centralizada (usar `GoRouter` de Flutter).
- `core/config.dart` — Constantes globales (API base y número de celular para soporte vía Whatsapp).
- `core/locale_notifier.dart` — Archivo central para cambiar el idioma en la aplicación.
- `core/theme_mode_notifier.dart` — Archivo principal para el control de temas claro y oscuro.
- `core/theme/app_theme.dart` — Define tipografías, colores y estilos reutilizables.
- `core/connectivity/connectivity_handler.dart` — Monitor de conectividad (Stream) que notifica cambios.
- `core/connectivity/connectivity_service.dart` — Implementación concreta para validar la conexión a internet.
- `core/connectivity/no_connection_screen.dart` — Pantalla para mostrar cuando no hay conexión.
- `core/widgets` — Widgets reutilizables en toda la aplicación.

### DI

- `di/injection.dart` — Registro de singleton/providers: datasources, repositorios, usecases y providers (se utilizó el paquete `get_it`).

### Features

- `features/` — Módulos funcionales. Cada feature sigue la misma división: `data/`, `domain/`, `presentation/`.

  - `favorites/`
    - `data/datasource` — Persistencia local de Pokemons favoritos.
    - `data/models` — Modelos con Freezed y Json Serializable.
    - `data/repositories` — Implementación del repositorio.
    - `domain` — Entidades, interfaces de repositorio y casos de uso.
    - `presentation/provider` — Providers y estados generados.
    - `presentation/screens/favorites_screen.dart` — Pantalla de favoritos.
    - `presentation/widgets` — Componentes pertenecientes a la interfaz de usuario.

  - `onboarding/`
    - Lógica y pantallas de bienvenida.

  - `pokedex/`
    - `data/datasource` — Cliente para consumir la API remota de Pokémons.
    - `data/models` — Modelos con Freezed y Json Serializable.
    - `data/repositories` — Implementación del repositorio.
    - `domain` — Entidades, interfaces de repositorio y casos de uso.
    - `presentation/providers` — Providers y estados generados.
    - `presentation/screens` — Pantalla de listado de Pokemons y pantalla de detalles de un Pokemon en especifico.
    - `presentation/widgets` — Componentes pertenecientes a las interfaces de usuario.

  - `profile/`
    - `presentation/screens/profile_screen.dart` — Pantalla del perfil del usuario.

  - `regions/`
    - `presentation/screens/` — Pantalla para visualización/selección de regiones.

- `l10n/` — Internacionalización de la aplicación y archivos generados.

## Tecnologías y patrones principales

- Framework: Flutter (Dart)
- Arquitectura: Clean Architecture (data / domain / presentation)
- Estado: Providers / Riverpod (con anotaciones)
- Generación de código: Freezed, Json Serializable (`json_annotation`) y `build_runner`
- Inyección de dependencias (utilizando `get_it`)
- Persistencia local: Se utilizó `sqflite`.
- Comunicación remota: `dio` para consumir la API de PokéAPI.

## Comandos recomendados (PowerShell)

Ejecute estos comandos desde la raíz del proyecto (`C:\Personal\GLOBAL66\global66_poke_app`). Están ordenados para limpiar, instalar dependencias, generar artefactos y ejecutar la app. Uso en PowerShell (cada comando en su propia línea):

```powershell
# 0. Limpiar build previo
flutter clean

# 1. Obtener dependencias
flutter pub get

# 2. Generar localizations (genera AppLocalizations)
flutter gen-l10n

# 3. Limpiar outputs de build_runner
flutter pub run build_runner clean

# 4. Generar archivos Freezed / JSON / Providers
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Ejecutar la aplicación
flutter run
```

## Contribuir

⭐ ¡Si le gusta este proyecto, no olvide darle una estrella! ⭐
