/*
 * @class CustomBottomNavigationBar
 * @description Clase encargada de contener el footer de navegación en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../app_theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  // Índice del elemento seleccionado
  final int selectedIndex;
  // Función para manejar el toque en un elemento
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar modo oscuro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Fondo del footer
    final Color backgroundColor = isDark
        ? const Color(0xFF23273A)
        : const Color(0xFFFAFAFA);
    // Color del item seleccionado
    const Color selectedColor = AppColors.blue0D47A1;
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Items de navegación
    final items = [
      // Item Pokedex
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/pokedex_icon.png',
        label: l10n.bottomNavigationBarPokedex,
      ),
      // Item Regiones
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/regions_icon.png',
        label: l10n.bottomNavigationBarRegions,
      ),
      // Item Favoritos
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/favorites_icon.png',
        label: l10n.bottomNavigationBarFavorites,
      ),
      // Item Perfil
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/profile_icon.png',
        label: l10n.bottomNavigationBarProfile,
      ),
    ];

    return Container(
      width: double.infinity,
      // Diseño del contenedor del footer
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0),
            blurRadius: 16,
            offset: const Offset(0, -4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(items.length, (i) {
          final isSelected = selectedIndex == i;
          const Color customUnselectedColor = Color(0xFF424242);
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => onItemTapped(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icono del item
                    Image.asset(
                      items[i].asset,
                      width: 28,
                      height: 28,
                      color: isSelected ? selectedColor : customUnselectedColor,
                    ),
                    const SizedBox(height: 8),
                    // Nombre del item
                    MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaleFactor: 1.0),
                      child: Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? selectedColor
                              : customUnselectedColor,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Clase privada para manejar los datos de cada item del footer
class _FooterNavItemData {
  final String asset; // Ruta de la imagen del asset
  final String label; // Etiqueta del item
  const _FooterNavItemData({required this.asset, required this.label});
}
