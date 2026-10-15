import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/access_road_type.dart';
import 'package:map_maker_new/types/enum/building_conditions.dart';
import 'package:map_maker_new/types/enum/connection_location.dart';
import 'package:map_maker_new/types/enum/document_type.dart';
import 'package:map_maker_new/types/enum/encumbrance_type.dart';
import 'package:map_maker_new/types/enum/offer_legal_row.dart';
import 'package:map_maker_new/types/enum/offer_number_tile.dart';
import 'package:map_maker_new/types/enum/ownership_type.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/enum/plan_hint.dart';
import 'package:map_maker_new/types/enum/plan_type.dart';
import 'package:map_maker_new/types/enum/plot_utility_status.dart';
import 'package:map_maker_new/types/enum/price_verdict.dart';
import 'package:map_maker_new/types/enum/utility_source.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

extension OfferDetailsLabelsExtension on OfferDetails {
  String title(AppLocalizations localizations) {
    final String offerTitle = offer.title.trim().isNotEmpty
        ? offer.title.trim()
        : localizations.offerFallbackTitle(plotsCountOrOne);
    if (offer.totalArea == null) return offerTitle;
    return localizations.offerTitleWithArea(offerTitle, OfferFormatters.formatAreaValue(localizations, offer.totalArea));
  }

  String subtitle(AppLocalizations localizations) {
    final List<String> parts = [];
    if (offer.address.trim().isNotEmpty) {
      parts.add(offer.address.trim());
    }
    if (locationParts.isNotEmpty) {
      parts.add(locationParts.join(", "));
    }
    if (plotsCountOrOne > 1) {
      parts.add(_getPlotsSaleLabel(localizations));
    }
    return parts.join(localizations.textSeparator);
  }

  String _getPlotsSaleLabel(AppLocalizations localizations) {
    if (soldSeparately) {
      return localizations.offerPlotsSeparately(plotsCountOrOne);
    }
    return localizations.offerPlotsTogether(plotsCountOrOne);
  }

  String terms(AppLocalizations localizations) {
    final List<String> parts = [];
    if (plotsCountOrOne > 1) {
      parts.add(localizations.offerSellerForAll(plotsCountOrOne));
    }
    if (offer.priceNegotiable) {
      parts.add(localizations.offerSellerNegotiable);
    }
    parts.add(localizations.offerSellerNoCommission);
    return parts.join(localizations.textSeparator);
  }

  String plotsTitle(AppLocalizations localizations) {
    final int plotsCount = plots.length;
    if (plotsCount == 1) return localizations.offerPlotsTitleSingle;
    return soldSeparately
        ? localizations.offerPlotsTitleSeparately(plotsCount)
        : localizations.offerPlotsTitleTogether(plotsCount);
  }
}

extension PlanHintDescriptionExtension on PlanHint {
  String description(AppLocalizations localizations) {
    switch (this) {
      case PlanHint.wzPossible:
        return localizations.offerBuildHintWzPossible;
      case PlanHint.needsMpzp:
        return localizations.offerBuildHintNeedsMpzp;
      case PlanHint.checkInfill:
        return localizations.offerBuildHintCheckInfill;
      case PlanHint.noWzWithoutPog:
        return localizations.offerBuildHintNoWzWithoutPog;
    }
  }
}

extension PlanTypeLabelExtension on PlanType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PlanType.mpzp:
        return localizations.offerBuildPlanTypeMpzp;
      case PlanType.pog:
        return localizations.offerBuildPlanTypePog;
      case PlanType.pogDraft:
        return localizations.offerBuildPlanTypePogDraft;
      case PlanType.studium:
        return localizations.offerBuildPlanTypeStudium;
      case PlanType.wz:
        return localizations.offerBuildPlanTypeWz;
      case PlanType.none:
        return localizations.offerBuildPlanTypeNone;
    }
  }
}

