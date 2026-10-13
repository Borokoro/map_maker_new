import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pl.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('pl')];

  /// No description provided for @plotFinder.
  ///
  /// In pl, this message translates to:
  /// **'PlotFinder'**
  String get plotFinder;

  /// No description provided for @search.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj'**
  String get search;

  /// No description provided for @saved.
  ///
  /// In pl, this message translates to:
  /// **'Zapisane'**
  String get saved;

  /// No description provided for @sell.
  ///
  /// In pl, this message translates to:
  /// **'Sprzedaj'**
  String get sell;

  /// No description provided for @messages.
  ///
  /// In pl, this message translates to:
  /// **'Wiadomości'**
  String get messages;

  /// No description provided for @account.
  ///
  /// In pl, this message translates to:
  /// **'Konto'**
  String get account;

  /// No description provided for @searchPlaceholder.
  ///
  /// In pl, this message translates to:
  /// **'Miejscowość, gmina lub nr działki'**
  String get searchPlaceholder;

  /// No description provided for @offersLoadingError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się wczytać ofert'**
  String get offersLoadingError;

  /// No description provided for @retry.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie'**
  String get retry;

  /// No description provided for @allFilters.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie filtry'**
  String get allFilters;

  /// No description provided for @activeFilters.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, =0{Brak aktywnych filtrów} one{{count} aktywny} few{{count} aktywne} other{{count} aktywnych}}'**
  String activeFilters(int count);

  /// No description provided for @clear.
  ///
  /// In pl, this message translates to:
  /// **'Wyczyść'**
  String get clear;

  /// No description provided for @clearAll.
  ///
  /// In pl, this message translates to:
  /// **'Wyczyść wszystko'**
  String get clearAll;

  /// No description provided for @apply.
  ///
  /// In pl, this message translates to:
  /// **'Zastosuj'**
  String get apply;

  /// No description provided for @showOffers.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż oferty'**
  String get showOffers;

  /// No description provided for @location.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja'**
  String get location;

  /// No description provided for @voivodeship.
  ///
  /// In pl, this message translates to:
  /// **'Województwo'**
  String get voivodeship;

  /// No description provided for @voivodeshipPlaceholder.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie województwa'**
  String get voivodeshipPlaceholder;

  /// No description provided for @county.
  ///
  /// In pl, this message translates to:
  /// **'Powiat'**
  String get county;

  /// No description provided for @countyPlaceholder.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie powiaty'**
  String get countyPlaceholder;

  /// No description provided for @commune.
  ///
  /// In pl, this message translates to:
  /// **'Gmina'**
  String get commune;

  /// No description provided for @communePlaceholder.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie gminy'**
  String get communePlaceholder;

  /// No description provided for @pickVoivodeshipFirst.
  ///
  /// In pl, this message translates to:
  /// **'Najpierw wybierz województwo'**
  String get pickVoivodeshipFirst;

  /// No description provided for @pickCountyFirst.
  ///
  /// In pl, this message translates to:
  /// **'Najpierw wybierz powiat'**
  String get pickCountyFirst;

  /// No description provided for @price.
  ///
  /// In pl, this message translates to:
  /// **'Cena'**
  String get price;

  /// No description provided for @goodPrice.
  ///
  /// In pl, this message translates to:
  /// **'Dobra cena'**
  String get goodPrice;

  /// No description provided for @goodPriceHint.
  ///
  /// In pl, this message translates to:
  /// **'poniżej szacunku modelu'**
  String get goodPriceHint;

  /// No description provided for @area.
  ///
  /// In pl, this message translates to:
  /// **'Powierzchnia'**
  String get area;

  /// No description provided for @areaAndPlots.
  ///
  /// In pl, this message translates to:
  /// **'Powierzchnia i liczba działek'**
  String get areaAndPlots;

  /// No description provided for @plots.
  ///
  /// In pl, this message translates to:
  /// **'Liczba działek'**
  String get plots;

  /// No description provided for @plotsAny.
  ///
  /// In pl, this message translates to:
  /// **'Dowolna liczba'**
  String get plotsAny;

  /// No description provided for @plotsOne.
  ///
  /// In pl, this message translates to:
  /// **'1 działka'**
  String get plotsOne;

  /// No description provided for @plotsMany.
  ///
  /// In pl, this message translates to:
  /// **'2 i więcej'**
  String get plotsMany;

  /// No description provided for @designation.
  ///
  /// In pl, this message translates to:
  /// **'Przeznaczenie'**
  String get designation;

  /// No description provided for @designationCount.
  ///
  /// In pl, this message translates to:
  /// **'Przeznaczenie · {count}'**
  String designationCount(int count);

  /// No description provided for @planBasis.
  ///
  /// In pl, this message translates to:
  /// **'Podstawa planistyczna'**
  String get planBasis;

  /// No description provided for @media.
  ///
  /// In pl, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @mediaCount.
  ///
  /// In pl, this message translates to:
  /// **'Media · {count}'**
  String mediaCount(int count);

  /// No description provided for @access.
  ///
  /// In pl, this message translates to:
  /// **'Dojazd i teren'**
  String get access;

  /// No description provided for @roadAccess.
  ///
  /// In pl, this message translates to:
  /// **'Dostęp do drogi publicznej'**
  String get roadAccess;

  /// No description provided for @roadAccessHint.
  ///
  /// In pl, this message translates to:
  /// **'bezpośrednio lub przez służebność'**
  String get roadAccessHint;

  /// No description provided for @cityDistance.
  ///
  /// In pl, this message translates to:
  /// **'Do miasta maks.'**
  String get cityDistance;

  /// No description provided for @cityDistanceKm.
  ///
  /// In pl, this message translates to:
  /// **'{km} km'**
  String cityDistanceKm(int km);

  /// No description provided for @rangeUpTo.
  ///
  /// In pl, this message translates to:
  /// **'Do {value}'**
  String rangeUpTo(String value);

  /// No description provided for @rangeFrom.
  ///
  /// In pl, this message translates to:
  /// **'Od {value}'**
  String rangeFrom(String value);

  /// No description provided for @rangeBetween.
  ///
  /// In pl, this message translates to:
  /// **'{min} – {max}'**
  String rangeBetween(String min, String max);

  /// No description provided for @priceThousands.
  ///
  /// In pl, this message translates to:
  /// **'{value} tys. zł'**
  String priceThousands(String value);

  /// No description provided for @priceMillions.
  ///
  /// In pl, this message translates to:
  /// **'{value} mln zł'**
  String priceMillions(String value);

  /// No description provided for @areaSquareMeters.
  ///
  /// In pl, this message translates to:
  /// **'{value} m²'**
  String areaSquareMeters(String value);

  /// No description provided for @rangeNoLimit.
  ///
  /// In pl, this message translates to:
  /// **'{value}+'**
  String rangeNoLimit(String value);

  /// No description provided for @priceWithGoodPrice.
  ///
  /// In pl, this message translates to:
  /// **'{price} · {goodPrice}'**
  String priceWithGoodPrice(String price, String goodPrice);

  /// No description provided for @locationWithCount.
  ///
  /// In pl, this message translates to:
  /// **'{name} ({count})'**
  String locationWithCount(String name, int count);

  /// No description provided for @mapPriceOnRequest.
  ///
  /// In pl, this message translates to:
  /// **'Zapytaj'**
  String get mapPriceOnRequest;

  /// No description provided for @mapPriceThousands.
  ///
  /// In pl, this message translates to:
  /// **'{value}k'**
  String mapPriceThousands(String value);

  /// No description provided for @mapPriceMillions.
  ///
  /// In pl, this message translates to:
  /// **'{value} mln'**
  String mapPriceMillions(String value);

  /// No description provided for @mapClusterOffersFew.
  ///
  /// In pl, this message translates to:
  /// **' oferty'**
  String get mapClusterOffersFew;

  /// No description provided for @mapClusterOffersMany.
  ///
  /// In pl, this message translates to:
  /// **' ofert'**
  String get mapClusterOffersMany;

  /// No description provided for @offerPlotCount.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka} few{{count} działki} other{{count} działek}}'**
  String offerPlotCount(int count);

  /// No description provided for @offerNoPrice.
  ///
  /// In pl, this message translates to:
  /// **'Cena do uzgodnienia'**
  String get offerNoPrice;

  /// No description provided for @offerEstimatedPrice.
  ///
  /// In pl, this message translates to:
  /// **'ok. {range}'**
  String offerEstimatedPrice(String range);

  /// No description provided for @offerPrice.
  ///
  /// In pl, this message translates to:
  /// **'{value} zł'**
  String offerPrice(String value);

  /// No description provided for @offerPricePerMeter.
  ///
  /// In pl, this message translates to:
  /// **'{value} zł/m²'**
  String offerPricePerMeter(String value);

  /// No description provided for @offerLocation.
  ///
  /// In pl, this message translates to:
  /// **'{area} · {location}'**
  String offerLocation(String area, String location);

  /// No description provided for @offerMultiLocation.
  ///
  /// In pl, this message translates to:
  /// **'{plots} · {area} · {location}'**
  String offerMultiLocation(String plots, String area, String location);

  /// No description provided for @planDesignationResidential.
  ///
  /// In pl, this message translates to:
  /// **'Zabudowa mieszkaniowa'**
  String get planDesignationResidential;

  /// No description provided for @planDesignationResidentialServices.
  ///
  /// In pl, this message translates to:
  /// **'Mieszkaniowa z usługami'**
  String get planDesignationResidentialServices;

  /// No description provided for @planDesignationFarmstead.
  ///
  /// In pl, this message translates to:
  /// **'Zabudowa zagrodowa'**
  String get planDesignationFarmstead;

  /// No description provided for @planDesignationRecreation.
  ///
  /// In pl, this message translates to:
  /// **'Rekreacja / letniskowa'**
  String get planDesignationRecreation;

  /// No description provided for @planDesignationServices.
  ///
  /// In pl, this message translates to:
  /// **'Usługi'**
  String get planDesignationServices;

  /// No description provided for @planDesignationIndustrial.
  ///
  /// In pl, this message translates to:
  /// **'Produkcja i składy'**
  String get planDesignationIndustrial;

  /// No description provided for @planDesignationAgricultural.
  ///
  /// In pl, this message translates to:
  /// **'Rolna'**
  String get planDesignationAgricultural;

  /// No description provided for @planDesignationForest.
  ///
  /// In pl, this message translates to:
  /// **'Las'**
  String get planDesignationForest;

  /// No description provided for @planDesignationGreen.
  ///
  /// In pl, this message translates to:
  /// **'Zieleń'**
  String get planDesignationGreen;

  /// No description provided for @planDesignationWater.
  ///
  /// In pl, this message translates to:
  /// **'Wody'**
  String get planDesignationWater;

  /// No description provided for @planDesignationTransport.
  ///
  /// In pl, this message translates to:
  /// **'Komunikacja'**
  String get planDesignationTransport;

  /// No description provided for @planDesignationInfrastructure.
  ///
  /// In pl, this message translates to:
  /// **'Infrastruktura'**
  String get planDesignationInfrastructure;

  /// No description provided for @planDesignationCemetery.
  ///
  /// In pl, this message translates to:
  /// **'Cmentarz'**
  String get planDesignationCemetery;

  /// No description provided for @planDesignationOpen.
  ///
  /// In pl, this message translates to:
  /// **'Strefa otwarta'**
  String get planDesignationOpen;

  /// No description provided for @planDesignationOther.
  ///
  /// In pl, this message translates to:
  /// **'Inne'**
  String get planDesignationOther;

  /// No description provided for @planDesignationWithOthers.
  ///
  /// In pl, this message translates to:
  /// **'{designation} +{count}'**
  String planDesignationWithOthers(String designation, int count);

  /// No description provided for @planWithBasisMpzp.
  ///
  /// In pl, this message translates to:
  /// **'{designation} · MPZP'**
  String planWithBasisMpzp(String designation);

  /// No description provided for @planWithBasisPog.
  ///
  /// In pl, this message translates to:
  /// **'{designation} · plan ogólny'**
  String planWithBasisPog(String designation);

  /// No description provided for @planWithBasisPogDraft.
  ///
  /// In pl, this message translates to:
  /// **'{designation} · projekt POG'**
  String planWithBasisPogDraft(String designation);

  /// No description provided for @planWithBasisStudium.
  ///
  /// In pl, this message translates to:
  /// **'{designation} · studium'**
  String planWithBasisStudium(String designation);

  /// No description provided for @planWithBasisMixed.
  ///
  /// In pl, this message translates to:
  /// **'{designation} · różne plany'**
  String planWithBasisMixed(String designation);

  /// No description provided for @planMixedDesignationsMpzp.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia · MPZP'**
  String get planMixedDesignationsMpzp;

  /// No description provided for @planMixedDesignationsPog.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia · plan ogólny'**
  String get planMixedDesignationsPog;

  /// No description provided for @planMixedDesignationsPogDraft.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia · projekt POG'**
  String get planMixedDesignationsPogDraft;

  /// No description provided for @planMixedDesignationsStudium.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia · studium'**
  String get planMixedDesignationsStudium;

  /// No description provided for @planMixedDesignationsMixed.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia'**
  String get planMixedDesignationsMixed;

  /// No description provided for @planBasisLabelUnknown.
  ///
  /// In pl, this message translates to:
  /// **'Plan w trakcie sprawdzania'**
  String get planBasisLabelUnknown;

  /// No description provided for @planBasisLabelMpzp.
  ///
  /// In pl, this message translates to:
  /// **'MPZP — sprawdź przeznaczenie'**
  String get planBasisLabelMpzp;

  /// No description provided for @planBasisLabelPog.
  ///
  /// In pl, this message translates to:
  /// **'Plan ogólny'**
  String get planBasisLabelPog;

  /// No description provided for @planBasisLabelWz.
  ///
  /// In pl, this message translates to:
  /// **'Decyzja WZ'**
  String get planBasisLabelWz;

  /// No description provided for @planBasisLabelPogDraft.
  ///
  /// In pl, this message translates to:
  /// **'Projekt POG'**
  String get planBasisLabelPogDraft;

  /// No description provided for @planBasisLabelStudium.
  ///
  /// In pl, this message translates to:
  /// **'Studium'**
  String get planBasisLabelStudium;

  /// No description provided for @planBasisLabelNone.
  ///
  /// In pl, this message translates to:
  /// **'Brak planu'**
  String get planBasisLabelNone;

  /// No description provided for @planBasisLabelMixed.
  ///
  /// In pl, this message translates to:
  /// **'Różne przeznaczenia'**
  String get planBasisLabelMixed;

  /// No description provided for @planHintWzPossible.
  ///
  /// In pl, this message translates to:
  /// **'możliwa WZ zgodna z planem'**
  String get planHintWzPossible;

  /// No description provided for @planHintNeedsMpzp.
  ///
  /// In pl, this message translates to:
  /// **'budowa po uchwaleniu MPZP'**
  String get planHintNeedsMpzp;

  /// No description provided for @planHintCheckInfill.
  ///
  /// In pl, this message translates to:
  /// **'sprawdź obszar uzupełnienia zabudowy'**
  String get planHintCheckInfill;

  /// No description provided for @planHintNoWzWithoutPog.
  ///
  /// In pl, this message translates to:
  /// **'WZ dopiero po uchwaleniu POG'**
  String get planHintNoWzWithoutPog;

  /// No description provided for @planWithHint.
  ///
  /// In pl, this message translates to:
  /// **'{label} — {hint}'**
  String planWithHint(String label, String hint);

  /// No description provided for @designationResidential.
  ///
  /// In pl, this message translates to:
  /// **'Mieszkaniowa'**
  String get designationResidential;

  /// No description provided for @designationResidentialServices.
  ///
  /// In pl, this message translates to:
  /// **'Z usługami'**
  String get designationResidentialServices;

  /// No description provided for @designationFarmstead.
  ///
  /// In pl, this message translates to:
  /// **'Zagrodowa'**
  String get designationFarmstead;

  /// No description provided for @designationRecreation.
  ///
  /// In pl, this message translates to:
  /// **'Rekreacja'**
  String get designationRecreation;

  /// No description provided for @designationServices.
  ///
  /// In pl, this message translates to:
  /// **'Usługi'**
  String get designationServices;

  /// No description provided for @designationIndustrial.
  ///
  /// In pl, this message translates to:
  /// **'Produkcja'**
  String get designationIndustrial;

  /// No description provided for @designationAgricultural.
  ///
  /// In pl, this message translates to:
  /// **'Rolna'**
  String get designationAgricultural;

  /// No description provided for @designationForest.
  ///
  /// In pl, this message translates to:
  /// **'Las'**
  String get designationForest;

  /// No description provided for @designationOpen.
  ///
  /// In pl, this message translates to:
  /// **'Strefa otwarta'**
  String get designationOpen;

  /// No description provided for @planBasisMpzp.
  ///
  /// In pl, this message translates to:
  /// **'MPZP'**
  String get planBasisMpzp;

  /// No description provided for @planBasisPog.
  ///
  /// In pl, this message translates to:
  /// **'Plan ogólny'**
  String get planBasisPog;

  /// No description provided for @planBasisWz.
  ///
  /// In pl, this message translates to:
  /// **'Decyzja WZ'**
  String get planBasisWz;

  /// No description provided for @planBasisPogDraft.
  ///
  /// In pl, this message translates to:
  /// **'Projekt POG'**
  String get planBasisPogDraft;

  /// No description provided for @planBasisStudium.
  ///
  /// In pl, this message translates to:
  /// **'Studium'**
  String get planBasisStudium;

  /// No description provided for @planBasisNone.
  ///
  /// In pl, this message translates to:
  /// **'Brak planu'**
  String get planBasisNone;

  /// No description provided for @utilityElectricity.
  ///
  /// In pl, this message translates to:
  /// **'Prąd'**
  String get utilityElectricity;

  /// No description provided for @utilityWater.
  ///
  /// In pl, this message translates to:
  /// **'Woda'**
  String get utilityWater;

  /// No description provided for @utilitySewage.
  ///
  /// In pl, this message translates to:
  /// **'Kanalizacja'**
  String get utilitySewage;

  /// No description provided for @utilityGas.
  ///
  /// In pl, this message translates to:
  /// **'Gaz'**
  String get utilityGas;

  /// No description provided for @utilityInternet.
  ///
  /// In pl, this message translates to:
  /// **'Internet'**
  String get utilityInternet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
