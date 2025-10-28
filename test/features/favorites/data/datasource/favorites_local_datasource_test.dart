// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:global66_poke_app/features/favorites/data/datasource/favorites_local_datasource.dart';
import 'package:global66_poke_app/features/favorites/data/models/favorite_model.dart';
import 'favorites_local_datasource_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  group('FavoritesLocalDatasource', () {
    late FavoritesLocalDatasource datasource;
    late MockDatabase mockDb;

    setUp(() {
      datasource = FavoritesLocalDatasource();
      mockDb = MockDatabase();
      // Sobreescribe el getter para usar el mock en vez de la BD real
      datasource = TestableFavoritesLocalDatasource(mockDb);
    });

    test('addFavorite inserta en la base de datos', () async {
      final favorite = FavoriteModel(id: 1, name: 'pikachu', imageUrl: 'img', types: 'eléctrico', addedAt: 123);
      when(mockDb.insert(any, any, conflictAlgorithm: anyNamed('conflictAlgorithm'))).thenAnswer((_) async => 1);
      await datasource.addFavorite(favorite);
      verify(mockDb.insert(FavoritesLocalDatasource.tableName, favorite.toDb(), conflictAlgorithm: ConflictAlgorithm.replace)).called(1);
    });

    test('removeFavorite elimina por id', () async {
      when(mockDb.delete(any, where: anyNamed('where'), whereArgs: anyNamed('whereArgs'))).thenAnswer((_) async => 1);
      await datasource.removeFavorite(1);
      verify(mockDb.delete(FavoritesLocalDatasource.tableName, where: 'id = ?', whereArgs: [1])).called(1);
    });

    test('getAllFavorites retorna lista de favoritos', () async {
      final maps = [
        {'id': 1, 'name': 'pikachu', 'imageUrl': 'img', 'types': 'eléctrico', 'addedAt': 123},
        {'id': 2, 'name': 'bulbasaur', 'imageUrl': 'img2', 'types': 'planta', 'addedAt': 124},
      ];
      when(mockDb.query(any, orderBy: anyNamed('orderBy'))).thenAnswer((_) async => maps);
      final result = await datasource.getAllFavorites();
      expect(result.length, 2);
      expect(result.first.name, 'pikachu');
    });

    test('isFavorite retorna true si existe', () async {
      when(mockDb.query(any, where: anyNamed('where'), whereArgs: anyNamed('whereArgs'), limit: anyNamed('limit'))).thenAnswer((_) async => [{'id': 1}]);
      final result = await datasource.isFavorite(1);
      expect(result, true);
    });

    test('isFavorite retorna false si no existe', () async {
      when(mockDb.query(any, where: anyNamed('where'), whereArgs: anyNamed('whereArgs'), limit: anyNamed('limit'))).thenAnswer((_) async => []);
      final result = await datasource.isFavorite(1);
      expect(result, false);
    });

    test('clearAllFavorites elimina todos los favoritos', () async {
      when(mockDb.delete(any)).thenAnswer((_) async => 1);
      await datasource.clearAllFavorites();
      verify(mockDb.delete(FavoritesLocalDatasource.tableName)).called(1);
    });
  });
}

// Clase para sobreescribir el getter database y usar el mock
class TestableFavoritesLocalDatasource extends FavoritesLocalDatasource {
  final Database _mockDb;
  TestableFavoritesLocalDatasource(this._mockDb);
  @override
  Future<Database> get database async => _mockDb;
}
