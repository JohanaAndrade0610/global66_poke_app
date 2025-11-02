// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'package:global66_poke_app/features/pokedex/data/datasource/pokedex_remote_datasource.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokedex_entity.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokemon_detail_entity.dart';
import 'pokedex_repository_impl_test.mocks.dart';

@GenerateMocks([PokedexRemoteDatasource])
void main() {
  group('PokedexRepositoryImpl', () {
    late MockPokedexRemoteDatasource mockDatasource;
    late PokedexRepositoryImpl repository;

    setUp(() {
      mockDatasource = MockPokedexRemoteDatasource();
      repository = PokedexRepositoryImpl(mockDatasource);
    });

    test('getPokedexList retorna lista de entidades correctamente', () async {
      const limit = 20;
      const offset = 0;
      final rawList = [
        {'url': 'url1'},
        {'url': 'url2'},
      ];
      final detail1 = {
        'id': 1,
        'name': 'bulbasaur',
        'sprites': {'front_default': 'img1'},
        'types': [ {'type': {'name': 'planta'}} ],
      };
      final detail2 = {
        'id': 2,
        'name': 'ivysaur',
        'sprites': {'front_default': 'img2'},
        'types': [ {'type': {'name': 'planta'}} ],
      };
      when(mockDatasource.fetchPokedexRawList(limit: limit, offset: offset))
          .thenAnswer((_) async => rawList);
      when(mockDatasource.fetchPokemonRaw('url1')).thenAnswer((_) async => detail1);
      when(mockDatasource.fetchPokemonRaw('url2')).thenAnswer((_) async => detail2);
      final result = await repository.getPokedexList(limit: limit, offset: offset);
      expect(result, isA<List<PokedexEntity>>());
      expect(result.length, 2);
      expect(result[0].name, 'bulbasaur');
      expect(result[1].name, 'ivysaur');
    });

    test('getPokemonDetail retorna entidad con datos correctos', () async {
      final speciesUrl = 'https://pokeapi.co/api/v2/pokemon-species/pikachu';
      final data = {
        'id': 25,
        'name': 'pikachu',
        'sprites': {'front_default': 'img'},
        'types': [ {'type': {'name': 'eléctrico'}} ],
        'weight': 60,
        'height': 4,
        'abilities': [ {'ability': {'name': 'static'}} ],
        // La API real entrega un objeto species con una URL; el repo usa esa URL
        'species': {'url': speciesUrl},
      };
      final typeData = {
        'damage_relations': {
          'double_damage_from': [ {'name': 'tierra'} ]
        }
      };
      final speciesData = {
        'gender_rate': 4,
        'genera': [
          {'language': {'name': 'es'}, 'genus': 'Ratón'},
          {'language': {'name': 'en'}, 'genus': 'Mouse'}
        ],
        'flavor_text_entries': [ {'language': {'name': 'es'}, 'flavor_text': 'Pokémon ratón.'} ]
      };
  when(mockDatasource.fetchPokemonRaw('pikachu')).thenAnswer((_) async => data);
      when(mockDatasource.fetchTypeRaw('eléctrico')).thenAnswer((_) async => typeData);
  // El repositorio llama con la URL completa proveniente de data['species']['url']
  when(mockDatasource.fetchSpeciesRaw(speciesUrl)).thenAnswer((_) async => speciesData);
      final result = await repository.getPokemonDetail('pikachu');
      expect(result, isA<PokemonDetailEntity>());
      expect(result.name, 'pikachu');
      expect(result.weaknesses, contains('tierra'));
      expect(result.category, 'Ratón');
      expect(result.description, contains('Pokémon ratón'));
    });
  });
}
