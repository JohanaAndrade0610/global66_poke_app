/*
 * @class LocaleNotifier
 * @description Clase encargada de notificar cambios en la configuración regional de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notificador para la configuración regional de la aplicación
final localeNotifier = ValueNotifier<Locale>(const Locale('es'));
// Proveedor de Riverpod que expone el ValueNotifier y escucha sus cambios
final localeNotifierProvider = ChangeNotifierProvider<ValueNotifier<Locale>>((ref) => localeNotifier);
