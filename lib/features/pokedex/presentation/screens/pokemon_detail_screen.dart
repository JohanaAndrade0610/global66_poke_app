/*
 * @class PokemonDetailScreen
 * @description Clase encargada de contener la pantalla de detalles de un Pokémon específico.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme_mode_notifier.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/widgets/custom_pokemon_type_label.dart';
import '../widgets/pokedex_details/info_box_grid.dart';
import '../widgets/pokedex_details/gender_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../provider/pokemon_detail_provider.dart';
import '../../../favorites/presentation/provider/favorites_provider.dart';
import '../../domain/entities/pokedex_entity.dart';
import '../widgets/pokedex_details/pokemon_header.dart';
import 'pokemon_detail_skeleton_screen.dart';

class PokemonDetailScreen extends ConsumerWidget {
  // Nombre del Pokémon cuyos detalles se mostrarán
  final String pokemonName;
  const PokemonDetailScreen({Key? key, required this.pokemonName})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tamaño de la pantalla para cálculos de diseño
    final size = MediaQuery.of(context).size;
    // Altura del semicírculo superior
    final semicircleHeight = size.height * 0.3;
    // Factores del header (deben coincidir con el widget para alinear el espacio inferior)
    const imgHFactor = 0.6;
    const overlapFactor = 0.4;
    final pokemonImageOverlap = semicircleHeight * imgHFactor * overlapFactor;
    // Internacionalización de los textos de la pantalla
    final l10n = AppLocalizations.of(context)!;
    // Estado del proveedor de detalles del Pokémon
    final state = ref.watch(pokemonDetailNotifierProvider);
    // Notificador de modo de tema de la aplicación
    final themeModeNotifier = ref.watch(themeModeNotifierProvider);
    // Estado actual del modo de tema
    final themeMode = themeModeNotifier.value;
    // Verificar si el tema es oscuro
    final isDark = themeMode == ThemeMode.dark;

    // Provider de favoritos
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);
    final isFavorite = state.maybeWhen(
      loaded: (detail) => favoritesState.maybeWhen(
        loaded: (favorites, favoriteIds) => favoriteIds.contains(detail.id),
        orElse: () => false,
      ),
      orElse: () => false,
    );
    return Scaffold(
      // Permite que el cuerpo se dibuje detrás del AppBar para que el color del semicírculo lo cubra
      extendBodyBehindAppBar: true,
      // Appbar generico de la aplicación
      appBar: state.when(
        loaded: (_) => CustomAppBar(
          showTitle: false,
          showFavoriteIcon: true,
          isFavorite: isFavorite,
          forceLightIcon: true,
          onBackTap: () {
            context.pop();
          },
          // Manejo del tap en el ícono de favorito
          onFavoriteTap: () {
            state.maybeWhen(
              loaded: (detail) {
                favoritesNotifier.toggleFavorite(
                  PokedexEntity(
                    id: detail.id,
                    name: detail.name,
                    imageUrl: detail.imageUrl,
                    types: detail.types,
                  ),
                );
                ref.invalidate(favoritesNotifierProvider);
              },
              orElse: () {},
            );
          },
        ),
        error: (_) => null,
        loading: () => null,
      ),
      body: state.when(
        // Estado cargado
        loaded: (detail) => Column(
          children: [
            SizedBox(
              height: semicircleHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SafeArea(
                    top: false,
                    child: PokemonHeader(
                      height: semicircleHeight,
                      primaryType: detail.types.first,
                      imageUrl: detail.imageUrl,
                      imageWidthFactor: 0.8,
                      imageHeightFactor: imgHFactor,
                      overlapFactor: overlapFactor,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).padding.top,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Espacio para que el Pokémon que sobresale no tape el contenido
                    SizedBox(height: pokemonImageOverlap + 8),
                    // Nombre del Pokémon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.name[0].toUpperCase() +
                                detail.name.substring(1),
                            style: AppTextStyles.textPoppins32Medium121212
                                .copyWith(
                                  color: isDark
                                      ? AppColors.whiteFAFAFA
                                      : AppColors.grey121212,
                                ),
                          ),
                          // ID del Pokémon
                          Text(
                            'N°${detail.id.toString().padLeft(3, '0')}',
                            style: AppTextStyles.textPoppins16Medium424242
                                .copyWith(
                                  color: isDark
                                      ? AppColors.greyE0E0E0
                                      : AppColors.grey424242,
                                ),
                          ),
                          const SizedBox(height: 20),
                          // Etiquetas de tipos
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: detail.types
                                .map(
                                  (type) => CustomPokemonTypeLabel(
                                    type: type,
                                    l10n: l10n,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          // Descripción del Pokémon
                          Text(
                            detail.description,
                            style: AppTextStyles.textPoppins14Regular424242
                                .copyWith(
                                  color: isDark
                                      ? AppColors.greyE0E0E0
                                      : AppColors.grey424242,
                                ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20),
                          // Línea divisora
                          const Divider(height: 1, color: AppColors.greyE0E0E0),
                          SizedBox(height: 20),
                          // Información general del Pokémon
                          InfoBoxGrid(
                            items: [
                              // Caja de información para peso
                              InfoBoxData(
                                svgAsset:
                                    'assets/pokedex/details/weight_icon.svg',
                                title: l10n.pokedexWeight,
                                value:
                                    '${detail.weight.toStringAsFixed(1).replaceAll('.', ',')} kg',
                              ),
                              // Caja de información para altura
                              InfoBoxData(
                                svgAsset:
                                    'assets/pokedex/details/height_icon.svg',
                                title: l10n.pokedexHeight,
                                value:
                                    '${detail.height.toStringAsFixed(1).replaceAll('.', ',')} m',
                              ),
                              // Caja de información para categoría
                              InfoBoxData(
                                svgAsset:
                                    'assets/pokedex/details/category_icon.svg',
                                title: l10n.pokedexCategory,
                                value: detail.category
                                    .replaceAll('Pokémon', '')
                                    .trim(),
                              ),
                              // Caja de información para habilidad
                              InfoBoxData(
                                svgAsset:
                                    'assets/pokedex/details/ability_icon.svg',
                                title: l10n.pokedexAbility,
                                value:
                                    detail.ability[0].toUpperCase() +
                                    detail.ability.substring(1),
                              ),
                            ],
                            columns: 2,
                            spacing: 12,
                          ),
                          const SizedBox(height: 25),
                          // Barra de género del Pokémon
                          GenderBar(
                            maleRate: detail.maleRate,
                            femaleRate: detail.femaleRate,
                          ),
                          const SizedBox(height: 30),
                          // Sección de debilidades
                          Text(
                            l10n.pokedexWeaknesses,
                            style: AppTextStyles.textPoppins18Medium121212
                                .copyWith(
                                  color: isDark
                                      ? AppColors.whiteFAFAFA
                                      : AppColors.grey121212,
                                ),
                          ),
                          const SizedBox(height: 16),
                          // Tipos de debilidades del Pokémon
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: detail.weaknesses
                                .map(
                                  (type) => CustomPokemonTypeLabel(
                                    type: type,
                                    l10n: l10n,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Estado error
        error: (error) => Center(child: Text(error)),
        // Estado cargando
        loading: () => PokemonDetailSkeletonScreen(
          semicircleHeight: semicircleHeight,
          overlapSpace: pokemonImageOverlap + 8,
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
    );
  }
}
