// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bottomNavigationBarPokedex => 'Pokedex';

  @override
  String get bottomNavigationBarRegions => 'Regions';

  @override
  String get bottomNavigationBarFavorites => 'Favorites';

  @override
  String get bottomNavigationBarProfile => 'Profile';

  @override
  String get onboardingTittle01 => 'All Pokémon in one place';

  @override
  String get onboardingDescription01 => 'Access an extensive list of Pokémon from every generation created by Nintendo.';

  @override
  String get onboardingContinueButton => 'Continue';

  @override
  String get onboardingTittle02 => 'Keep your Pokédex up to date';

  @override
  String get onboardingDescription02 => 'Sign up to save your profile, favorite Pokémon, settings, and much more within the app.';

  @override
  String get onboardingStartButton => 'Let\'s get started';
}
