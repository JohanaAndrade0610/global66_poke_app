/*
 * @class PokedexNotifier
 * @description Clase encargada de contener el gestor de estado de la pantalla de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'pokedex_state.dart';
import '../../domain/usecases/get_pokedex_list_usecase.dart';
import '../../../../di/injection.dart';

part 'pokedex_provider.g.dart';

@riverpod
class PokedexNotifier extends _$PokedexNotifier {
  /*
  * @method build
  * @description Método inicializador del estado del proveedor de Pokédex.
  */
  @override
  PokedexState build() {
    ref.keepAlive();
    return const PokedexState.loaded([]);
  }

  /*
  * @method fetchPokedexList
  * @description Método encargado de obtener la lista de Pokémon desde el repositorio.
  * @param rethrowOnError - Indica si se debe relanzar la excepción en caso de error.
  */
  Future<void> fetchPokedexList({bool rethrowOnError = false}) async {
    state = const PokedexState.loading();
    try {
      final usecase = getIt<GetPokedexListUsecase>();
      final pokemons = await usecase.call();
      state = PokedexState.loaded(pokemons);
    } catch (e) {
      state = PokedexState.error(e.toString());
      if (rethrowOnError) rethrow;
    }
  }
}
