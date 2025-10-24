/*
 * @widget PokedexTypeFilter
 * @description Widget para filtrar un Pokémon por tipo.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Creación del widget de filtro por tipos.
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import 'pokedex_type_filter_card.dart';

class PokedexTypeFilter extends StatefulWidget {
  // Callback cuando se seleccionan tipos para filtrar
  final Function(List<String>) onTypesSelected;
  // Tipos seleccionados actualmente
  final List<String> selectedTypes;

  const PokedexTypeFilter({
    Key? key,
    required this.onTypesSelected,
    this.selectedTypes = const [],
  }) : super(key: key);

  @override
  State<PokedexTypeFilter> createState() => _PokedexTypeFilterState();
}

class _PokedexTypeFilterState extends State<PokedexTypeFilter> {
  // Lista temporal de tipos seleccionados mientras el modal está abierto
  List<String> _tempSelectedTypes = [];
  // Controla si el card de tipos está expandido
  bool _isTypeCardExpanded = false;
  // Lista de todos los tipos de Pokémon disponibles
  List<String> get _allTypes => PokemonTypeColors.typeColors.keys.toList();

  /*
  * @method _showFilterModal
  * @description Muestra el modal de filtros ubicado en la parte inferior.
  */
  void _showFilterModal() {
    setState(() {
      _tempSelectedTypes = List<String>.from(widget.selectedTypes);
      _isTypeCardExpanded = false;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterModal(),
    );
  }

  /*
  * @method _toggleType
  * @description Agrega o quita un tipo de la lista temporal de tipos seleccionados.
  */
  void _toggleType(String type) {
    if (_tempSelectedTypes.contains(type)) {
      _tempSelectedTypes.remove(type);
    } else {
      _tempSelectedTypes.add(type);
    }
  }

  /*
  * @method _applyFilters
  * @description Aplica los filtros seleccionados y cierra el modal.
  */
  void _applyFilters() {
    widget.onTypesSelected(_tempSelectedTypes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Diseño del botón del filtro
    return GestureDetector(
      onTap: _showFilterModal,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.whiteFFFFFF,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.greyE0E0E0, width: 1.5),
        ),
        child: Icon(Icons.filter_list, color: AppColors.grey757575, size: 24),
      ),
    );
  }

  /*
  * @method _buildFilterModal
  * @description Construye el modal de filtros ubicado en la parte inferior.
  */
  Widget _buildFilterModal() {
    // Internacionalización de los textos del modal
    final l10n = AppLocalizations.of(context)!;
    // Obtener la altura de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (context, setModalState) {
        // El contenedor ocupa el 80% de la altura de la pantalla
        return Container(
          constraints: BoxConstraints(maxHeight: screenHeight * 0.8),
          decoration: const BoxDecoration(
            color: AppColors.whiteFFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Botón de cerrar modal
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        color: AppColors.grey424242,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    // Título "Filtra por tus preferencias"
                    Center(
                      child: Text(
                        l10n.pokedexFilterByType,
                        style: AppTextStyles.textPoppins16SemiBold121212,
                      ),
                    ),
                  ],
                ),
              ),
              // Card con los tipos de Pokémon
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      PokedexTypeFilterCard(
                        allTypes: _allTypes,
                        tempSelectedTypes: _tempSelectedTypes,
                        isTypeCardExpanded: _isTypeCardExpanded,
                        l10n: l10n,
                        setModalState: (fn) {
                          setModalState(() {
                            _isTypeCardExpanded = !_isTypeCardExpanded;
                          });
                        },
                        onToggleType: (type) {
                          setModalState(() {
                            _toggleType(type);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Botón Aplicar
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue1E88E5,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.pokedexApplyBottom,
                          style: AppTextStyles.textPoppins14SemiBoldFAFAFA,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Botón Cancelar
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greyEEEEEE,
                          foregroundColor: AppColors.grey424242,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.pokedexCancelBottom,
                          style: AppTextStyles.textPoppins14SemiBold121212,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
