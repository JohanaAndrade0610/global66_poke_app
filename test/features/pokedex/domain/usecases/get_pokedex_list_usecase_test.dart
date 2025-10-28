// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/pokedex/domain/usecases/get_pokedex_list_usecase.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokedex_entity.dart';
import 'package:global66_poke_app/features/pokedex/domain/repositories/pokedex_repository.dart';
import 'get_pokedex_list_usecase_test.mocks.dart';

@GenerateMocks([PokedexRepository])
void main() {
  group('GetPokedexListUsecase', () {
    late MockPokedexRepository mockRepository;
    late GetPokedexListUsecase usecase;

    setUp(() {
      mockRepository = MockPokedexRepository();
      usecase = GetPokedexListUsecase(mockRepository);
    });

    test('retorna lista de pokemones correctamente', () async {
      final pokemons = [
        PokedexEntity(id: 1, name: 'bulbasaur', imageUrl: 'img1', types: ['planta']),
        PokedexEntity(id: 2, name: 'ivysaur', imageUrl: 'img2', types: ['planta']),
      ];
      when(mockRepository.getPokedexList()).thenAnswer((_) async => pokemons);
      final result = await usecase.call();
      expect(result, isA<List<PokedexEntity>>());
      expect(result.length, 2);
      expect(result[0].name, 'bulbasaur');
    });

    test('lanza excepción si el repositorio falla', () async {
      when(mockRepository.getPokedexList()).thenThrow(Exception('error'));
      expect(() async => await usecase.call(), throwsException);
    });
  });
}
