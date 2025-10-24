/*
 * @class Injection
 * @description Clase encargada de la inyección de dependencias en la aplicación.
 * @author Angela Andrade
 * @version 1.0 21/10/2025 Creación y documentación de la clase.
 */

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../features/pokedex/data/datasource/pokedex_remote_datasource.dart';
import '../features/pokedex/data/repositories/pokedex_repository_impl.dart';
import '../features/pokedex/domain/repositories/pokedex_repository.dart';
import '../features/pokedex/domain/usecases/get_pokedex_list_usecase.dart';
import '../features/favorites/data/datasource/favorites_local_datasource.dart';
import '../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../features/favorites/domain/repositories/favorites_repository.dart';
import '../features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import '../features/favorites/domain/usecases/is_favorite_usecase.dart';
import '../features/favorites/domain/usecases/toggle_favorite_usecase.dart';

// Instancia de GetIt para la inyección de dependencias
final getIt = GetIt.instance;

void init() {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Fuente de datos remota de Pokedex
  getIt.registerLazySingleton<PokedexRemoteDatasource>(
    () => PokedexRemoteDatasource(getIt<Dio>()),
  );

  // Repositorio de Pokedex
  getIt.registerLazySingleton<PokedexRepository>(
    () => PokedexRepositoryImpl(getIt<PokedexRemoteDatasource>()),
  );

  // Caso de uso para obtener la lista de Pokedex
  getIt.registerLazySingleton<GetPokedexListUsecase>(
    () => GetPokedexListUsecase(getIt<PokedexRepository>()),
  );

  // Fuente de datos local de Favoritos (SQLite)
  getIt.registerLazySingleton<FavoritesLocalDatasource>(
    () => FavoritesLocalDatasource(),
  );

  // Repositorio de Favoritos
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<FavoritesLocalDatasource>()),
  );

  // Caso de uso para obtener todos los Pokémon favoritos
  getIt.registerLazySingleton<GetAllFavoritesUsecase>(
    () => GetAllFavoritesUsecase(getIt<FavoritesRepository>()),
  );

  // Caso de uso para verificar si un Pokémon está en favoritos
  getIt.registerLazySingleton<IsFavoriteUsecase>(
    () => IsFavoriteUsecase(getIt<FavoritesRepository>()),
  );

  // Caso de uso para alternar el estado de favorito de un Pokémon
  getIt.registerLazySingleton<ToggleFavoriteUsecase>(
    () => ToggleFavoriteUsecase(getIt<FavoritesRepository>()),
  );
}
