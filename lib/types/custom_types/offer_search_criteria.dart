import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:map_maker_new/types/enum/filter_category.dart';
import 'package:map_maker_new/types/enum/offer_designation.dart';
import 'package:map_maker_new/types/enum/offer_plan_basis.dart';
import 'package:map_maker_new/types/enum/offer_plots_count.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';

class OfferSearchCriteria extends Equatable {
  final String? query;
  final String? voivodeship;
  final String? county;
  final String? commune;
  final int? priceMin;
  final int? priceMax;
  final bool goodPrice;
  final int? areaMin;
  final int? areaMax;
  final OfferPlotsCount? plotsCount;
  final List<OfferDesignation> designations;
  final List<OfferPlanBasis> planBases;
  final List<OfferUtility> utilities;
  final bool roadAccess;
  final int? cityDistanceMaxKm;

  static const int priceRangeMax = 2000000;
  static const int priceRangeStep = 10000;
  static const int areaRangeMax = 10000;
  static const int areaRangeStep = 100;
  static const List<int> cityDistancesKm = [5, 10, 20, 30];

  static const List<String> _voivodeships = [
    "Dolnośląskie",
    "Kujawsko-pomorskie",
    "Lubelskie",
    "Lubuskie",
    "Łódzkie",
    "Małopolskie",
    "Mazowieckie",
    "Opolskie",
    "Podkarpackie",
    "Podlaskie",
    "Pomorskie",
    "Śląskie",
    "Świętokrzyskie",
    "Warmińsko-mazurskie",
    "Wielkopolskie",
    "Zachodniopomorskie",
  ];
  static final RegExp _voivodeshipPrefix = RegExp(r"^(woj\.?|województwo)\s+");
  static final RegExp _plotNumber = RegExp(r"^\d{6}_\d\.\d{4}\.\S+$");

  const OfferSearchCriteria({
    this.query,
    this.voivodeship,
    this.county,
    this.commune,
    this.priceMin,
    this.priceMax,
    this.goodPrice = false,
    this.areaMin,
    this.areaMax,
    this.plotsCount,
    this.designations = const [],
    this.planBases = const [],
    this.utilities = const [],
    this.roadAccess = false,
    this.cityDistanceMaxKm,
  });

  bool get hasLocation => voivodeship != null || county != null || commune != null;

  bool get hasPrice => priceMin != null || priceMax != null || goodPrice;

  bool get hasArea => areaMin != null || areaMax != null;

  bool get isAnyFiltersApplied => appliedFiltersCount > 0;

  int get appliedFiltersCount {
    int count = 0;
    if (hasLocation) count++;
    if (priceMin != null || priceMax != null) count++;
    if (goodPrice) count++;
    if (hasArea) count++;
    if (plotsCount != null) count++;
    count += designations.length + planBases.length + utilities.length;
    if (roadAccess) count++;
    if (cityDistanceMaxKm != null) count++;
    return count;
  }

  OfferSearchCriteria copyWith({
    ValueGetter<String?>? query,
    ValueGetter<String?>? voivodeship,
    ValueGetter<String?>? county,
    ValueGetter<String?>? commune,
    ValueGetter<int?>? priceMin,
    ValueGetter<int?>? priceMax,
    bool? goodPrice,
    ValueGetter<int?>? areaMin,
    ValueGetter<int?>? areaMax,
    ValueGetter<OfferPlotsCount?>? plotsCount,
    List<OfferDesignation>? designations,
    List<OfferPlanBasis>? planBases,
    List<OfferUtility>? utilities,
    bool? roadAccess,
    ValueGetter<int?>? cityDistanceMaxKm,
  }) {
    return OfferSearchCriteria(
      query: query != null ? query() : this.query,
      voivodeship: voivodeship != null ? voivodeship() : this.voivodeship,
      county: county != null ? county() : this.county,
      commune: commune != null ? commune() : this.commune,
      priceMin: priceMin != null ? priceMin() : this.priceMin,
      priceMax: priceMax != null ? priceMax() : this.priceMax,
      goodPrice: goodPrice ?? this.goodPrice,
      areaMin: areaMin != null ? areaMin() : this.areaMin,
      areaMax: areaMax != null ? areaMax() : this.areaMax,
      plotsCount: plotsCount != null ? plotsCount() : this.plotsCount,
      designations: designations ?? this.designations,
      planBases: planBases ?? this.planBases,
      utilities: utilities ?? this.utilities,
      roadAccess: roadAccess ?? this.roadAccess,
      cityDistanceMaxKm: cityDistanceMaxKm != null ? cityDistanceMaxKm() : this.cityDistanceMaxKm,
    );
  }

