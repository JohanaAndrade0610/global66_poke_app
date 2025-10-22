/*
 * @class AppRouter
 * @description Clase encargada de contener todas las rutas de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();

  final router = GoRouter(
    // Ruta inicial
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // // Pokedex
      // GoRoute(path: '/pokedex', builder: (context, state) => PokedexScreen()),
      // // Regions
      // GoRoute(path: '/regions', builder: (context, state) => RegionsScreen()),
      // // Favorites
      // GoRoute(path: '/favorites', builder: (context, state) => FavoritesScreen()),
      // // Profile
      // GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    ],
  );
}
