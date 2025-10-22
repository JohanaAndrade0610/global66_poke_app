/*
 * @class CustomLoading
 * @description Clase encargada de contener el widget de carga personalizado para la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  // Color de fondo del overlay de carga
  final Color backgroundColor;
  // Color del indicador de carga
  final Color indicatorColor;

  const CustomLoading({
    Key? key,
    this.backgroundColor = const Color(0x80000000),
    this.indicatorColor = const Color(0xFF0047FF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(child: CircularProgressIndicator(color: indicatorColor)),
    );
  }
}
