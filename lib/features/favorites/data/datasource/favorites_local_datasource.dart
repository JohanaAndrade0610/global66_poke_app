/*
 * @class FavoritesLocalDatasource
 * @description Clase encargada de gestionar las operaciones de base de datos local (SQLite) para favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite_model.dart';

class FavoritesLocalDatasource {
  // Instancia de la base de datos
  static Database? _database;
  // Nombre de la tabla
  static const String tableName = 'favorites';

  /*
  * @method database
  * @description Obtiene la instancia de la base de datos, creándola si no existe.
  * @returns Future<Database> Instancia de la base de datos.
  */
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /*
  * @method _initDatabase
  * @description Inicializa la base de datos y crea la tabla de favoritos.
  * @returns Future<Database> Base de datos inicializada.
  */
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pokedex_favorites.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            types TEXT NOT NULL,
            addedAt INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  /*
  * @method addFavorite
  * @description Agrega un Pokémon a favoritos.
  * @param favorite - Modelo del Pokémon a agregar.
  * @returns Future<void>
  */
  Future<void> addFavorite(FavoriteModel favorite) async {
    final db = await database;
    await db.insert(
      tableName,
      favorite.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /*
  * @method removeFavorite
  * @description Elimina un Pokémon de favoritos por su ID.
  * @param pokemonId - ID del Pokémon a eliminar.
  * @returns Future<void>
  */
  Future<void> removeFavorite(int pokemonId) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [pokemonId]);
  }

  /*
  * @method getAllFavorites
  * @description Obtiene todos los Pokémon favoritos ordenados por fecha de agregado (más reciente primero).
  * @returns Future<List<FavoriteModel>> Lista de favoritos.
  */
  Future<List<FavoriteModel>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'addedAt DESC',
    );
    return maps.map((map) => FavoriteModel.fromJson(map)).toList();
  }

  /*
  * @method isFavorite
  * @description Verifica si un Pokémon está en favoritos.
  * @param pokemonId - ID del Pokémon a verificar.
  * @returns Future<bool> True si está en favoritos, false en caso contrario.
  */
  Future<bool> isFavorite(int pokemonId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [pokemonId],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  /*
  * @method clearAllFavorites
  * @description Elimina todos los favoritos de la base de datos.
  * @returns Future<void>
  */
  Future<void> clearAllFavorites() async {
    final db = await database;
    await db.delete(tableName);
  }
}
