// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:global66_poke_app/features/pokedex/data/datasource/pokedex_remote_datasource.dart';
import 'package:global66_poke_app/core/config.dart';
import 'pokedex_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('PokedexRemoteDatasource', () {
    late MockDio mockDio;
    late PokedexRemoteDatasource datasource;

    setUp(() {
      mockDio = MockDio();
      datasource = PokedexRemoteDatasource(mockDio);
    });

  test('fetchPokedexRawList llama la URL correcta y parsea los resultados', () async {
      const limit = 20;
      const offset = 0;
      final url = '${AppConfig.pokeApiBaseUrl}/pokemon?limit=$limit&offset=$offset';
      final mockResponse = Response(
        data: {'results': [ {'name': 'bulbasaur', 'url': 'url1'} ]},
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
      when(mockDio.get(url)).thenAnswer((_) async => mockResponse);
      final result = await datasource.fetchPokedexRawList(limit: limit, offset: offset);
      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.first['name'], 'bulbasaur');
    });

  test('fetchPokemonRaw llama la URL correcta y retorna los datos', () async {
      final url = '${AppConfig.pokeApiBaseUrl}/pokemon/pikachu';
      final mockResponse = Response(
        data: {'id': 25, 'name': 'pikachu'},
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
      when(mockDio.get(url)).thenAnswer((_) async => mockResponse);
      final result = await datasource.fetchPokemonRaw('pikachu');
      expect(result['name'], 'pikachu');
    });

  test('fetchTypeRaw llama la URL correcta y retorna los datos', () async {
      final url = '${AppConfig.pokeApiBaseUrl}/type/electric';
      final mockResponse = Response(
        data: {'name': 'electric'},
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
      when(mockDio.get(url)).thenAnswer((_) async => mockResponse);
      final result = await datasource.fetchTypeRaw('electric');
      expect(result['name'], 'electric');
    });

  test('fetchSpeciesRaw llama la URL correcta y retorna los datos', () async {
      final url = '${AppConfig.pokeApiBaseUrl}/pokemon-species/pikachu';
      final mockResponse = Response(
        data: {'name': 'pikachu'},
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
      when(mockDio.get(url)).thenAnswer((_) async => mockResponse);
      final result = await datasource.fetchSpeciesRaw('pikachu');
      expect(result['name'], 'pikachu');
    });

  test('fetchPokemonRaw usa la url si comienza con https', () async {
      final url = 'https://pokeapi.co/api/v2/pokemon/25';
      final mockResponse = Response(
        data: {'id': 25, 'name': 'pikachu'},
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
      when(mockDio.get(url)).thenAnswer((_) async => mockResponse);
      final result = await datasource.fetchPokemonRaw(url);
      expect(result['id'], 25);
    });
  });
}
