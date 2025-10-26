/*
 * @widget InfoBoxData
 * @description Widget encargado de contener los datos informativos de un Pokémon en la ventana de detalles.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_theme.dart';

class InfoBoxData {
  // URL del icono de la caja de información.
  final String svgAsset;
  // Título de la caja de información.
  final String title;
  // Valor de la caja de información.
  final String value;

  InfoBoxData({
    required this.svgAsset,
    required this.title,
    required this.value,
  });
}

class InfoBoxGrid extends StatelessWidget {
  // Lista de elementos a mostrar en el grid.
  final List<InfoBoxData> items;
  // Número de columnas en el grid.
  final int columns;
  // Espaciado entre los elementos del grid.
  final double spacing;

  const InfoBoxGrid({
    Key? key,
    required this.items,
    this.columns = 2,
    this.spacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filas del grid
    List<Widget> rows = [];
    for (int i = 0; i < items.length; i += columns) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Columnas del grid
            for (int j = 0; j < columns; j++) ...[
              if (i + j < items.length)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Icono SVG
                          SvgPicture.asset(
                            items[i + j].svgAsset,
                            width: 12,
                            height: 12,
                            color: AppColors.grey424242,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            // Título de la caja de información
                            child: Text(
                              items[i + j].title.toUpperCase(),
                              style: AppTextStyles.textPoppins12Medium424242,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Contenedor del valor de la caja de información
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.greyE0E0E0),
                        ),
                        child: Text(
                          items[i + j].value,
                          style: AppTextStyles.textPoppins18Medium121212,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              // Espaciado entre columnas
              if (j < columns - 1) const SizedBox(width: 22),
            ],
            // Relleno si no hay suficientes elementos para completar la fila
            if ((i + columns - 1) >= items.length)
              for (int k = 0; k < (i + columns - items.length); k++)
                Expanded(child: SizedBox()),
          ],
        ),
      );
      // Espaciado entre filas
      if (i + columns < items.length) {
        rows.add(const SizedBox(height: 25));
      }
    }
    // Retorna el grid completo
    return Column(children: rows);
  }
}
