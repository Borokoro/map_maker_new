import 'package:intl/intl.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/enum/offer_plan_badge_kind.dart';
import 'package:map_maker_new/types/enum/plan_basis.dart';
import 'package:map_maker_new/types/enum/plan_designation.dart';
import 'package:map_maker_new/types/enum/plan_hint.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/offer_estimate.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';

extension OfferLabelsExtension on Offer {
  String priceLabel(AppLocalizations localizations) {
    final double? offerPrice = price;
    if (offerPrice != null) return localizations.offerPrice(_formatNumber(localizations, offerPrice));
    final OfferEstimate? offerEstimate = estimate;
    if (offerEstimate == null) return localizations.offerNoPrice;
    final String range = localizations.rangeBetween(
      formatPrice(localizations, offerEstimate.low.round()),
      formatPrice(localizations, offerEstimate.high.round()),
    );
    return localizations.offerEstimatedPrice(range);
  }

  String? pricePerMeterLabel(AppLocalizations localizations) {
    final double? offerPricePerMeter = pricePerMeter;
    if (price == null || offerPricePerMeter == null) return null;
    return localizations.offerPricePerMeter(_formatNumber(localizations, offerPricePerMeter));
  }

  int get plotsCountOrOne => plotsCount > 0 ? plotsCount : 1;

  String metaLabel(AppLocalizations localizations) {
    if (plotsCountOrOne > 1) {
      return localizations.offerMultiLocation(
        localizations.offerPlotCount(plotsCountOrOne),
        _areaLabel(localizations),
        _locationName,
      );
    }
    return areaLocationLabel(localizations);
  }

  String areaLocationLabel(AppLocalizations localizations) {
    return localizations.offerLocation(_areaLabel(localizations), _locationName);
  }

  String _areaLabel(AppLocalizations localizations) => formatArea(localizations, (totalArea ?? 0).round());

  String get _locationName => locationLabel.isNotEmpty ? locationLabel : address;

  String _formatNumber(AppLocalizations localizations, double value) {
    return NumberFormat.decimalPattern(localizations.localeName).format(value.round());
  }
}

extension OfferPlanBadgeLabelExtension on OfferPlanBadge {
  String label(AppLocalizations localizations, {bool withHint = false}) {
    final String badgeLabel = _getBadgeLabel(localizations);
    final PlanHint? planHint = hint;
    if (!withHint || planHint == null) return badgeLabel;
    return localizations.planWithHint(badgeLabel, planHint.label(localizations));
  }

  String _getBadgeLabel(AppLocalizations localizations) {
    final PlanDesignation? planDesignation = designation;
    switch (kind) {
      case OfferPlanBadgeKind.designation:
        final String designationLabel = otherDesignationsCount > 0
            ? localizations.planDesignationWithOthers(planDesignation!.label(localizations), otherDesignationsCount)
            : planDesignation!.label(localizations);
        return basis.labelWithDesignation(localizations, designationLabel);
      case OfferPlanBadgeKind.mixedDesignations:
        return basis.mixedDesignationsLabel(localizations);
      case OfferPlanBadgeKind.basis:
        return basis.label(localizations);
    }
  }
}

extension PlanBasisLabelExtension on PlanBasis {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PlanBasis.unknown:
        return localizations.planBasisLabelUnknown;
      case PlanBasis.mpzp:
      case PlanBasis.mpzpUnreadable:
        return localizations.planBasisLabelMpzp;
      case PlanBasis.pog:
        return localizations.planBasisLabelPog;
      case PlanBasis.wz:
        return localizations.planBasisLabelWz;
      case PlanBasis.pogDraft:
        return localizations.planBasisLabelPogDraft;
      case PlanBasis.studium:
        return localizations.planBasisLabelStudium;
      case PlanBasis.none:
        return localizations.planBasisLabelNone;
      case PlanBasis.mixed:
        return localizations.planBasisLabelMixed;
    }
  }

  String labelWithDesignation(AppLocalizations localizations, String designation) {
    switch (this) {
      case PlanBasis.mpzp:
        return localizations.planWithBasisMpzp(designation);
      case PlanBasis.pog:
        return localizations.planWithBasisPog(designation);
      case PlanBasis.pogDraft:
        return localizations.planWithBasisPogDraft(designation);
      case PlanBasis.studium:
        return localizations.planWithBasisStudium(designation);
      case PlanBasis.mixed:
        return localizations.planWithBasisMixed(designation);
      case PlanBasis.unknown:
      case PlanBasis.mpzpUnreadable:
      case PlanBasis.wz:
      case PlanBasis.none:
        return designation;
    }
  }

  String mixedDesignationsLabel(AppLocalizations localizations) {
    switch (this) {
      case PlanBasis.mpzp:
        return localizations.planMixedDesignationsMpzp;
      case PlanBasis.pog:
        return localizations.planMixedDesignationsPog;
      case PlanBasis.pogDraft:
        return localizations.planMixedDesignationsPogDraft;
      case PlanBasis.studium:
        return localizations.planMixedDesignationsStudium;
      case PlanBasis.mixed:
        return localizations.planMixedDesignationsMixed;
      case PlanBasis.unknown:
      case PlanBasis.mpzpUnreadable:
      case PlanBasis.wz:
      case PlanBasis.none:
        return label(localizations);
    }
  }
}

extension PlanDesignationLabelExtension on PlanDesignation {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PlanDesignation.residential:
        return localizations.planDesignationResidential;
      case PlanDesignation.residentialServices:
        return localizations.planDesignationResidentialServices;
      case PlanDesignation.farmstead:
        return localizations.planDesignationFarmstead;
      case PlanDesignation.recreation:
        return localizations.planDesignationRecreation;
      case PlanDesignation.services:
        return localizations.planDesignationServices;
      case PlanDesignation.industrial:
        return localizations.planDesignationIndustrial;
      case PlanDesignation.agricultural:
        return localizations.planDesignationAgricultural;
      case PlanDesignation.forest:
        return localizations.planDesignationForest;
      case PlanDesignation.green:
        return localizations.planDesignationGreen;
      case PlanDesignation.water:
        return localizations.planDesignationWater;
      case PlanDesignation.transport:
        return localizations.planDesignationTransport;
      case PlanDesignation.infrastructure:
        return localizations.planDesignationInfrastructure;
      case PlanDesignation.cemetery:
        return localizations.planDesignationCemetery;
      case PlanDesignation.open:
        return localizations.planDesignationOpen;
      case PlanDesignation.other:
        return localizations.planDesignationOther;
    }
  }
}

extension PlanHintLabelExtension on PlanHint {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PlanHint.wzPossible:
        return localizations.planHintWzPossible;
      case PlanHint.needsMpzp:
        return localizations.planHintNeedsMpzp;
      case PlanHint.checkInfill:
        return localizations.planHintCheckInfill;
      case PlanHint.noWzWithoutPog:
        return localizations.planHintNoWzWithoutPog;
    }
  }
}
