import 'package:intl/intl.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/filter_category.dart';
import 'package:map_maker_new/types/enum/offer_designation.dart';
import 'package:map_maker_new/types/enum/offer_plan_basis.dart';
import 'package:map_maker_new/types/enum/offer_plots_count.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';

extension OfferDesignationLabelExtension on OfferDesignation {
  String label(AppLocalizations localizations) {
    switch (this) {
      case OfferDesignation.residential:
        return localizations.designationResidential;
      case OfferDesignation.residentialServices:
        return localizations.designationResidentialServices;
      case OfferDesignation.farmstead:
        return localizations.designationFarmstead;
      case OfferDesignation.recreation:
        return localizations.designationRecreation;
      case OfferDesignation.services:
        return localizations.designationServices;
      case OfferDesignation.industrial:
        return localizations.designationIndustrial;
      case OfferDesignation.agricultural:
        return localizations.designationAgricultural;
      case OfferDesignation.forest:
        return localizations.designationForest;
      case OfferDesignation.open:
        return localizations.designationOpen;
    }
  }
}

extension OfferPlanBasisLabelExtension on OfferPlanBasis {
  String label(AppLocalizations localizations) {
    switch (this) {
      case OfferPlanBasis.mpzp:
        return localizations.planBasisMpzp;
      case OfferPlanBasis.pog:
        return localizations.planBasisPog;
      case OfferPlanBasis.wz:
        return localizations.planBasisWz;
      case OfferPlanBasis.pogDraft:
        return localizations.planBasisPogDraft;
      case OfferPlanBasis.studium:
        return localizations.planBasisStudium;
      case OfferPlanBasis.none:
        return localizations.planBasisNone;
    }
  }
}

extension OfferUtilityLabelExtension on OfferUtility {
  String label(AppLocalizations localizations) {
    switch (this) {
      case OfferUtility.electricity:
        return localizations.utilityElectricity;
      case OfferUtility.water:
        return localizations.utilityWater;
      case OfferUtility.sewage:
        return localizations.utilitySewage;
      case OfferUtility.gas:
        return localizations.utilityGas;
      case OfferUtility.internet:
        return localizations.utilityInternet;
    }
  }
}

extension OfferPlotsCountLabelExtension on OfferPlotsCount? {
  String label(AppLocalizations localizations) {
    switch (this) {
      case null:
        return localizations.plotsAny;
      case OfferPlotsCount.one:
        return localizations.plotsOne;
      case OfferPlotsCount.many:
        return localizations.plotsMany;
    }
  }
}

extension FilterCategoryLabelExtension on FilterCategory {
  String title(AppLocalizations localizations) {
    switch (this) {
      case FilterCategory.location:
        return localizations.location;
      case FilterCategory.price:
        return localizations.price;
      case FilterCategory.area:
        return localizations.area;
      case FilterCategory.designation:
        return localizations.designation;
      case FilterCategory.media:
        return localizations.media;
    }
  }

  String chipLabel(AppLocalizations localizations, OfferSearchCriteria criteria) {
    switch (this) {
      case FilterCategory.location:
        return criteria.commune ?? criteria.county ?? criteria.voivodeship ?? title(localizations);
      case FilterCategory.price:
        final String? priceRange = formatRange(
          localizations,
          criteria.priceMin,
          criteria.priceMax,
          (int value) => formatPrice(localizations, value),
        );
        final String priceLabel = priceRange ?? title(localizations);
        return criteria.goodPrice ? localizations.priceWithGoodPrice(priceLabel, localizations.goodPrice) : priceLabel;
      case FilterCategory.area:
        return formatRange(
              localizations,
              criteria.areaMin,
              criteria.areaMax,
              (int value) => formatArea(localizations, value),
            ) ??
            title(localizations);
      case FilterCategory.designation:
        if (criteria.designations.length == 1) return criteria.designations.first.label(localizations);
        if (criteria.designations.length > 1) return localizations.designationCount(criteria.designations.length);
        return title(localizations);
      case FilterCategory.media:
        if (criteria.utilities.isNotEmpty) return localizations.mediaCount(criteria.utilities.length);
        return title(localizations);
    }
  }
}

String? formatRange(AppLocalizations localizations, int? min, int? max, String Function(int) format) {
  if (min != null && max != null) return localizations.rangeBetween(format(min), format(max));
  if (max != null) return localizations.rangeUpTo(format(max));
  if (min != null) return localizations.rangeFrom(format(min));
  return null;
}

String formatPrice(AppLocalizations localizations, int price) {
  if (price >= 1000000) {
    final NumberFormat millionsFormat = NumberFormat("0.#", localizations.localeName);
    return localizations.priceMillions(millionsFormat.format(price / 1000000));
  }
  return localizations.priceThousands((price / 1000).round().toString());
}

String formatArea(AppLocalizations localizations, int area) {
  final NumberFormat areaFormat = NumberFormat.decimalPattern(localizations.localeName);
  return localizations.areaSquareMeters(areaFormat.format(area));
}
