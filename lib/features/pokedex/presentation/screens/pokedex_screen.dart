/*
 * @class PokedexScreen
 * @description Clase encargada de contener la pantalla de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_information.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../onboarding/presentation/provider/onboarding_provider.dart';
import '../../../favorites/presentation/provider/favorites_provider.dart';
import '../provider/pokedex_provider.dart';
import '../widgets/pokedex_list/pokedex_list_view.dart';
import 'pokedex_skeleton_screen.dart';
import '../widgets/pokedex_list/pokemon_filters.dart';

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
    Widget content = state.when(
      // Estado de carga: mostrar skeleton de los widgets
      loading: () {
        return const PokedexSkeletonScreen();
      },
      // Estado con la lista de Pokémon precargada
      loaded: (pokemons, searchQuery, selectedTypes) {
        final widget = Column(
          children: [
            SizedBox(height: 10),
            // Widget para filtrar en la lista de Pokémon
            SafeArea(
              bottom: false,
              child: PokedexFilters(
                searchQuery: searchQuery,
                selectedTypes: selectedTypes,
                onSearchChanged: (query) {
                  ref
                      .read(pokedexNotifierProvider.notifier)
                      .updateSearchQuery(query);
                },
                onTypesSelected: (types) {
                  ref
                      .read(pokedexNotifierProvider.notifier)
                      .updateSelectedTypes(types);
                },
              ),
            ),
            // Mostrar cantidad de resultados y botón para limpiar los filtros activos
            if (selectedTypes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 15),
                child: Row(
                  children: [
                    Text(
                      l10n.pokedexLabelFilter1,
                      style: AppTextStyles.textPoppins12Regular9E9E9E,
                    ),
                    Text(
                      pokemons.length.toString() + l10n.pokedexLabelFilter2,
                      style: AppTextStyles.textPoppins12Bold9E9E9E,
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(pokedexNotifierProvider.notifier)
                            .updateSelectedTypes([]);
                      },
                      child: Text(
                        l10n.pokedexClearFilters,
                        style: AppTextStyles.textPoppins12Medium1E88E5Underline,
                      ),
                    ),
                  ],
                ),
              ),
            // Lista de Pokémon
            Expanded(
              child: PokedexListView(
                pokemons: pokemons,
                onLoadingStart: () {
                  if (!mounted) return;
                },
                onLoadingEnd: () {
                  if (!mounted) return;
                },
              ),
            ),
          ],
        );
        return widget;
      },
      // Estado de error con mensaje descriptivo
      error: (errorMessage) {
        final widget = SafeArea(
          // Widget de error personalizado
          child: CustomInformation(
            imagePath: 'assets/common/information/information_image.png',
            title: l10n.onboardingInformationTitle,
            description: l10n.onboardingInformationDescription,
            showButton: true,
            buttonText: l10n.onboardingInformationRetryButton,
            onButtonTap: () {
              // Mostrar el overlay inmediatamente mientras el provider entra en loading
              setState(() {});
              ref
                  .read(pokedexNotifierProvider.notifier)
                  .fetchPokedexList()
                  .whenComplete(() {
                    if (!mounted) return;
                    setState(() {});
                  });
            },
          ),
        );
        return widget;
      },
    );

    return Stack(
      children: [
        // Detectar toques fuera del TextField para ocultar el teclado
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Stack(children: [Positioned.fill(child: content)]),
          ),
        ),
      ],
    );
  }
}
