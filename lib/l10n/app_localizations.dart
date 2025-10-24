import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @bottomNavigationBarPokedex.
  ///
  /// In en, this message translates to:
  /// **'Pokedex'**
  String get bottomNavigationBarPokedex;

  /// No description provided for @bottomNavigationBarRegions.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get bottomNavigationBarRegions;

  /// No description provided for @bottomNavigationBarFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get bottomNavigationBarFavorites;

  /// No description provided for @bottomNavigationBarProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavigationBarProfile;

  /// No description provided for @noConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get noConnectionTitle;

  /// No description provided for @noConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get noConnectionMessage;

  /// No description provided for @onboardingInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong...'**
  String get onboardingInformationTitle;

  /// No description provided for @onboardingInformationDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the information at this time. Please check your connection or try again later.'**
  String get onboardingInformationDescription;

  /// No description provided for @onboardingInformationRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get onboardingInformationRetryButton;

  /// No description provided for @onboardingTittle01.
  ///
  /// In en, this message translates to:
  /// **'All Pokémon in one place'**
  String get onboardingTittle01;

  /// No description provided for @onboardingDescription01.
  ///
  /// In en, this message translates to:
  /// **'Access an extensive list of Pokémon from every generation created by Nintendo.'**
  String get onboardingDescription01;

  /// No description provided for @onboardingContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinueButton;

  /// No description provided for @onboardingTittle02.
  ///
  /// In en, this message translates to:
  /// **'Keep your Pokédex up to date'**
  String get onboardingTittle02;

  /// No description provided for @onboardingDescription02.
  ///
  /// In en, this message translates to:
  /// **'Sign up to save your profile, favorite Pokémon, settings, and much more within the app.'**
  String get onboardingDescription02;

  /// No description provided for @onboardingStartButton.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get onboardingStartButton;

  /// No description provided for @pokemonTypeBug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get pokemonTypeBug;

  /// No description provided for @pokemonTypeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get pokemonTypeDark;

  /// No description provided for @pokemonTypeDragon.
  ///
  /// In en, this message translates to:
  /// **'Dragon'**
  String get pokemonTypeDragon;

  /// No description provided for @pokemonTypeElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get pokemonTypeElectric;

  /// No description provided for @pokemonTypeFairy.
  ///
  /// In en, this message translates to:
  /// **'Fairy'**
  String get pokemonTypeFairy;

  /// No description provided for @pokemonTypeFighting.
  ///
  /// In en, this message translates to:
  /// **'Fighting'**
  String get pokemonTypeFighting;

  /// No description provided for @pokemonTypeFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get pokemonTypeFire;

  /// No description provided for @pokemonTypeFlying.
  ///
  /// In en, this message translates to:
  /// **'Flying'**
  String get pokemonTypeFlying;

  /// No description provided for @pokemonTypeGhost.
  ///
  /// In en, this message translates to:
  /// **'Ghost'**
  String get pokemonTypeGhost;

  /// No description provided for @pokemonTypeGrass.
  ///
  /// In en, this message translates to:
  /// **'Grass'**
  String get pokemonTypeGrass;

  /// No description provided for @pokemonTypeGround.
  ///
  /// In en, this message translates to:
  /// **'Ground'**
  String get pokemonTypeGround;

  /// No description provided for @pokemonTypeIce.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get pokemonTypeIce;

  /// No description provided for @pokemonTypeNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get pokemonTypeNormal;

  /// No description provided for @pokemonTypePoison.
  ///
  /// In en, this message translates to:
  /// **'Poison'**
  String get pokemonTypePoison;

  /// No description provided for @pokemonTypePsychic.
  ///
  /// In en, this message translates to:
  /// **'Psychic'**
  String get pokemonTypePsychic;

  /// No description provided for @pokemonTypeRock.
  ///
  /// In en, this message translates to:
  /// **'Rock'**
  String get pokemonTypeRock;

  /// No description provided for @pokemonTypeSteel.
  ///
  /// In en, this message translates to:
  /// **'Steel'**
  String get pokemonTypeSteel;

  /// No description provided for @pokemonTypeWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get pokemonTypeWater;

  /// No description provided for @profileGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileGuest;

  /// No description provided for @regionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon!'**
  String get regionsTitle;

  /// No description provided for @regionsDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'re working hard to bring you this section. Please check back later to discover all the latest updates.'**
  String get regionsDescription;

  /// No description provided for @splashText.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get splashText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
