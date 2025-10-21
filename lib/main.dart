/*
 * @class Main
 * @description Clase encargada de iniciar la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injection.dart';

void main() {
  // Asegurar que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar inyección de dependencias
  init();
  // Ejecutar la aplicación
  runApp(const App());
}
