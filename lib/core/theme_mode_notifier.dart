/*
 * @class ThemeModeNotifier
 * @description Clase encargada de gestionar el estado del modo de tema de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notificador para el modo de tema (claro/oscuro)
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
// Proveedor de Riverpod para el notificador del modo de tema
final themeModeNotifierProvider = Provider<ValueNotifier<ThemeMode>>((ref) => themeModeNotifier);
