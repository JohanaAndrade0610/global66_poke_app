/*
 * @class CustomBottomNavigationBar
 * @description Clase encargada de contener el footer de navegación en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Items de navegación
    final items = [
      // Item Pokedex
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/pokedex_icon.svg',
        label: l10n.bottomNavigationBarPokedex,
      ),
      // Item Regiones
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/regions_icon.svg',
        label: l10n.bottomNavigationBarRegions,
      ),
      // Item Favoritos
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/favorites_icon.svg',
        label: l10n.bottomNavigationBarFavorites,
      ),
      // Item Perfil
      _FooterNavItemData(
        asset: 'assets/common/bottom_navigation_bar/profile_icon.svg',
        label: l10n.bottomNavigationBarProfile,
      ),
    ];

    return Container(
      width: double.infinity,
      // Diseño del contenedor del bottom navigation bar
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0),
            blurRadius: 8,
            offset: const Offset(0, -4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(items.length, (i) {
          final isSelected = selectedIndex == i;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onItemTapped(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icono del item
                    SvgPicture.asset(
                      items[i].asset,
                      width: 17,
                      height: 17,
                      color: isSelected
                          ? AppColors.blue0D47A1
                          : AppColors.grey424242,
                    ),
                    const SizedBox(height: 10),
                    // Nombre del item
                    MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaleFactor: 1.0),
                      child: Container(
                        height: 18,
                        alignment: Alignment.center,
                        child: Text(
                          items[i].label,
                          style: isSelected
                              ? AppTextStyles.textPoppinsBold0D47A1.copyWith(
                                  fontSize: 12,
                                )
                              : AppTextStyles.textPoppins14Medium424242.copyWith(
                                  fontSize: 12,
                                ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
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
