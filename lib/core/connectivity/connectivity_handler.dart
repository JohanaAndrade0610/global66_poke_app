/*
 * @class ConnectivityHandler
 * @description Clase encargada de manejar la conectividad de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'connectivity_service.dart';
import 'no_connection_screen.dart';

class ConnectivityHandler extends StatefulWidget {
  // Widget hijo que se mostrará cuando haya conexión
  final Widget child;
  // Servicio de conectividad
  final ConnectivityService service;

  const ConnectivityHandler({
    super.key,
    required this.child,
    required this.service,
  });

  @override
  State<ConnectivityHandler> createState() => _ConnectivityHandlerState();
}

class _ConnectivityHandlerState extends State<ConnectivityHandler> {
  // Suscripción al stream de conectividad
  late final StreamSubscription<bool> _sub;
  // Estado de conectividad
  bool _connected = true;

  /*
  * @method initState
  * @description Inicializa el estado del widget y la suscripción al stream de conectividad.
  */
  @override
  void initState() {
    super.initState();
    _sub = widget.service.connectionStream.listen(
      (connected) => setState(() => _connected = connected),
    );
  }

  /*
  * @method dispose
  * @description Cancela la suscripción al stream de conectividad.
  */
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Si no hay conexión, se muestra la pantalla de no conexión encima del contenido
        if (!_connected)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: const NoConnectionScreen(),
            ),
          ),
      ],
    );
  }
}
