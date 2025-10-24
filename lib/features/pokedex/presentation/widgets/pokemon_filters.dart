/*
 * @widget PokedexFilters
 * @description Widget que combina el campo de búsqueda y el filtro de tipos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Creación del widget de búsqueda y filtro.
 */

import 'package:flutter/material.dart';
import 'pokedex_search_field.dart';
import 'pokedex_type_filter.dart';

class PokedexFilters extends StatelessWidget {
  // Callback cuando cambia el texto de búsqueda
  final Function(String) onSearchChanged;
  // Callback cuando se seleccionan tipos para filtrar
  final Function(List<String>) onTypesSelected;
  // Query de búsqueda actual
  final String searchQuery;
  // Tipos seleccionados actualmente
  final List<String> selectedTypes;

  const PokedexFilters({
    Key? key,
    required this.onSearchChanged,
    required this.onTypesSelected,
    this.searchQuery = '',
    this.selectedTypes = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              // Barra de búsqueda
              Expanded(
                child: PokedexSearchField(
                  searchQuery: searchQuery,
                  onSearchChanged: onSearchChanged,
                ),
              ),
              const SizedBox(width: 8),
              // Filtro de tipos
              PokedexTypeFilter(
                selectedTypes: selectedTypes,
                onTypesSelected: onTypesSelected,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
