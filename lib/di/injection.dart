/*
 * @class Injection
 * @description Clase encargada de la inyección de dependencias en la aplicación.
 * @author Angela Andrade
 * @version 1.0 21/10/2025 Creación y documentación de la clase.
 */

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Instancia de GetIt para la inyección de dependencias
final getIt = GetIt.instance;

void init() {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());
}
