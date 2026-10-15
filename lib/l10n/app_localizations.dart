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

  /// No description provided for @loginTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Zarządzaj ofertami i zapisanymi działkami.'**
  String get loginSubtitle;

  /// No description provided for @loginIdentifier.
  ///
  /// In pl, this message translates to:
  /// **'E-mail lub nazwa użytkownika'**
  String get loginIdentifier;

  /// No description provided for @password.
  ///
  /// In pl, this message translates to:
  /// **'Hasło'**
  String get password;

  /// No description provided for @loginSubmit.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się'**
  String get loginSubmit;

  /// No description provided for @showPassword.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż hasło'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In pl, this message translates to:
  /// **'Ukryj hasło'**
  String get hidePassword;

  /// No description provided for @fieldRequired.
  ///
  /// In pl, this message translates to:
  /// **'Uzupełnij to pole'**
  String get fieldRequired;

  /// No description provided for @loginInvalidCredentials.
  ///
  /// In pl, this message translates to:
  /// **'Nieprawidłowy e-mail, nazwa użytkownika lub hasło.'**
  String get loginInvalidCredentials;

  /// No description provided for @tooManyRequestsError.
  ///
  /// In pl, this message translates to:
  /// **'Zbyt wiele prób. Spróbuj ponownie później.'**
  String get tooManyRequestsError;

  /// No description provided for @networkError.
  ///
  /// In pl, this message translates to:
  /// **'Brak połączenia z internetem. Spróbuj ponownie.'**
  String get networkError;

  /// No description provided for @unknownError.
  ///
  /// In pl, this message translates to:
  /// **'Coś poszło nie tak. Spróbuj ponownie później.'**
  String get unknownError;

  /// No description provided for @loggedIn.
  ///
  /// In pl, this message translates to:
  /// **'Jesteś zalogowany'**
  String get loggedIn;

  /// No description provided for @loggedInAs.
  ///
  /// In pl, this message translates to:
  /// **'Zalogowano jako {username}'**
  String loggedInAs(String username);

  /// No description provided for @logout.
  ///
  /// In pl, this message translates to:
  /// **'Wyloguj się'**
  String get logout;

  /// No description provided for @invalidDataError.
  ///
  /// In pl, this message translates to:
  /// **'Sprawdź poprawność wprowadzonych danych.'**
  String get invalidDataError;

  /// No description provided for @invalidEmail.
  ///
  /// In pl, this message translates to:
  /// **'Podaj poprawny adres e-mail'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In pl, this message translates to:
  /// **'Hasło musi mieć co najmniej {count} znaków'**
  String passwordTooShort(int count);

  /// No description provided for @forgotPassword.
  ///
  /// In pl, this message translates to:
  /// **'Nie pamiętasz hasła?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In pl, this message translates to:
  /// **'Nie masz konta?'**
  String get noAccount;

  /// No description provided for @hasAccount.
  ///
  /// In pl, this message translates to:
  /// **'Masz już konto?'**
  String get hasAccount;

  /// No description provided for @email.
  ///
  /// In pl, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In pl, this message translates to:
  /// **'Nie pamiętasz hasła?'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Wyślemy link do ustawienia nowego hasła.'**
  String get resetPasswordSubtitle;

  /// No description provided for @resetPasswordSubmit.
  ///
  /// In pl, this message translates to:
  /// **'Wyślij link'**
  String get resetPasswordSubmit;

  /// No description provided for @resetPasswordSentTitle.
  ///
  /// In pl, this message translates to:
  /// **'Sprawdź skrzynkę'**
  String get resetPasswordSentTitle;

  /// No description provided for @resetPasswordSent.
  ///
  /// In pl, this message translates to:
  /// **'Jeśli konto z adresem {email} istnieje, wysłaliśmy na nie link do ustawienia nowego hasła. Link jest ważny przez ograniczony czas.'**
  String resetPasswordSent(String email);

  /// No description provided for @backToLogin.
  ///
  /// In pl, this message translates to:
  /// **'Wróć do logowania'**
  String get backToLogin;

  /// No description provided for @signupTitle.
  ///
  /// In pl, this message translates to:
  /// **'Załóż konto'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Konto jest bezpłatne.'**
  String get signupSubtitle;

  /// No description provided for @signupSubmit.
  ///
  /// In pl, this message translates to:
  /// **'Załóż konto'**
  String get signupSubmit;

  /// No description provided for @signupSuccess.
  ///
  /// In pl, this message translates to:
  /// **'Konto założone. Witamy w PlotFinder!'**
  String get signupSuccess;

  /// No description provided for @firstName.
  ///
  /// In pl, this message translates to:
  /// **'Imię'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In pl, this message translates to:
  /// **'Nazwisko'**
  String get lastName;

  /// No description provided for @optionalField.
  ///
  /// In pl, this message translates to:
  /// **'{field} (opcjonalnie)'**
  String optionalField(String field);

  /// No description provided for @username.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa użytkownika'**
  String get username;

  /// No description provided for @passwordRules.
  ///
  /// In pl, this message translates to:
  /// **'Minimum {count} znaków'**
  String passwordRules(int count);

  /// No description provided for @termsAcceptPrefix.
  ///
  /// In pl, this message translates to:
  /// **'Akceptuję '**
  String get termsAcceptPrefix;

  /// No description provided for @termsLink.
  ///
  /// In pl, this message translates to:
  /// **'regulamin'**
  String get termsLink;

  /// No description provided for @termsAnd.
  ///
  /// In pl, this message translates to:
  /// **' i '**
  String get termsAnd;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In pl, this message translates to:
  /// **'politykę prywatności'**
  String get privacyPolicyLink;

  /// No description provided for @termsRequired.
  ///
  /// In pl, this message translates to:
  /// **'Zaakceptuj regulamin, aby założyć konto'**
  String get termsRequired;

  /// No description provided for @termsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Regulamin'**
  String get termsTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In pl, this message translates to:
  /// **'Polityka prywatności'**
  String get privacyPolicyTitle;

  /// No description provided for @addToSaved.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj do zapisanych'**
  String get addToSaved;

  /// No description provided for @removeFromSaved.
  ///
  /// In pl, this message translates to:
  /// **'Usuń z zapisanych'**
  String get removeFromSaved;

  /// No description provided for @saveOfferError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się zaktualizować zapisanych ofert. Spróbuj ponownie.'**
  String get saveOfferError;

  /// No description provided for @savedTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zapisane działki'**
  String get savedTitle;

  /// No description provided for @savedSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Oferty oznaczone serduszkiem. Kliknij serce ponownie, aby usunąć ofertę z listy.'**
  String get savedSubtitle;

  /// No description provided for @savedCount.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} zapisana oferta} few{{count} zapisane oferty} other{{count} zapisanych ofert}}'**
  String savedCount(int count);

  /// No description provided for @savedEmptyTitle.
  ///
  /// In pl, this message translates to:
  /// **'Nie masz jeszcze zapisanych działek'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptyDescription.
  ///
  /// In pl, this message translates to:
  /// **'Kliknij serce na karcie oferty, aby wrócić do niej później.'**
  String get savedEmptyDescription;

  /// No description provided for @browseOffers.
  ///
  /// In pl, this message translates to:
  /// **'Przeglądaj oferty'**
  String get browseOffers;

  /// No description provided for @savedLoadingError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się wczytać zapisanych ofert'**
  String get savedLoadingError;

  /// No description provided for @utilityAvailable.
  ///
  /// In pl, this message translates to:
  /// **'{name}: dostępne'**
  String utilityAvailable(String name);

  /// No description provided for @utilityUnavailable.
  ///
  /// In pl, this message translates to:
  /// **'{name}: brak'**
  String utilityUnavailable(String name);

  /// No description provided for @loadMoreRetry.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się wczytać kolejnych ofert. Spróbuj ponownie'**
  String get loadMoreRetry;

  /// No description provided for @offerCopyLink.
  ///
  /// In pl, this message translates to:
  /// **'Kopiuj link do oferty'**
  String get offerCopyLink;

  /// No description provided for @offerLinkCopied.
  ///
  /// In pl, this message translates to:
  /// **'Skopiowano link do oferty'**
  String get offerLinkCopied;

  /// No description provided for @offerLoadingError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się wczytać oferty.'**
  String get offerLoadingError;

  /// No description provided for @offerNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleźliśmy tej oferty'**
  String get offerNotFound;

  /// No description provided for @offerNotFoundHint.
  ///
  /// In pl, this message translates to:
  /// **'Oferta mogła zostać sprzedana albo wycofana przez sprzedającego.'**
  String get offerNotFoundHint;

  /// No description provided for @offerFallbackTitle.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{Działka budowlana} few{{count} działki budowlane} other{{count} działek budowlanych}}'**
  String offerFallbackTitle(int count);

  /// No description provided for @offerTitleWithArea.
  ///
  /// In pl, this message translates to:
  /// **'{title} · {area}'**
  String offerTitleWithArea(String title, String area);

  /// No description provided for @offerPlotsTogether.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka} few{{count} sąsiednie działki sprzedawane razem} other{{count} sąsiednich działek sprzedawanych razem}}'**
  String offerPlotsTogether(int count);

  /// No description provided for @offerPlotsSeparately.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka} few{{count} działki — każdą można kupić osobno} other{{count} działek — każdą można kupić osobno}}'**
  String offerPlotsSeparately(int count);

  /// No description provided for @offerPhotoCounter.
  ///
  /// In pl, this message translates to:
  /// **'{index} / {total}'**
  String offerPhotoCounter(int index, int total);

  /// No description provided for @offerPhotoTakenOnPlot.
  ///
  /// In pl, this message translates to:
  /// **'Zrobione na działce'**
  String get offerPhotoTakenOnPlot;

  /// No description provided for @offerPhotoTakenOnPlotDate.
  ///
  /// In pl, this message translates to:
  /// **'Zrobione na działce · {date}'**
  String offerPhotoTakenOnPlotDate(String date);

  /// No description provided for @offerMapLabelMany.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka · {area}} few{{count} działki · {area}} other{{count} działek · {area}}}'**
  String offerMapLabelMany(int count, String area);

  /// No description provided for @offerNumbersOverline.
  ///
  /// In pl, this message translates to:
  /// **'W skrócie'**
  String get offerNumbersOverline;

  /// No description provided for @offerNumbersTitle.
  ///
  /// In pl, this message translates to:
  /// **'Najważniejsze liczby'**
  String get offerNumbersTitle;

  /// No description provided for @offerNumbersTotalArea.
  ///
  /// In pl, this message translates to:
  /// **'łączna powierzchnia'**
  String get offerNumbersTotalArea;

  /// No description provided for @offerNumbersPricePerMeter.
  ///
  /// In pl, this message translates to:
  /// **'cena za m²'**
  String get offerNumbersPricePerMeter;

  /// No description provided for @offerNumbersPlots.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{działka w ofercie} few{działki w ofercie} other{działek w ofercie}}'**
  String offerNumbersPlots(int count);

  /// No description provided for @offerNumbersPlanSymbol.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{symbol planu} few{symbole planu} other{symboli planu}}'**
  String offerNumbersPlanSymbol(int count);

  /// No description provided for @offerNumbersPogSymbol.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{strefa planu ogólnego} few{strefy planu ogólnego} other{stref planu ogólnego}}'**
  String offerNumbersPogSymbol(int count);

  /// No description provided for @offerEmptyValue.
  ///
  /// In pl, this message translates to:
  /// **'—'**
  String get offerEmptyValue;

  /// No description provided for @offerPriceTitle.
  ///
  /// In pl, this message translates to:
  /// **'Cena'**
  String get offerPriceTitle;

  /// No description provided for @offerPriceNegotiable.
  ///
  /// In pl, this message translates to:
  /// **'Do negocjacji'**
  String get offerPriceNegotiable;

  /// No description provided for @offerPriceFixed.
  ///
  /// In pl, this message translates to:
  /// **'Cena stała'**
  String get offerPriceFixed;

  /// No description provided for @offerPriceEstimateHint.
  ///
  /// In pl, this message translates to:
  /// **'Sprzedający nie podał ceny. To szacunkowa wartość według modelu PlotFinder, liczona z transakcji działek w okolicy.'**
  String get offerPriceEstimateHint;

  /// No description provided for @offerShowValuation.
  ///
  /// In pl, this message translates to:
  /// **'Zobacz szacunek PlotFinder'**
  String get offerShowValuation;

  /// No description provided for @offerHideValuation.
  ///
  /// In pl, this message translates to:
  /// **'Ukryj szacunek'**
  String get offerHideValuation;

  /// No description provided for @offerPricePerMeterWithArea.
  ///
  /// In pl, this message translates to:
  /// **'{perMeter} · {area}'**
  String offerPricePerMeterWithArea(String perMeter, String area);

  /// No description provided for @offerPriceSeparately.
  ///
  /// In pl, this message translates to:
  /// **'Ceny działek kupowanych osobno'**
  String get offerPriceSeparately;

  /// No description provided for @offerPriceNote.
  ///
  /// In pl, this message translates to:
  /// **'Cena podana przez sprzedającego. Kupujesz bezpośrednio, bez prowizji.'**
  String get offerPriceNote;

  /// No description provided for @offerValuationTitle.
  ///
  /// In pl, this message translates to:
  /// **'Ocena ceny'**
  String get offerValuationTitle;

  /// No description provided for @offerValuationVerdictBelow.
  ///
  /// In pl, this message translates to:
  /// **'Dobra cena'**
  String get offerValuationVerdictBelow;

  /// No description provided for @offerValuationVerdictMarket.
  ///
  /// In pl, this message translates to:
  /// **'Cena rynkowa'**
  String get offerValuationVerdictMarket;

  /// No description provided for @offerValuationVerdictAbove.
  ///
  /// In pl, this message translates to:
  /// **'Powyżej rynku'**
  String get offerValuationVerdictAbove;

  /// No description provided for @offerValuationEstimate.
  ///
  /// In pl, this message translates to:
  /// **'Szacunek: {range}'**
  String offerValuationEstimate(String range);

  /// No description provided for @offerValuationPerMeter.
  ///
  /// In pl, this message translates to:
  /// **'{range} dla podobnych działek w okolicy.'**
  String offerValuationPerMeter(String range);

  /// No description provided for @offerValuationPositionBelow.
  ///
  /// In pl, this message translates to:
  /// **'Ta oferta jest poniżej przedziału.'**
  String get offerValuationPositionBelow;

  /// No description provided for @offerValuationPositionMarket.
  ///
  /// In pl, this message translates to:
  /// **'Ta oferta jest w środku przedziału.'**
  String get offerValuationPositionMarket;

  /// No description provided for @offerValuationPositionAbove.
  ///
  /// In pl, this message translates to:
  /// **'Ta oferta jest powyżej przedziału.'**
  String get offerValuationPositionAbove;

  /// No description provided for @offerValuationMarker.
  ///
  /// In pl, this message translates to:
  /// **'Ta oferta {price}'**
  String offerValuationMarker(String price);

  /// No description provided for @offerValuationNote.
  ///
  /// In pl, this message translates to:
  /// **'Szacunek modelu na podstawie podobnych działek, nie operat rzeczoznawcy.'**
  String get offerValuationNote;

  /// No description provided for @offerBuildOverline.
  ///
  /// In pl, this message translates to:
  /// **'Analiza PlotFinder'**
  String get offerBuildOverline;

  /// No description provided for @offerBuildTitle.
  ///
  /// In pl, this message translates to:
  /// **'Co możesz tu zbudować'**
  String get offerBuildTitle;

  /// No description provided for @offerBuildHeading.
  ///
  /// In pl, this message translates to:
  /// **'Przeznaczenie: {label}'**
  String offerBuildHeading(String label);

  /// No description provided for @offerBuildHintWzPossible.
  ///
  /// In pl, this message translates to:
  /// **'Działka leży w obszarze uzupełnienia zabudowy planu ogólnego — można wystąpić o decyzję o warunkach zabudowy zgodną z planem ogólnym.'**
  String get offerBuildHintWzPossible;

  /// No description provided for @offerBuildHintNeedsMpzp.
  ///
  /// In pl, this message translates to:
  /// **'Działka leży poza obszarem uzupełnienia zabudowy — decyzji o warunkach zabudowy nie można wydać, nowa zabudowa będzie możliwa po uchwaleniu planu miejscowego.'**
  String get offerBuildHintNeedsMpzp;

  /// No description provided for @offerBuildHintCheckInfill.
  ///
  /// In pl, this message translates to:
  /// **'Plan ogólny sam nie daje prawa do budowy: decyzję o warunkach zabudowy wydaje się tylko w obszarze uzupełnienia zabudowy, zgodnie z planem ogólnym. Sprawdź, czy działka w nim leży.'**
  String get offerBuildHintCheckInfill;

  /// No description provided for @offerBuildHintNoWzWithoutPog.
  ///
  /// In pl, this message translates to:
  /// **'Gmina nie ma jeszcze uchwalonego planu ogólnego — od 1 września 2026 r. nowej decyzji o warunkach zabudowy nie można uzyskać, dopóki go nie uchwali. Wydane wcześniej decyzje pozostają ważne.'**
  String get offerBuildHintNoWzWithoutPog;

  /// No description provided for @offerBuildZones.
  ///
  /// In pl, this message translates to:
  /// **'Przeznaczenie w planie: {zones}'**
  String offerBuildZones(String zones);

  /// No description provided for @offerBuildPogZones.
  ///
  /// In pl, this message translates to:
  /// **'Strefy w planie ogólnym: {zones}'**
  String offerBuildPogZones(String zones);

  /// No description provided for @offerBuildPlanTypeMpzp.
  ///
  /// In pl, this message translates to:
  /// **'Obowiązuje miejscowy plan zagospodarowania przestrzennego'**
  String get offerBuildPlanTypeMpzp;

  /// No description provided for @offerBuildPlanTypePog.
  ///
  /// In pl, this message translates to:
  /// **'Działka jest objęta planem ogólnym gminy'**
  String get offerBuildPlanTypePog;

  /// No description provided for @offerBuildPlanTypePogDraft.
  ///
  /// In pl, this message translates to:
  /// **'Działka jest objęta projektem planu ogólnego gminy — POG (projekt)'**
  String get offerBuildPlanTypePogDraft;

  /// No description provided for @offerBuildPlanTypeStudium.
  ///
  /// In pl, this message translates to:
  /// **'Kierunek zabudowy wskazuje studium gminy'**
  String get offerBuildPlanTypeStudium;

  /// No description provided for @offerBuildPlanTypeWz.
  ///
  /// In pl, this message translates to:
  /// **'Wydano decyzję o warunkach zabudowy'**
  String get offerBuildPlanTypeWz;

  /// No description provided for @offerBuildPlanTypeNone.
  ///
  /// In pl, this message translates to:
  /// **'Brak planu miejscowego i decyzji WZ'**
  String get offerBuildPlanTypeNone;

  /// No description provided for @offerBuildSeeReport.
  ///
  /// In pl, this message translates to:
  /// **'Pełna analiza działki — plan, media, ryzyka i wycena w raporcie PlotFinder →'**
  String get offerBuildSeeReport;

  /// No description provided for @offerBuildPlotResult.
  ///
  /// In pl, this message translates to:
  /// **'Działka {number}: {result}'**
  String offerBuildPlotResult(String number, String result);

  /// No description provided for @offerBuildMore.
  ///
  /// In pl, this message translates to:
  /// **'i {count} więcej'**
  String offerBuildMore(int count);

  /// No description provided for @offerSourceOfficial.
  ///
  /// In pl, this message translates to:
  /// **'Dane urzędowe'**
  String get offerSourceOfficial;

  /// No description provided for @offerSourceOwner.
  ///
  /// In pl, this message translates to:
  /// **'Od właściciela'**
  String get offerSourceOwner;

  /// No description provided for @offerReportCtaTitle.
  ///
  /// In pl, this message translates to:
  /// **'Pełny raport dla każdej działki · za darmo'**
  String get offerReportCtaTitle;

  /// No description provided for @offerReportCtaBody.
  ///
  /// In pl, this message translates to:
  /// **'Ryzyko powodzi, grunt, media, nasłonecznienie i wszystkie wpisy z rejestrów. Bezpłatnie, dla każdej działki.'**
  String get offerReportCtaBody;

  /// No description provided for @offerReportCtaButton.
  ///
  /// In pl, this message translates to:
  /// **'Otwórz raport'**
  String get offerReportCtaButton;

  /// No description provided for @offerReportCtaPending.
  ///
  /// In pl, this message translates to:
  /// **'Raport jest w przygotowaniu'**
  String get offerReportCtaPending;

  /// No description provided for @offerPlotsOverline.
  ///
  /// In pl, this message translates to:
  /// **'Ta oferta'**
  String get offerPlotsOverline;

  /// No description provided for @offerPlotsTitleSingle.
  ///
  /// In pl, this message translates to:
  /// **'Działka w tej ofercie'**
  String get offerPlotsTitleSingle;

  /// No description provided for @offerPlotsTitleTogether.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka} few{{count} działki sprzedawane razem} other{{count} działek sprzedawanych razem}}'**
  String offerPlotsTitleTogether(int count);

  /// No description provided for @offerPlotsTitleSeparately.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{{count} działka} few{{count} działki, każdą kupisz osobno} other{{count} działek, każdą kupisz osobno}}'**
  String offerPlotsTitleSeparately(int count);

  /// No description provided for @offerPlotsOpenReport.
  ///
  /// In pl, this message translates to:
  /// **'Otwórz raport →'**
  String get offerPlotsOpenReport;

  /// No description provided for @offerPlotsReportPending.
  ///
  /// In pl, this message translates to:
  /// **'Raport w przygotowaniu'**
  String get offerPlotsReportPending;

  /// No description provided for @offerUtilitiesOverline.
  ///
  /// In pl, this message translates to:
  /// **'Media i dojazd'**
  String get offerUtilitiesOverline;

  /// No description provided for @offerUtilitiesTitle.
  ///
  /// In pl, this message translates to:
  /// **'Co jest na działce'**
  String get offerUtilitiesTitle;

  /// No description provided for @offerUtilitiesSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Stan według właściciela, sprawdzony z mapą uzbrojenia terenu.'**
  String get offerUtilitiesSubtitle;

  /// No description provided for @offerUtilitiesRoad.
  ///
  /// In pl, this message translates to:
  /// **'Dojazd'**
  String get offerUtilitiesRoad;

  /// No description provided for @offerUtilityStatusAvailable.
  ///
  /// In pl, this message translates to:
  /// **'Podłączone'**
  String get offerUtilityStatusAvailable;

  /// No description provided for @offerUtilityStatusListed.
  ///
  /// In pl, this message translates to:
  /// **'Dostępne'**
  String get offerUtilityStatusListed;

  /// No description provided for @offerUtilityStatusAtBoundary.
  ///
  /// In pl, this message translates to:
  /// **'Przy granicy'**
  String get offerUtilityStatusAtBoundary;

  /// No description provided for @offerUtilityStatusInProgress.
  ///
  /// In pl, this message translates to:
  /// **'W trakcie podłączania'**
  String get offerUtilityStatusInProgress;

  /// No description provided for @offerUtilityStatusPlanned.
  ///
  /// In pl, this message translates to:
  /// **'Planowane'**
  String get offerUtilityStatusPlanned;

  /// No description provided for @offerUtilityStatusNotAvailable.
  ///
  /// In pl, this message translates to:
  /// **'Brak'**
  String get offerUtilityStatusNotAvailable;

  /// No description provided for @offerUtilityStatusUnknown.
  ///
  /// In pl, this message translates to:
  /// **'Brak danych'**
  String get offerUtilityStatusUnknown;

  /// No description provided for @offerRoadAsphalt.
  ///
  /// In pl, this message translates to:
  /// **'Droga asfaltowa'**
  String get offerRoadAsphalt;

  /// No description provided for @offerRoadGravel.
  ///
  /// In pl, this message translates to:
  /// **'Droga utwardzona'**
  String get offerRoadGravel;

  /// No description provided for @offerRoadDirt.
  ///
  /// In pl, this message translates to:
  /// **'Droga gruntowa'**
  String get offerRoadDirt;

  /// No description provided for @offerRoadEasement.
  ///
  /// In pl, this message translates to:
  /// **'Dojazd przez służebność'**
  String get offerRoadEasement;

  /// No description provided for @offerRoadEstimatePublic.
  ///
  /// In pl, this message translates to:
  /// **'Droga dojazdowa: publiczna (szacunek z OpenStreetMap)'**
  String get offerRoadEstimatePublic;

  /// No description provided for @offerRoadEstimatePrivate.
  ///
  /// In pl, this message translates to:
  /// **'Droga dojazdowa: prywatna (szacunek z OpenStreetMap)'**
  String get offerRoadEstimatePrivate;

  /// No description provided for @offerUtilityNetworkDistance.
  ///
  /// In pl, this message translates to:
  /// **'Sieć {distance} od działki'**
  String offerUtilityNetworkDistance(String distance);

  /// No description provided for @offerConnectionOnPlot.
  ///
  /// In pl, this message translates to:
  /// **'Na działce'**
  String get offerConnectionOnPlot;

  /// No description provided for @offerConnectionAtBoundary.
  ///
  /// In pl, this message translates to:
  /// **'Przy granicy'**
  String get offerConnectionAtBoundary;

  /// No description provided for @offerConnectionPublicRoad.
  ///
  /// In pl, this message translates to:
  /// **'W drodze publicznej'**
  String get offerConnectionPublicRoad;

  /// No description provided for @offerConnectionPrivateRoad.
  ///
  /// In pl, this message translates to:
  /// **'W drodze prywatnej'**
  String get offerConnectionPrivateRoad;

  /// No description provided for @offerConnectionAccepted.
  ///
  /// In pl, this message translates to:
  /// **'przyłącze odebrane'**
  String get offerConnectionAccepted;

  /// No description provided for @offerConnectionNotAccepted.
  ///
  /// In pl, this message translates to:
  /// **'przyłącze nieodebrane'**
  String get offerConnectionNotAccepted;

  /// No description provided for @offerSellerDeclaration.
  ///
  /// In pl, this message translates to:
  /// **'Deklaracja sprzedającego'**
  String get offerSellerDeclaration;

  /// No description provided for @offerUtilitySourceOwner.
  ///
  /// In pl, this message translates to:
  /// **'potwierdzone przez sprzedającego'**
  String get offerUtilitySourceOwner;

  /// No description provided for @offerUtilitySourceDetected.
  ///
  /// In pl, this message translates to:
  /// **'wykryte w rejestrze'**
  String get offerUtilitySourceDetected;

  /// No description provided for @offerLegalOverline.
  ///
  /// In pl, this message translates to:
  /// **'Stan prawny'**
  String get offerLegalOverline;

  /// No description provided for @offerLegalTitle.
  ///
  /// In pl, this message translates to:
  /// **'Własność i dokumenty'**
  String get offerLegalTitle;

  /// No description provided for @offerLegalLandRegister.
  ///
  /// In pl, this message translates to:
  /// **'Księga wieczysta'**
  String get offerLegalLandRegister;

  /// No description provided for @offerLegalOwnership.
  ///
  /// In pl, this message translates to:
  /// **'Własność'**
  String get offerLegalOwnership;

  /// No description provided for @offerLegalBuildingConditions.
  ///
  /// In pl, this message translates to:
  /// **'Warunki zabudowy'**
  String get offerLegalBuildingConditions;

  /// No description provided for @offerLegalEncumbrances.
  ///
  /// In pl, this message translates to:
  /// **'Obciążenia'**
  String get offerLegalEncumbrances;

  /// No description provided for @offerOwnershipFull.
  ///
  /// In pl, this message translates to:
  /// **'Pełna własność'**
  String get offerOwnershipFull;

  /// No description provided for @offerOwnershipPerpetualUsufruct.
  ///
  /// In pl, this message translates to:
  /// **'Użytkowanie wieczyste'**
  String get offerOwnershipPerpetualUsufruct;

  /// No description provided for @offerOwnershipShare.
  ///
  /// In pl, this message translates to:
  /// **'Współwłasność (udział)'**
  String get offerOwnershipShare;

  /// No description provided for @offerConditionsNone.
  ///
  /// In pl, this message translates to:
  /// **'Brak decyzji'**
  String get offerConditionsNone;

  /// No description provided for @offerConditionsZoningDecision.
  ///
  /// In pl, this message translates to:
  /// **'Decyzja o warunkach zabudowy'**
  String get offerConditionsZoningDecision;

  /// No description provided for @offerConditionsBuildingPermit.
  ///
  /// In pl, this message translates to:
  /// **'Pozwolenie na budowę'**
  String get offerConditionsBuildingPermit;

  /// No description provided for @offerEncumbranceMortgage.
  ///
  /// In pl, this message translates to:
  /// **'Hipoteka'**
  String get offerEncumbranceMortgage;

  /// No description provided for @offerEncumbranceEasement.
  ///
  /// In pl, this message translates to:
  /// **'Służebność'**
  String get offerEncumbranceEasement;

  /// No description provided for @offerEncumbranceOther.
  ///
  /// In pl, this message translates to:
  /// **'Inne obciążenia'**
  String get offerEncumbranceOther;

  /// No description provided for @offerLegalNoneReported.
  ///
  /// In pl, this message translates to:
  /// **'Brak zgłoszonych'**
  String get offerLegalNoneReported;

  /// No description provided for @offerLegalNotProvided.
  ///
  /// In pl, this message translates to:
  /// **'Nie podano'**
  String get offerLegalNotProvided;

  /// No description provided for @offerDocumentsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Dokumenty od sprzedającego'**
  String get offerDocumentsTitle;

  /// No description provided for @offerDocumentsHint.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się i napisz do sprzedającego, aby pobrać dokumenty.'**
  String get offerDocumentsHint;

  /// No description provided for @offerDocumentsHintSignedIn.
  ///
  /// In pl, this message translates to:
  /// **'Dokumenty pobierzesz po wysłaniu wiadomości do sprzedającego z tego konta.'**
  String get offerDocumentsHintSignedIn;

  /// No description provided for @offerDocumentVerified.
  ///
  /// In pl, this message translates to:
  /// **'Zweryfikowany'**
  String get offerDocumentVerified;

  /// No description provided for @offerDocumentPlot.
  ///
  /// In pl, this message translates to:
  /// **'działka {number}'**
  String offerDocumentPlot(String number);

  /// No description provided for @offerDocumentDownload.
  ///
  /// In pl, this message translates to:
  /// **'Pobierz'**
  String get offerDocumentDownload;

  /// No description provided for @documentTypeLandRegisterExtract.
  ///
  /// In pl, this message translates to:
  /// **'Odpis z księgi wieczystej'**
  String get documentTypeLandRegisterExtract;

  /// No description provided for @documentTypeZoningExtract.
  ///
  /// In pl, this message translates to:
  /// **'Wypis z planu miejscowego'**
  String get documentTypeZoningExtract;

  /// No description provided for @documentTypeSurveyMap.
  ///
  /// In pl, this message translates to:
  /// **'Mapa geodezyjna'**
  String get documentTypeSurveyMap;

  /// No description provided for @documentTypeZoningDecision.
  ///
  /// In pl, this message translates to:
  /// **'Decyzja o warunkach zabudowy'**
  String get documentTypeZoningDecision;

  /// No description provided for @documentTypeConnectionAcceptance.
  ///
  /// In pl, this message translates to:
  /// **'Protokół odbioru przyłącza'**
  String get documentTypeConnectionAcceptance;

  /// No description provided for @fileSizeKb.
  ///
  /// In pl, this message translates to:
  /// **'{value} KB'**
  String fileSizeKb(String value);

  /// No description provided for @fileSizeMb.
  ///
  /// In pl, this message translates to:
  /// **'{value} MB'**
  String fileSizeMb(String value);

  /// No description provided for @distanceMeters.
  ///
  /// In pl, this message translates to:
  /// **'{value} m'**
  String distanceMeters(String value);

  /// No description provided for @distanceKilometers.
  ///
  /// In pl, this message translates to:
  /// **'{value} km'**
  String distanceKilometers(String value);

  /// No description provided for @offerDescriptionOverline.
  ///
  /// In pl, this message translates to:
  /// **'Od właściciela'**
  String get offerDescriptionOverline;

  /// No description provided for @offerDescriptionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Opis'**
  String get offerDescriptionTitle;

  /// No description provided for @offerSellerForAll.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, one{Za działkę} other{Za wszystkie działki}}'**
  String offerSellerForAll(int count);

  /// No description provided for @offerSellerNegotiable.
  ///
  /// In pl, this message translates to:
  /// **'do negocjacji'**
  String get offerSellerNegotiable;

  /// No description provided for @offerSellerNoCommission.
  ///
  /// In pl, this message translates to:
  /// **'bez prowizji'**
  String get offerSellerNoCommission;

  /// No description provided for @offerSellerWrite.
  ///
  /// In pl, this message translates to:
  /// **'Napisz do właściciela'**
  String get offerSellerWrite;

  /// No description provided for @offerSellerViewing.
  ///
  /// In pl, this message translates to:
  /// **'Umów oglądanie'**
  String get offerSellerViewing;

  /// No description provided for @offerSellerMessagesOff.
  ///
  /// In pl, this message translates to:
  /// **'Sprzedający nie przyjmuje wiadomości przez PlotFinder — skorzystaj z telefonu lub e-maila.'**
  String get offerSellerMessagesOff;

  /// No description provided for @offerSellerFallbackName.
  ///
  /// In pl, this message translates to:
  /// **'Sprzedający'**
  String get offerSellerFallbackName;

  /// No description provided for @offerSellerMemberSince.
  ///
  /// In pl, this message translates to:
  /// **'Osoba prywatna · na PlotFinder od {date}'**
  String offerSellerMemberSince(String date);

  /// No description provided for @offerSellerAdded.
  ///
  /// In pl, this message translates to:
  /// **'Dodano {date}'**
  String offerSellerAdded(String date);

  /// No description provided for @offerSellerSource.
  ///
  /// In pl, this message translates to:
  /// **'Zobacz ogłoszenie źródłowe'**
  String get offerSellerSource;

  /// No description provided for @offerContactShowPhone.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż telefon'**
  String get offerContactShowPhone;

  /// No description provided for @offerContactShowEmail.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż e-mail'**
  String get offerContactShowEmail;

  /// No description provided for @offerContactMissing.
  ///
  /// In pl, this message translates to:
  /// **'Sprzedający nie podał danych kontaktowych.'**
  String get offerContactMissing;

  /// No description provided for @offerContactError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się pobrać danych kontaktowych. Spróbuj ponownie.'**
  String get offerContactError;

  /// No description provided for @textSeparator.
  ///
  /// In pl, this message translates to:
  /// **' · '**
  String get textSeparator;
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
