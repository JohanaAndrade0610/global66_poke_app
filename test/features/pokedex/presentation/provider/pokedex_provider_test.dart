// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/pokedex/presentation/provider/pokedex_provider.dart';
import 'package:global66_poke_app/features/pokedex/presentation/provider/pokedex_state.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokedex_entity.dart';
import 'package:global66_poke_app/features/pokedex/domain/usecases/get_pokedex_list_usecase.dart';
import 'package:global66_poke_app/di/injection.dart';
import 'pokedex_provider_test.mocks.dart';

@GenerateMocks([GetPokedexListUsecase])
void main() {
  group('PokedexNotifier', () {
    late ProviderContainer container;
    late PokedexNotifier notifier;
    late MockGetPokedexListUsecase mockUsecase;

    setUp(() {
      mockUsecase = MockGetPokedexListUsecase();
      if (getIt.isRegistered<GetPokedexListUsecase>()) {
        getIt.unregister<GetPokedexListUsecase>();
      }
      getIt.registerSingleton<GetPokedexListUsecase>(mockUsecase);
      container = ProviderContainer();
      notifier = container.read(pokedexNotifierProvider.notifier);
    });

    test('build retorna estado loaded vacío', () {
      expect(notifier.build(), const PokedexState.loaded(pokemons: []));
    });

    test('fetchPokedexList pone estado loaded con pokemones', () async {
      final pokemons = [
        PokedexEntity(id: 1, name: 'bulbasaur', imageUrl: 'img1', types: ['planta']),
        PokedexEntity(id: 2, name: 'ivysaur', imageUrl: 'img2', types: ['planta']),
      ];
      when(mockUsecase.call()).thenAnswer((_) async => pokemons);
      await notifier.fetchPokedexList();
      expect(notifier.state, PokedexState.loaded(pokemons: pokemons));
    });

    test('fetchPokedexList pone estado error si falla', () async {
      when(mockUsecase.call()).thenThrow(Exception('error'));
      await notifier.fetchPokedexList();
      notifier.state.whenOrNull(
        error: (msg) => expect(msg, contains('error')),
      );
    });

    test('updateSearchQuery filtra por nombre', () async {
      final pokemons = [
        PokedexEntity(id: 1, name: 'bulbasaur', imageUrl: 'img1', types: ['planta']),
        PokedexEntity(id: 2, name: 'ivysaur', imageUrl: 'img2', types: ['planta']),
      ];
      when(mockUsecase.call()).thenAnswer((_) async => pokemons);
      await notifier.fetchPokedexList();
      notifier.updateSearchQuery('bulba');
      notifier.state.whenOrNull(
        loaded: (filtered, query, types) {
          expect(filtered.length, 1);
          expect(filtered.first.name, 'bulbasaur');
        },
      );
    });

    test('updateSelectedTypes filtra por tipo', () async {
      final pokemons = [
        PokedexEntity(id: 1, name: 'bulbasaur', imageUrl: 'img1', types: ['planta']),
        PokedexEntity(id: 2, name: 'charmander', imageUrl: 'img2', types: ['fuego']),
      ];
      when(mockUsecase.call()).thenAnswer((_) async => pokemons);
      await notifier.fetchPokedexList();
      notifier.updateSelectedTypes(['fuego']);
      notifier.state.whenOrNull(
        loaded: (filtered, query, types) {
          expect(filtered.length, 1);
          expect(filtered.first.name, 'charmander');
        },
      );
    });
  });
}
