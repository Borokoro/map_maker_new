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
  String offerPlotCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count działek',
      few: '$count działki',
      one: '$count działka',
    );
    return '$_temp0';
  }

  @override
  String get offerNoPrice => 'Cena do uzgodnienia';

  @override
  String offerEstimatedPrice(String range) {
    return 'ok. $range';
  }

  @override
  String offerPrice(String value) {
    return '$value zł';
  }

  @override
  String offerPricePerMeter(String value) {
    return '$value zł/m²';
  }

  @override
  String offerLocation(String area, String location) {
    return '$area · $location';
  }

  @override
  String offerMultiLocation(String plots, String area, String location) {
    return '$plots · $area · $location';
  }

  @override
  String get planDesignationResidential => 'Zabudowa mieszkaniowa';

  @override
  String get planDesignationResidentialServices => 'Mieszkaniowa z usługami';

  @override
  String get planDesignationFarmstead => 'Zabudowa zagrodowa';

  @override
  String get planDesignationRecreation => 'Rekreacja / letniskowa';

  @override
  String get planDesignationServices => 'Usługi';

  @override
  String get planDesignationIndustrial => 'Produkcja i składy';

  @override
  String get planDesignationAgricultural => 'Rolna';

  @override
  String get planDesignationForest => 'Las';

  @override
  String get planDesignationGreen => 'Zieleń';

  @override
  String get planDesignationWater => 'Wody';

  @override
  String get planDesignationTransport => 'Komunikacja';

  @override
  String get planDesignationInfrastructure => 'Infrastruktura';

  @override
  String get planDesignationCemetery => 'Cmentarz';

  @override
  String get planDesignationOpen => 'Strefa otwarta';

  @override
  String get planDesignationOther => 'Inne';

  @override
  String planDesignationWithOthers(String designation, int count) {
    return '$designation +$count';
  }

  @override
  String planWithBasisMpzp(String designation) {
    return '$designation · MPZP';
  }

  @override
  String planWithBasisPog(String designation) {
    return '$designation · plan ogólny';
  }

  @override
  String planWithBasisPogDraft(String designation) {
    return '$designation · projekt POG';
  }

  @override
  String planWithBasisStudium(String designation) {
    return '$designation · studium';
  }

  @override
  String planWithBasisMixed(String designation) {
    return '$designation · różne plany';
  }

  @override
  String get planMixedDesignationsMpzp => 'Różne przeznaczenia · MPZP';

  @override
  String get planMixedDesignationsPog => 'Różne przeznaczenia · plan ogólny';

  @override
  String get planMixedDesignationsPogDraft =>
      'Różne przeznaczenia · projekt POG';

  @override
  String get planMixedDesignationsStudium => 'Różne przeznaczenia · studium';

  @override
  String get planMixedDesignationsMixed => 'Różne przeznaczenia';

  @override
  String get planBasisLabelUnknown => 'Plan w trakcie sprawdzania';

  @override
  String get planBasisLabelMpzp => 'MPZP — sprawdź przeznaczenie';

  @override
  String get planBasisLabelPog => 'Plan ogólny';

  @override
  String get planBasisLabelWz => 'Decyzja WZ';

  @override
  String get planBasisLabelPogDraft => 'Projekt POG';

  @override
  String get planBasisLabelStudium => 'Studium';

  @override
  String get planBasisLabelNone => 'Brak planu';

  @override
  String get planBasisLabelMixed => 'Różne przeznaczenia';

  @override
  String get planHintWzPossible => 'możliwa WZ zgodna z planem';

  @override
  String get planHintNeedsMpzp => 'budowa po uchwaleniu MPZP';

  @override
  String get planHintCheckInfill => 'sprawdź obszar uzupełnienia zabudowy';

  @override
  String get planHintNoWzWithoutPog => 'WZ dopiero po uchwaleniu POG';

  @override
  String planWithHint(String label, String hint) {
    return '$label — $hint';
  }

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

  @override
  String get loginTitle => 'Zaloguj się';

  @override
  String get loginSubtitle => 'Zarządzaj ofertami i zapisanymi działkami.';

  @override
  String get loginIdentifier => 'E-mail lub nazwa użytkownika';

  @override
  String get password => 'Hasło';

  @override
  String get loginSubmit => 'Zaloguj się';

  @override
  String get showPassword => 'Pokaż hasło';

  @override
  String get hidePassword => 'Ukryj hasło';

  @override
  String get fieldRequired => 'Uzupełnij to pole';

  @override
  String get loginInvalidCredentials =>
      'Nieprawidłowy e-mail, nazwa użytkownika lub hasło.';

  @override
  String get tooManyRequestsError =>
      'Zbyt wiele prób. Spróbuj ponownie później.';

  @override
  String get networkError => 'Brak połączenia z internetem. Spróbuj ponownie.';

  @override
  String get unknownError => 'Coś poszło nie tak. Spróbuj ponownie później.';

  @override
  String get loggedIn => 'Jesteś zalogowany';

  @override
  String loggedInAs(String username) {
    return 'Zalogowano jako $username';
  }

  @override
  String get logout => 'Wyloguj się';

  @override
  String get invalidDataError => 'Sprawdź poprawność wprowadzonych danych.';

  @override
  String get invalidEmail => 'Podaj poprawny adres e-mail';

  @override
  String passwordTooShort(int count) {
    return 'Hasło musi mieć co najmniej $count znaków';
  }

  @override
  String get forgotPassword => 'Nie pamiętasz hasła?';

  @override
  String get noAccount => 'Nie masz konta?';

  @override
  String get hasAccount => 'Masz już konto?';

  @override
  String get email => 'E-mail';

  @override
  String get resetPasswordTitle => 'Nie pamiętasz hasła?';

  @override
  String get resetPasswordSubtitle =>
      'Wyślemy link do ustawienia nowego hasła.';

  @override
  String get resetPasswordSubmit => 'Wyślij link';

  @override
  String get resetPasswordSentTitle => 'Sprawdź skrzynkę';

  @override
  String resetPasswordSent(String email) {
    return 'Jeśli konto z adresem $email istnieje, wysłaliśmy na nie link do ustawienia nowego hasła. Link jest ważny przez ograniczony czas.';
  }

  @override
  String get backToLogin => 'Wróć do logowania';

  @override
  String get signupTitle => 'Załóż konto';

  @override
  String get signupSubtitle => 'Konto jest bezpłatne.';

  @override
  String get signupSubmit => 'Załóż konto';

  @override
  String get signupSuccess => 'Konto założone. Witamy w PlotFinder!';

  @override
  String get firstName => 'Imię';

  @override
  String get lastName => 'Nazwisko';

  @override
  String optionalField(String field) {
    return '$field (opcjonalnie)';
  }

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String passwordRules(int count) {
    return 'Minimum $count znaków';
  }

  @override
  String get termsAcceptPrefix => 'Akceptuję ';

  @override
  String get termsLink => 'regulamin';

  @override
  String get termsAnd => ' i ';

  @override
  String get privacyPolicyLink => 'politykę prywatności';

  @override
  String get termsRequired => 'Zaakceptuj regulamin, aby założyć konto';

  @override
  String get termsTitle => 'Regulamin';

  @override
  String get privacyPolicyTitle => 'Polityka prywatności';

  @override
  String get addToSaved => 'Dodaj do zapisanych';

  @override
  String get removeFromSaved => 'Usuń z zapisanych';

  @override
  String get saveOfferError =>
      'Nie udało się zaktualizować zapisanych ofert. Spróbuj ponownie.';

  @override
  String get savedTitle => 'Zapisane działki';

  @override
  String get savedSubtitle =>
      'Oferty oznaczone serduszkiem. Kliknij serce ponownie, aby usunąć ofertę z listy.';

  @override
  String savedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zapisanych ofert',
      few: '$count zapisane oferty',
      one: '$count zapisana oferta',
    );
    return '$_temp0';
  }

  @override
  String get savedEmptyTitle => 'Nie masz jeszcze zapisanych działek';

  @override
  String get savedEmptyDescription =>
      'Kliknij serce na karcie oferty, aby wrócić do niej później.';

  @override
  String get browseOffers => 'Przeglądaj oferty';

  @override
  String get savedLoadingError => 'Nie udało się wczytać zapisanych ofert';

  @override
  String utilityAvailable(String name) {
    return '$name: dostępne';
  }

  @override
  String utilityUnavailable(String name) {
    return '$name: brak';
  }

  @override
  String get loadMoreRetry =>
      'Nie udało się wczytać kolejnych ofert. Spróbuj ponownie';
}
