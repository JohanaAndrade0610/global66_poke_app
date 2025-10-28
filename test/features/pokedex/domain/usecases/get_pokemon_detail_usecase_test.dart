// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/pokedex/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:global66_poke_app/features/pokedex/domain/repositories/pokedex_repository.dart';
import 'get_pokemon_detail_usecase_test.mocks.dart';

@GenerateMocks([PokedexRepository])
void main() {
  group('GetPokemonDetailUsecase', () {
    late MockPokedexRepository mockRepository;
    late GetPokemonDetailUsecase usecase;

    setUp(() {
      mockRepository = MockPokedexRepository();
      usecase = GetPokemonDetailUsecase(mockRepository);
    });

    test('retorna detalle de pokemon correctamente', () async {
      final detail = PokemonDetailEntity(
        id: 25,
        name: 'pikachu',
        imageUrl: 'img',
        types: ['eléctrico'],
        weight: 6.0,
        height: 0.4,
        category: 'Ratón',
        ability: 'static',
        maleRate: 50,
        femaleRate: 50,
        weaknesses: ['tierra'],
        description: 'Pokémon ratón.'
      );
      when(mockRepository.getPokemonDetail('pikachu')).thenAnswer((_) async => detail);
      final result = await usecase.call('pikachu');
      expect(result, isA<PokemonDetailEntity>());
      expect(result.name, 'pikachu');
      expect(result.weaknesses, contains('tierra'));
    });

    test('lanza excepción si el repositorio falla', () async {
      when(mockRepository.getPokemonDetail('pikachu')).thenThrow(Exception('error'));
      expect(() async => await usecase.call('pikachu'), throwsException);
    });
  });
}
