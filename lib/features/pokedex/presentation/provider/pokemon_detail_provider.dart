/*
 * @class PokemonDetailNotifier
 * @description Provider para el estado de la pantalla de detalle de Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/get_pokemon_detail_usecase.dart';
import '../../../../di/injection.dart';
import 'pokemon_detail_state.dart';

part 'pokemon_detail_provider.g.dart';

@riverpod
class PokemonDetailNotifier extends _$PokemonDetailNotifier {
  /*
  * @method build
  * @description Construye el estado inicial del proveedor.
  */
  @override
  PokemonDetailState build() {
    ref.keepAlive();
    return const PokemonDetailState.loading();
  }

  /*
  * @method fetchDetail
  * @description Obtiene los detalles de un Pokémon específico.
  */
  Future<void> fetchDetail(String name) async {
    state = const PokemonDetailState.loading();
    try {
      final usecase = getIt<GetPokemonDetailUsecase>();
      final detail = await usecase.call(name);
      state = PokemonDetailState.loaded(detail);
    } catch (e) {
      state = PokemonDetailState.error(e.toString());
    }
  }
}
