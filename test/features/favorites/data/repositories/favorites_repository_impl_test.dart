// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:global66_poke_app/features/favorites/data/datasource/favorites_local_datasource.dart';
import 'package:global66_poke_app/features/favorites/data/models/favorite_model.dart';
import 'package:global66_poke_app/features/favorites/domain/entities/favorite_entity.dart';
import 'favorites_repository_impl_test.mocks.dart';

@GenerateMocks([FavoritesLocalDatasource])
void main() {
  group('FavoritesRepositoryImpl', () {
    late MockFavoritesLocalDatasource mockDatasource;
    late FavoritesRepositoryImpl repository;

    setUp(() {
      mockDatasource = MockFavoritesLocalDatasource();
      repository = FavoritesRepositoryImpl(mockDatasource);
    });

    test('addFavorite llama a addFavorite en el datasource', () async {
  final entity = FavoriteEntity(id: 1, name: 'pikachu', imageUrl: 'img', types: ['eléctrico'], addedAt: DateTime(2025, 10, 28));
      when(mockDatasource.addFavorite(any)).thenAnswer((_) async => null);
      await repository.addFavorite(entity);
      verify(mockDatasource.addFavorite(entity.toModel())).called(1);
    });

    test('removeFavorite llama a removeFavorite en el datasource', () async {
      when(mockDatasource.removeFavorite(any)).thenAnswer((_) async => null);
      await repository.removeFavorite(1);
      verify(mockDatasource.removeFavorite(1)).called(1);
    });

    test('getAllFavorites retorna lista de entidades', () async {
      final models = [
        FavoriteModel(id: 1, name: 'pikachu', imageUrl: 'img', types: 'eléctrico', addedAt: 123),
        FavoriteModel(id: 2, name: 'bulbasaur', imageUrl: 'img2', types: 'planta', addedAt: 124),
      ];
      when(mockDatasource.getAllFavorites()).thenAnswer((_) async => models);
      final result = await repository.getAllFavorites();
      expect(result.length, 2);
      expect(result.first.name, 'pikachu');
    });

    test('isFavorite retorna true si existe', () async {
      when(mockDatasource.isFavorite(1)).thenAnswer((_) async => true);
      final result = await repository.isFavorite(1);
      expect(result, true);
    });

    test('isFavorite retorna false si no existe', () async {
      when(mockDatasource.isFavorite(1)).thenAnswer((_) async => false);
      final result = await repository.isFavorite(1);
      expect(result, false);
    });

    test('toggleFavorite elimina si ya es favorito', () async {
  final entity = FavoriteEntity(id: 1, name: 'pikachu', imageUrl: 'img', types: ['eléctrico'], addedAt: DateTime(2025, 10, 28));
      when(mockDatasource.isFavorite(1)).thenAnswer((_) async => true);
      when(mockDatasource.removeFavorite(1)).thenAnswer((_) async => null);
      final result = await repository.toggleFavorite(entity);
      expect(result, false);
      verify(mockDatasource.removeFavorite(1)).called(1);
    });

    test('toggleFavorite agrega si no es favorito', () async {
  final entity = FavoriteEntity(id: 2, name: 'bulbasaur', imageUrl: 'img2', types: ['planta'], addedAt: DateTime(2025, 10, 28));
      when(mockDatasource.isFavorite(2)).thenAnswer((_) async => false);
      when(mockDatasource.addFavorite(any)).thenAnswer((_) async => null);
      final result = await repository.toggleFavorite(entity);
      expect(result, true);
      verify(mockDatasource.addFavorite(entity.toModel())).called(1);
    });
  });
}
