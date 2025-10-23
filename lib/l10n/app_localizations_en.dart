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
  String get noConnectionTitle => 'Offline';

  @override
  String get noConnectionMessage => 'Please check your internet connection';

  @override
  String get onboardingInformationTitle => 'Something went wrong...';

  @override
  String get onboardingInformationDescription => 'We couldn\'t load the information at this time. Please check your connection or try again later.';

  @override
  String get onboardingInformationRetryButton => 'Retry';

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

  @override
  String get regionsTitle => 'Coming soon!';

  @override
  String get regionsDescription => 'We’re working hard to bring you this section. Please check back later to discover all the latest updates.';
}
