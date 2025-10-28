import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/favorites/domain/usecases/is_favorite_usecase.dart';
import 'package:global66_poke_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'is_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  group('IsFavoriteUsecase', () {
    late MockFavoritesRepository mockRepository;
    late IsFavoriteUsecase usecase;

    setUp(() {
      mockRepository = MockFavoritesRepository();
      usecase = IsFavoriteUsecase(mockRepository);
    });

    test('retorna true si el Pokémon está en favoritos', () async {
      when(mockRepository.isFavorite(1)).thenAnswer((_) async => true);
      final result = await usecase(1);
      expect(result, true);
      verify(mockRepository.isFavorite(1)).called(1);
    });

    test('retorna false si el Pokémon no está en favoritos', () async {
      when(mockRepository.isFavorite(2)).thenAnswer((_) async => false);
      final result = await usecase(2);
      expect(result, false);
      verify(mockRepository.isFavorite(2)).called(1);
    });
  });
}