  OfferSearchCriteria cleared() => OfferSearchCriteria(query: query);

  bool isFilterCategoryApplied(FilterCategory filterCategory) {
    switch (filterCategory) {
      case FilterCategory.location:
        return hasLocation;
      case FilterCategory.price:
        return hasPrice;
      case FilterCategory.area:
        return hasArea;
      case FilterCategory.designation:
        return designations.isNotEmpty;
      case FilterCategory.media:
        return utilities.isNotEmpty;
    }
  }

  OfferSearchCriteria clearedFilterCategory(FilterCategory filterCategory) {
    switch (filterCategory) {
      case FilterCategory.location:
        return copyWith(voivodeship: () => null, county: () => null, commune: () => null);
      case FilterCategory.price:
        return copyWith(priceMin: () => null, priceMax: () => null, goodPrice: false);
      case FilterCategory.area:
        return copyWith(areaMin: () => null, areaMax: () => null);
      case FilterCategory.designation:
        return copyWith(designations: const []);
      case FilterCategory.media:
        return copyWith(utilities: const []);
    }
  }

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> queryParameters = {
      ..._getLocationQueryParameters(),
      "price_min": priceMin,
      "price_max": priceMax,
      "good_price": goodPrice ? "true" : null,
      "area_min": areaMin,
      "area_max": areaMax,
      "plots": plotsCount?.apiValue,
      "designation": _joinApiValues(designations.map((designation) => designation.apiValue)),
      "plan_basis": _joinApiValues(planBases.map((planBasis) => planBasis.apiValue)),
      "utilities": _joinApiValues(utilities.map((utility) => utility.apiValue)),
      "road_access": roadAccess ? "true" : null,
      "city_distance_max": cityDistanceMaxKm,
    };
    queryParameters.removeWhere((_, value) => value == null);
    return queryParameters;
  }

  Map<String, dynamic> _getLocationQueryParameters() {
    if (hasLocation) {
      return {"voivodeship": voivodeship, "county": county, "commune": commune};
    }
    return _parseQuery(query);
  }

  static Map<String, dynamic> _parseQuery(String? query) {
    final String trimmedQuery = query?.trim() ?? "";
    if (trimmedQuery.isEmpty || _plotNumber.hasMatch(trimmedQuery)) return {};

    final Map<String, dynamic> location = {};
    final List<String> otherParts = [];
    for (final String part in trimmedQuery.split(",").map((part) => part.trim()).where((part) => part.isNotEmpty)) {
      final String voivodeshipCandidate = part.toLowerCase().replaceFirst(_voivodeshipPrefix, "");
      if (_voivodeships.contains(voivodeshipCandidate)) {
        location["voivodeship"] = voivodeshipCandidate;
      } else {
        otherParts.add(part);
      }
    }
    if (otherParts.isNotEmpty) location["commune"] = otherParts[0];
    if (otherParts.length > 1) location["county"] = otherParts[1];
    return location;
  }

  static String? _joinApiValues(Iterable<String> values) => values.isEmpty ? null : values.join(",");

  @override
  List<Object?> get props => [
    query,
    voivodeship,
    county,
    commune,
    priceMin,
    priceMax,
    goodPrice,
    areaMin,
    areaMax,
    plotsCount,
    designations,
    planBases,
    utilities,
    roadAccess,
    cityDistanceMaxKm,
  ];
}
