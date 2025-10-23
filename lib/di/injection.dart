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
}
