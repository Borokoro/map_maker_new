import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_utility_summary.dart';
import 'package:map_maker_new/types/enum/access_road_type.dart';
import 'package:map_maker_new/types/enum/connection_location.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/enum/utility_source.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/utils/offer_utility_icon_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';
import 'package:map_maker_new/view/pages/offer/components/utilities/offer_utility_tile.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferUtilitiesSection extends StatelessWidget {
  const OfferUtilitiesSection({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  static const double _tilesSpacing = 12;
  static const int _tilesPerRow = 2;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(
          overline: localizations.offerUtilitiesOverline,
          title: localizations.offerUtilitiesTitle,
          subtitle: localizations.offerUtilitiesSubtitle,
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double tileWidth = (constraints.maxWidth - _tilesSpacing * (_tilesPerRow - 1)) / _tilesPerRow;
            return Wrap(
              spacing: _tilesSpacing,
              runSpacing: _tilesSpacing,
              children: [
                ...OfferUtilitySummary.listFromOfferDetails(offerDetails).map(
                  (OfferUtilitySummary summary) =>
                      SizedBox(width: tileWidth, child: _getUtilityTile(localizations, summary)),
                ),
                SizedBox(width: tileWidth, child: _getRoadTile(localizations)),
              ],
            );
          },
        ),
      ].withVerticalElementsSpacing(16),
    );
  }

  Widget _getUtilityTile(AppLocalizations localizations, OfferUtilitySummary summary) {
    final UtilitySource? source = summary.source;
    final double? distanceToNetwork = summary.distanceToNetwork;
    final String? declaration = _getDeclaration(localizations, summary);

    return OfferUtilityTile(
      icon: summary.utility.icon,
      name: summary.utility.label(localizations),
      status: summary.status.label(localizations),
      tone: summary.status.tone,
      sourceIcon: source == null
          ? null
          : (source == UtilitySource.owner ? IconConstants.owner : IconConstants.detected),
      sourceLabel: source?.label(localizations),
      note: !summary.status.isAvailable && distanceToNetwork != null
          ? localizations.offerUtilityNetworkDistance(OfferFormatters.formatDistance(localizations, distanceToNetwork))
          : null,
      declaration: declaration,
      declarationLabel: localizations.offerSellerDeclaration,
    );
  }

  String? _getDeclaration(AppLocalizations localizations, OfferUtilitySummary summary) {
    final ConnectionLocation? location = summary.connectionLocation;
    final bool? isAccepted = summary.connectionAccepted;
    final List<String> parts = [];
    if (location != null) {
      parts.add(location.label(localizations));
    }
    if (isAccepted == true) {
      parts.add(localizations.offerConnectionAccepted);
    } else if (isAccepted == false) {
      parts.add(localizations.offerConnectionNotAccepted);
    }
    return parts.isEmpty ? null : parts.join(localizations.textSeparator);
  }

  Widget _getRoadTile(AppLocalizations localizations) {
    final List<AccessRoadType> roads = offerDetails.accessRoads;
    final bool? isPublicEstimate = roads.isEmpty ? offerDetails.roadAccessPublicEstimate : null;

    return OfferUtilityTile(
      icon: IconConstants.road,
      name: localizations.offerUtilitiesRoad,
      status: roads.isEmpty
          ? localizations.offerUtilityStatusUnknown
          : roads.map((AccessRoadType road) => road.label(localizations)).join(", "),
      tone: roads.isEmpty
          ? PlanBadgeTone.neutral
          : roads.any((AccessRoadType road) => road.isPaved)
          ? PlanBadgeTone.success
          : PlanBadgeTone.warning,
      note: isPublicEstimate == null
          ? null
          : isPublicEstimate
          ? localizations.offerRoadEstimatePublic
          : localizations.offerRoadEstimatePrivate,
    );
  }
}
