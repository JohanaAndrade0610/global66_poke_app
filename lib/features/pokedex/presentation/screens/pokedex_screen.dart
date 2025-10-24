/*
 * @class PokedexScreen
 * @description Clase encargada de contener la pantalla de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/widgets/custom_information.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../onboarding/presentation/provider/onboarding_provider.dart';
import '../../../favorites/presentation/provider/favorites_provider.dart';
import '../provider/pokedex_provider.dart';
import '../widgets/pokemon_list_view.dart';

class PokedexScreen extends ConsumerStatefulWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends ConsumerState<PokedexScreen> {
  /*
  * @method initState
  * @description Inicializa el estado y limpia el loading de onboarding.
  */
  @override
  void initState() {
    super.initState();
    // Limpiar el loading de onboarding en cuanto se ingresa a Pokedex
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingControllerProvider.notifier).ensureLoadingFalse();
      // Cargar favoritos al iniciar la aplicación
      ref.read(favoritesNotifierProvider.notifier).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el estado actual de la pantalla Pokédex
    final state = ref.watch(pokedexNotifierProvider);
    // Internacionalización de los textos
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Scaffold(
          body: state.when(
            // Estado de carga de la pantalla
            loading: () => const Center(child: CircularProgressIndicator()),
            // Estado con la lista de Pokémon precargada
            loaded: (pokemons) => PokemonListView(pokemons: pokemons),
            // Estado de error con mensaje descriptivo
            error: (errorMessage) => SafeArea(
              // Widget de error personalizado
              child: CustomInformation(
                imagePath: 'assets/common/information/information_image.png',
                title: l10n.onboardingInformationTitle,
                description: l10n.onboardingInformationDescription,
                showButton: true,
                buttonText: l10n.onboardingInformationRetryButton,
                onButtonTap: () {
                  ref.read(pokedexNotifierProvider.notifier).fetchPokedexList();
                },
              ),
            ),
          ),
          // Footer generico de la aplicación
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: 0,
            onItemTapped: (index) {
              if (index == 0) {
                // Ventana actual
              } else if (index == 1) {
                context.go('/regions');
              } else if (index == 2) {
                context.go('/favorites');
              } else if (index == 3) {
                context.go('/profile');
              }
            },
          ),
        ),
      ],
    );
  }
}
