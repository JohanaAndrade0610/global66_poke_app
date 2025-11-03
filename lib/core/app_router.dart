/*
 * @class AppRouter
 * @description Clase encargada de contener todas las rutas de la aplicación con un shell persistente para el BottomNavigationBar.
 * @autor Angela Andrade
 * @version 2.0 03/11/2025 Migración a StatefulShellRoute para mantener el bottom navigation persistente.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_main_screen.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/pokedex/presentation/screens/pokedex_screen.dart';
import '../features/regions/presentation/screens/regions_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/pokedex/presentation/screens/pokemon_detail_screen.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();

  // Navigator keys opcionales por si se requiere control avanzado.
  final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootKey,
    routes: [
      // Rutas fuera del shell (Splash y Onboarding)
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Shell persistente con 4 pestañas y navegación con IndexedStack
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainScreen(navigationShell: navigationShell),
        branches: [
          // Branch Pokédex
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pokedex',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PokedexScreen()),
                routes: [
                  GoRoute(
                    path: 'pokemon/:name',
                    builder: (context, state) => PokemonDetailScreen(
                      pokemonName: state.pathParameters['name']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Branch Regiones
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/regions',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: RegionsScreen()),
              ),
            ],
          ),
          // Branch Favoritos
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FavoritesScreen()),
              ),
            ],
          ),
          // Branch Perfil
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
