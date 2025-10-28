import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'package:global66_poke_app/features/favorites/domain/entities/favorite_entity.dart';
import 'package:global66_poke_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'toggle_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  group('ToggleFavoriteUsecase', () {
    late MockFavoritesRepository mockRepository;
    late ToggleFavoriteUsecase usecase;

    setUp(() {
      mockRepository = MockFavoritesRepository();
      usecase = ToggleFavoriteUsecase(mockRepository);
    });

    test('agrega a favoritos si no está', () async {
      final entity = FavoriteEntity(id: 1, name: 'pikachu', imageUrl: 'img', types: ['eléctrico'], addedAt: DateTime(2025, 10, 28));
      when(mockRepository.toggleFavorite(entity)).thenAnswer((_) async => true);
      final result = await usecase(entity);
      expect(result, true);
      verify(mockRepository.toggleFavorite(entity)).called(1);
    });

    test('elimina de favoritos si ya está', () async {
      final entity = FavoriteEntity(id: 2, name: 'bulbasaur', imageUrl: 'img2', types: ['planta'], addedAt: DateTime(2025, 10, 28));
      when(mockRepository.toggleFavorite(entity)).thenAnswer((_) async => false);
      final result = await usecase(entity);
      expect(result, false);
      verify(mockRepository.toggleFavorite(entity)).called(1);
    });
  });
}
