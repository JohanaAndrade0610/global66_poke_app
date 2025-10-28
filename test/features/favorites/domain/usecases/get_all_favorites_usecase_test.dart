import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import 'package:global66_poke_app/features/favorites/domain/entities/favorite_entity.dart';
import 'package:global66_poke_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'get_all_favorites_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  group('GetAllFavoritesUsecase', () {
    late MockFavoritesRepository mockRepository;
    late GetAllFavoritesUsecase usecase;

    setUp(() {
      mockRepository = MockFavoritesRepository();
      usecase = GetAllFavoritesUsecase(mockRepository);
    });

    test('retorna lista de favoritos correctamente', () async {
      final favorites = [
        FavoriteEntity(id: 1, name: 'pikachu', imageUrl: 'img', types: ['eléctrico'], addedAt: DateTime(2025, 10, 28)),
        FavoriteEntity(id: 2, name: 'bulbasaur', imageUrl: 'img2', types: ['planta'], addedAt: DateTime(2025, 10, 28)),
      ];
      when(mockRepository.getAllFavorites()).thenAnswer((_) async => favorites);
      final result = await usecase();
      expect(result, favorites);
      verify(mockRepository.getAllFavorites()).called(1);
    });

    test('retorna lista vacía si no hay favoritos', () async {
      when(mockRepository.getAllFavorites()).thenAnswer((_) async => []);
      final result = await usecase();
      expect(result, isEmpty);
      verify(mockRepository.getAllFavorites()).called(1);
    });
  });
}
