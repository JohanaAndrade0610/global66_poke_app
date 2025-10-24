/*
 * @widget PokedexSearchField
 * @description Widget para filtrar un Pokémon por su nombre o por su identificador.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Creación del widget de campo de búsqueda.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class PokedexSearchField extends StatefulWidget {
  // Callback cuando cambia el texto de búsqueda
  final Function(String) onSearchChanged;
  // Query de búsqueda actual
  final String searchQuery;

  const PokedexSearchField({
    Key? key,
    required this.onSearchChanged,
    this.searchQuery = '',
  }) : super(key: key);

  @override
  State<PokedexSearchField> createState() => _PokedexSearchFieldState();
}

class _PokedexSearchFieldState extends State<PokedexSearchField> {
  // Controlador del TextField para manejar el texto ingresado
  late TextEditingController _searchController;

  /*
  * @method initState
  * @description Inicializa el controlador del TextField con el query de búsqueda actual.
  */
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  /*
  * @method dispose
  * @description Libera los recursos utilizados por el controlador del TextField.
  */
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Internacionalización de los textos
    final l10n = AppLocalizations.of(context)!;
    // Diseño del contenedor del TextField
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.whiteFFFFFF,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.greyE0E0E0, width: 1.5),
      ),
      // Campo de texto para búsqueda
      child: TextField(
        controller: _searchController,
        onChanged: widget.onSearchChanged,
        style: AppTextStyles.textPoppins14Regular424242,
        cursorColor: AppColors.grey424242,
        decoration: InputDecoration(
          hintText: l10n.pokedexSearchHint,
          hintStyle: AppTextStyles.textPoppins14Regular9E9E9E,
          // Icono de búsqueda
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              'assets/pokedex/icons/search_icon.svg',
              width: 20,
              height: 20,
            ),
          ),
          // Icono para limpiar el texto ingresado
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.grey757575,
                    size: 20,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 12,
          ),
        ),
      ),
    );
  }
}
