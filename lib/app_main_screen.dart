/*
 * @class MainScreen
 * @description Clase encargada de contener la pantalla principal de la aplicación con los widgets persistentes.
 * @autor Angela Andrade
 * @version 1.0 03/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends ConsumerStatefulWidget {
  // Shell persistente con BottomNavigationBar
  final StatefulNavigationShell navigationShell;
  const MainScreen({Key? key, required this.navigationShell}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // Placeholder para evitar parpadeos al cambiar de pestaña
  bool _switching = false;

  /*
    @method _onItemTapped
    @description Maneja la lógica al tocar un ítem del BottomNavigationBar, incluyendo la navegación
    @param index - Índice del ítem tocado
*/
  void _onItemTapped(int index) async {
    if (index == widget.navigationShell.currentIndex) {
      // Si es la misma pestaña, sólo resetea a su ruta inicial.
      setState(() => _switching = true);
      widget.navigationShell.goBranch(index, initialLocation: true);
      // Libera el placeholder en el próximo frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _switching = false);
      });
      return;
    }

    // Muestra placeholder para evitar parpadeos.
    setState(() => _switching = true);
    widget.navigationShell.goBranch(index, initialLocation: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _switching = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _switching
          ? Container(color: Theme.of(context).scaffoldBackgroundColor)
          : widget.navigationShell,
      // BottomNavigationBar generico de la aplicación
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
