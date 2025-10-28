// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:global66_poke_app/di/injection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:global66_poke_app/features/pokedex/presentation/provider/pokemon_detail_provider.dart';
import 'package:global66_poke_app/features/pokedex/presentation/provider/pokemon_detail_state.dart';
import 'package:global66_poke_app/features/pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:global66_poke_app/features/pokedex/domain/usecases/get_pokemon_detail_usecase.dart';
import 'pokemon_detail_provider_test.mocks.dart';

@GenerateMocks([GetPokemonDetailUsecase])

void main() {
  group('PokemonDetailNotifier', () {
    late ProviderContainer container;
    late PokemonDetailNotifier notifier;
  late MockGetPokemonDetailUsecase mockUsecase;

    setUp(() {
      mockUsecase = MockGetPokemonDetailUsecase();
      if (getIt.isRegistered<GetPokemonDetailUsecase>()) {
        getIt.unregister<GetPokemonDetailUsecase>();
      }
      getIt.registerSingleton<GetPokemonDetailUsecase>(mockUsecase);
      container = ProviderContainer();
      notifier = container.read(pokemonDetailNotifierProvider.notifier);
    });

    test('build retorna el estado loading', () {
      expect(notifier.build(), const PokemonDetailState.loading());
    });

    test('fetchDetail pone el estado loaded en caso de éxito', () async {
      final detail = PokemonDetailEntity(
        id: 1,
        name: 'pikachu',
        imageUrl: '',
        types: ['electric'],
        weight: 60,
        height: 4,
        category: 'Mouse',
        ability: 'Static',
        maleRate: 50,
        femaleRate: 50,
        weaknesses: ['ground'],
        description: 'Electric mouse Pokémon',
      );
      when(mockUsecase.call('pikachu')).thenAnswer((_) async => detail);
      await notifier.fetchDetail('pikachu');
      expect(notifier.state, PokemonDetailState.loaded(detail));
    });

    test('fetchDetail pone el estado error en caso de fallo', () async {
      when(mockUsecase.call('pikachu')).thenThrow(Exception('error'));
      await notifier.fetchDetail('pikachu');
      expect(notifier.state, isA<PokemonDetailState>());
      notifier.state.whenOrNull(
        error: (message) => expect(message, contains('error')),
      );
    });
  });
}
