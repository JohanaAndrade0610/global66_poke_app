/*
 * @class ConnectivityService
 * @description Clase encargada de manejar la conectividad de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  // Instancia de Connectivity
  final Connectivity _connectivity = Connectivity();
  // Controlador de stream para emitir cambios de conectividad
  final StreamController<bool> _controller = StreamController.broadcast();

  ConnectivityService() {
    // Verifica el estado inicial de la conectividad
    _connectivity.checkConnectivity().then((result) {
      _controller.add(_isConnected(result));
    });
    _connectivity.onConnectivityChanged.listen(
      (result) => _controller.add(_isConnected(result)),
    );
  }
  // Stream público para escuchar cambios de conectividad
  Stream<bool> get connectionStream => _controller.stream;
  // Método privado para determinar si hay conexión
  bool _isConnected(ConnectivityResult r) {
    return r != ConnectivityResult.none;
  }

  /*
  * @method dispose
  * @description Cierra el controlador de stream para evitar fugas de memoria.
  */
  void dispose() {
    _controller.close();
  }
}
