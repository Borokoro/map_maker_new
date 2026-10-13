// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get plotFinder => 'PlotFinder';

  @override
  String get search => 'Szukaj';

  @override
  String get saved => 'Zapisane';

  @override
  String get sell => 'Sprzedaj';

  @override
  String get messages => 'Wiadomości';

  @override
  String get account => 'Konto';

  @override
  String get searchPlaceholder => 'Miejscowość, gmina lub nr działki';

  @override
  String get offersLoadingError => 'Nie udało się wczytać ofert';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get allFilters => 'Wszystkie filtry';

  @override
  String activeFilters(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aktywnych',
      few: '$count aktywne',
      one: '$count aktywny',
      zero: 'Brak aktywnych filtrów',
    );
    return '$_temp0';
  }

  @override
  String get clear => 'Wyczyść';

  @override
  String get clearAll => 'Wyczyść wszystko';

  @override
  String get apply => 'Zastosuj';

  @override
  String get showOffers => 'Pokaż oferty';

  @override
  String get location => 'Lokalizacja';

  @override
  String get voivodeship => 'Województwo';

  @override
  String get voivodeshipPlaceholder => 'Wszystkie województwa';

  @override
  String get county => 'Powiat';

  @override
  String get countyPlaceholder => 'Wszystkie powiaty';

  @override
  String get commune => 'Gmina';

  @override
  String get communePlaceholder => 'Wszystkie gminy';

  @override
  String get pickVoivodeshipFirst => 'Najpierw wybierz województwo';

  @override
  String get pickCountyFirst => 'Najpierw wybierz powiat';

  @override
  String get price => 'Cena';

  @override
  String get goodPrice => 'Dobra cena';

  @override
  String get goodPriceHint => 'poniżej szacunku modelu';

  @override
  String get area => 'Powierzchnia';

  @override
  String get areaAndPlots => 'Powierzchnia i liczba działek';

  @override
  String get plots => 'Liczba działek';

  @override
  String get plotsAny => 'Dowolna liczba';

  @override
  String get plotsOne => '1 działka';

  @override
  String get plotsMany => '2 i więcej';

  @override
  String get designation => 'Przeznaczenie';

  @override
  String designationCount(int count) {
    return 'Przeznaczenie · $count';
  }

  @override
  String get planBasis => 'Podstawa planistyczna';

  @override
  String get media => 'Media';

  @override
  String mediaCount(int count) {
    return 'Media · $count';
  }

  @override
  String get access => 'Dojazd i teren';

  @override
  String get roadAccess => 'Dostęp do drogi publicznej';

  @override
  String get roadAccessHint => 'bezpośrednio lub przez służebność';

  @override
  String get cityDistance => 'Do miasta maks.';

  @override
  String cityDistanceKm(int km) {
    return '$km km';
  }

  @override
  String rangeUpTo(String value) {
    return 'Do $value';
  }

  @override
  String rangeFrom(String value) {
    return 'Od $value';
  }

  @override
  String rangeBetween(String min, String max) {
    return '$min – $max';
  }

  @override
  String priceThousands(String value) {
    return '$value tys. zł';
  }

  @override
  String priceMillions(String value) {
    return '$value mln zł';
  }

  @override
  String areaSquareMeters(String value) {
    return '$value m²';
  }

  @override
  String rangeNoLimit(String value) {
    return '$value+';
  }

  @override
  String priceWithGoodPrice(String price, String goodPrice) {
    return '$price · $goodPrice';
  }

  @override
  String locationWithCount(String name, int count) {
    return '$name ($count)';
  }

  @override
  String get mapPriceOnRequest => 'Zapytaj';

  @override
  String mapPriceThousands(String value) {
    return '${value}k';
  }

  @override
  String mapPriceMillions(String value) {
    return '$value mln';
  }

  @override
  String get mapClusterOffersFew => ' oferty';

  @override
  String get mapClusterOffersMany => ' ofert';

  @override
  String get designationResidential => 'Mieszkaniowa';

  @override
  String get designationResidentialServices => 'Z usługami';

  @override
  String get designationFarmstead => 'Zagrodowa';

  @override
  String get designationRecreation => 'Rekreacja';

  @override
  String get designationServices => 'Usługi';

  @override
  String get designationIndustrial => 'Produkcja';

  @override
  String get designationAgricultural => 'Rolna';

  @override
  String get designationForest => 'Las';

  @override
  String get designationOpen => 'Strefa otwarta';

  @override
  String get planBasisMpzp => 'MPZP';

  @override
  String get planBasisPog => 'Plan ogólny';

  @override
  String get planBasisWz => 'Decyzja WZ';

  @override
  String get planBasisPogDraft => 'Projekt POG';

  @override
  String get planBasisStudium => 'Studium';

  @override
  String get planBasisNone => 'Brak planu';

  @override
  String get utilityElectricity => 'Prąd';

  @override
  String get utilityWater => 'Woda';

  @override
  String get utilitySewage => 'Kanalizacja';

  @override
  String get utilityGas => 'Gaz';

  @override
  String get utilityInternet => 'Internet';
}
