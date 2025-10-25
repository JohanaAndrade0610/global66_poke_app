/*
 * @widget CustomAppBar
 * @description AppBar genérico con icono de volver, nombre de la ventana e icono de favoritos opcional.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Título de la ventana
  final String? title;
  // Indica si se muestra el título o no
  final bool showTitle;
  // Indica si se muestra el icono de favoritos o no
  final bool showFavoriteIcon;
  // Callback para el tap en el icono de favoritos
  final VoidCallback? onFavoriteTap;
  // Callback para el tap en el icono de volver
  final VoidCallback onBackTap;
  // Indica si el Pokémon es favorito o no
  final bool isFavorite;
  // Color del icono
  final Color? iconColor;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showTitle = true,
    this.showFavoriteIcon = false,
    this.onFavoriteTap,
    required this.onBackTap,
    this.isFavorite = false,
    this.iconColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final defaultIconColor = iconColor ?? AppColors.grey121212;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // Icono de volver
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: defaultIconColor, size: 15),
        onPressed: onBackTap,
      ),
      // Título de la pantalla
      centerTitle: true,
      title: showTitle && title != null
          ? Text(title!, style: AppTextStyles.textPoppins16SemiBold121212)
          : null,
      actions: [
        // Icono de favoritos
        if (showFavoriteIcon)
          IconButton(
            icon: SvgPicture.asset(
              'assets/common/favorites/favorites_icon.svg',
              color: isFavorite ? AppColors.redCD3131 : AppColors.greyE0E0E0,
              height: 24,
            ),
            onPressed: onFavoriteTap,
          ),
      ],
    );
  }
}
