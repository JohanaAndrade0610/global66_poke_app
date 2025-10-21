/*
 * @class ThemeModeNotifier
 * @description Clase encargada de gestionar el estado del modo de tema de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

// Notificador para el modo de tema (claro/oscuro)
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
