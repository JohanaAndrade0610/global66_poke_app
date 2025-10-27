/*
 * @class RoundedSelector
 * @description Clase encargada de mostrar un selector con dos opciones.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RoundedSelector<T> extends StatelessWidget {
  // Opciones disponibles
  final List<T> options;
  // Opción actualmente seleccionada
  final T selected;
  // Función llamada al cambiar la selección
  final void Function(T) onChanged;
  // Widgets hijos (íconos y textos)
  final List<Widget> children;

  /// Color fijo para íconos y texto
  final Color foregroundColor;

  // Valores estándar
  static const double _borderRadius = 20.0;
  static const double _height = 40.0;
  static const Color _selectedColor = Color(0xFFf5cf0e);
  static const Color _unselectedColor = AppColors.greyEEEEEE;

  const RoundedSelector({
    Key? key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.children,
    this.foregroundColor = AppColors.grey616161,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Número de opciones
    final int itemCount = options.length;
    // Retornar un SizedBox vacío si no hay opciones
    if (itemCount == 0) {
      return const SizedBox(height: _height);
    }
    // Índice de la opción seleccionada
    final selectedIndex = options.indexOf(selected).clamp(0, itemCount - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ancho total del widget
        final totalWidth = constraints.maxWidth;
        // Ancho de cada item
        final itemWidth = totalWidth / itemCount;

        return Container(
          height: _height,
          // Diseño del contenedor principal
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: _unselectedColor,
          ),
          child: Stack(
            children: [
              // Fondo del elemento seleccionado
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
                alignment: Alignment(
                  (selectedIndex * 2 / (itemCount - 1)) - 1,
                  0,
                ),
                child: Container(
                  width: itemWidth * 1.1,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _selectedColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                ),
              ),
              // Opciones
              Row(
                children: List.generate(itemCount, (i) {
                  final bool isSelected = i == selectedIndex;
                  final Color itemColor = isSelected
                      ? foregroundColor
                      : AppColors.greyBDBDBD; // Opción no seleccionada
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(options[i]),
                      child: Container(
                        height: _height,
                        alignment: Alignment.center,
                        // Iconos correspondientes
                        child: IconTheme(
                          data: IconThemeData(color: itemColor, size: 18),
                          child: DefaultTextStyle(
                            // Texto correspondientes
                            style: TextStyle(
                              color: itemColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            child: children[i],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