extension PriceVerdictLabelExtension on PriceVerdict {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PriceVerdict.below:
        return localizations.offerValuationVerdictBelow;
      case PriceVerdict.market:
        return localizations.offerValuationVerdictMarket;
      case PriceVerdict.above:
        return localizations.offerValuationVerdictAbove;
    }
  }

  String positionLabel(AppLocalizations localizations) {
    switch (this) {
      case PriceVerdict.below:
        return localizations.offerValuationPositionBelow;
      case PriceVerdict.market:
        return localizations.offerValuationPositionMarket;
      case PriceVerdict.above:
        return localizations.offerValuationPositionAbove;
    }
  }

  PlanBadgeTone get tone => this == PriceVerdict.above ? PlanBadgeTone.warning : PlanBadgeTone.success;
}

extension PlotUtilityStatusLabelExtension on PlotUtilityStatus {
  String label(AppLocalizations localizations) {
    switch (this) {
      case PlotUtilityStatus.available:
        return localizations.offerUtilityStatusAvailable;
      case PlotUtilityStatus.atBoundary:
        return localizations.offerUtilityStatusAtBoundary;
      case PlotUtilityStatus.inProgress:
        return localizations.offerUtilityStatusInProgress;
      case PlotUtilityStatus.planned:
        return localizations.offerUtilityStatusPlanned;
      case PlotUtilityStatus.notAvailable:
        return localizations.offerUtilityStatusNotAvailable;
      case PlotUtilityStatus.listed:
        return localizations.offerUtilityStatusListed;
      case PlotUtilityStatus.unknown:
        return localizations.offerUtilityStatusUnknown;
    }
  }

  PlanBadgeTone get tone {
    switch (this) {
      case PlotUtilityStatus.available:
      case PlotUtilityStatus.listed:
        return PlanBadgeTone.success;
      case PlotUtilityStatus.atBoundary:
      case PlotUtilityStatus.inProgress:
      case PlotUtilityStatus.planned:
        return PlanBadgeTone.warning;
      case PlotUtilityStatus.notAvailable:
      case PlotUtilityStatus.unknown:
        return PlanBadgeTone.neutral;
    }
  }
}

extension UtilitySourceLabelExtension on UtilitySource {
  String label(AppLocalizations localizations) {
    switch (this) {
      case UtilitySource.owner:
        return localizations.offerUtilitySourceOwner;
      case UtilitySource.detected:
        return localizations.offerUtilitySourceDetected;
    }
  }
}

extension ConnectionLocationLabelExtension on ConnectionLocation {
  String label(AppLocalizations localizations) {
    switch (this) {
      case ConnectionLocation.onPlot:
        return localizations.offerConnectionOnPlot;
      case ConnectionLocation.atBoundary:
        return localizations.offerConnectionAtBoundary;
      case ConnectionLocation.publicRoad:
        return localizations.offerConnectionPublicRoad;
      case ConnectionLocation.privateRoad:
        return localizations.offerConnectionPrivateRoad;
    }
  }
}

extension AccessRoadTypeLabelExtension on AccessRoadType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case AccessRoadType.asphalt:
        return localizations.offerRoadAsphalt;
      case AccessRoadType.gravel:
        return localizations.offerRoadGravel;
      case AccessRoadType.dirt:
        return localizations.offerRoadDirt;
      case AccessRoadType.easement:
        return localizations.offerRoadEasement;
    }
  }
}

extension OwnershipTypeLabelExtension on OwnershipType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case OwnershipType.full:
        return localizations.offerOwnershipFull;
      case OwnershipType.perpetualUsufruct:
        return localizations.offerOwnershipPerpetualUsufruct;
      case OwnershipType.share:
        return localizations.offerOwnershipShare;
    }
  }
}

extension BuildingConditionsLabelExtension on BuildingConditions {
  String label(AppLocalizations localizations) {
    switch (this) {
      case BuildingConditions.none:
        return localizations.offerConditionsNone;
      case BuildingConditions.zoningDecision:
        return localizations.offerConditionsZoningDecision;
      case BuildingConditions.buildingPermit:
        return localizations.offerConditionsBuildingPermit;
    }
  }
}

