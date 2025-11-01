/*
 * @class PaginationPolicy
 * @description Clase encargada de contener la paginación de la lista de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

abstract class PaginationPolicy {
  // Tamaño de página para la paginación
  int get pageSize;
}

class DefaultPaginationPolicy implements PaginationPolicy {
  // Tamaño de página configurable
  final int _pageSize;
  const DefaultPaginationPolicy({int pageSize = 20}) : _pageSize = pageSize;

  @override
  int get pageSize => _pageSize;
}