extension EncumbranceTypeLabelExtension on EncumbranceType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case EncumbranceType.mortgage:
        return localizations.offerEncumbranceMortgage;
      case EncumbranceType.easement:
        return localizations.offerEncumbranceEasement;
      case EncumbranceType.other:
        return localizations.offerEncumbranceOther;
    }
  }
}

extension DocumentTypeLabelExtension on DocumentType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case DocumentType.landRegisterExtract:
        return localizations.documentTypeLandRegisterExtract;
      case DocumentType.zoningExtract:
        return localizations.documentTypeZoningExtract;
      case DocumentType.surveyMap:
        return localizations.documentTypeSurveyMap;
      case DocumentType.zoningDecision:
        return localizations.documentTypeZoningDecision;
      case DocumentType.connectionAcceptance:
        return localizations.documentTypeConnectionAcceptance;
    }
  }
}

extension OfferNumberTileLabelExtension on OfferNumberTile {
  String label(AppLocalizations localizations, OfferDetails offerDetails) {
    final int symbolsCount = offerDetails.planSymbols.isEmpty ? 1 : offerDetails.planSymbols.length;
    switch (this) {
      case OfferNumberTile.totalArea:
        return localizations.offerNumbersTotalArea;
      case OfferNumberTile.pricePerMeter:
        return localizations.offerNumbersPricePerMeter;
      case OfferNumberTile.plotsCount:
        return localizations.offerNumbersPlots(offerDetails.plotsCountOrOne);
      case OfferNumberTile.planSymbols:
        return offerDetails.hasLocalPlanSymbols || offerDetails.planSymbols.isEmpty
            ? localizations.offerNumbersPlanSymbol(symbolsCount)
            : localizations.offerNumbersPogSymbol(symbolsCount);
    }
  }

  String value(AppLocalizations localizations, OfferDetails offerDetails) {
    final double? pricePerMeter = offerDetails.offer.pricePerMeter;
    switch (this) {
      case OfferNumberTile.totalArea:
        return OfferFormatters.formatAreaValue(localizations, offerDetails.offer.totalArea);
      case OfferNumberTile.pricePerMeter:
        return pricePerMeter != null ? OfferFormatters.formatPricePerMeter(localizations, pricePerMeter) : localizations.offerEmptyValue;
      case OfferNumberTile.plotsCount:
        return offerDetails.plotsCountOrOne.toString();
      case OfferNumberTile.planSymbols:
        return offerDetails.planSymbols.isEmpty ? localizations.offerEmptyValue : offerDetails.planSymbols.join(", ");
    }
  }
}

extension OfferLegalRowLabelExtension on OfferLegalRow {
  String label(AppLocalizations localizations) {
    switch (this) {
      case OfferLegalRow.landRegister:
        return localizations.offerLegalLandRegister;
      case OfferLegalRow.ownership:
        return localizations.offerLegalOwnership;
      case OfferLegalRow.buildingConditions:
        return localizations.offerLegalBuildingConditions;
      case OfferLegalRow.encumbrances:
        return localizations.offerLegalEncumbrances;
    }
  }

  String value(AppLocalizations localizations, OfferDetails offerDetails) {
    switch (this) {
      case OfferLegalRow.landRegister:
        return _joinOrNotProvided(localizations, offerDetails.landRegisterNumbers);
      case OfferLegalRow.ownership:
        return _joinOrNotProvided(
          localizations,
          offerDetails.ownershipTypes.map((OwnershipType type) => type.label(localizations)).toList(),
        );
      case OfferLegalRow.buildingConditions:
        return _joinOrNotProvided(
          localizations,
          offerDetails.buildingConditions
              .map((BuildingConditions conditions) => conditions.label(localizations))
              .toList(),
        );
      case OfferLegalRow.encumbrances:
        return offerDetails.encumbrances.isEmpty
            ? localizations.offerLegalNoneReported
            : offerDetails.encumbrances.map((EncumbranceType type) => type.label(localizations)).join(", ");
    }
  }

  String _joinOrNotProvided(AppLocalizations localizations, List<String> values) {
    return values.isEmpty ? localizations.offerLegalNotProvided : values.join(", ");
  }
}
