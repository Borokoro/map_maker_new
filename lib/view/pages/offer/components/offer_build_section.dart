import 'package:flutter/material.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_bullet.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/enum/offer_plan_badge_kind.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/enum/plan_hint.dart';
import 'package:map_maker_new/types/enum/plan_type.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/plan_badge_tone_colors_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_bullet_item.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_card_container.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_tone_badge.dart';
import 'package:map_maker_new/view/shared_components/widgets/text_link_button.dart';

class OfferBuildSection extends StatelessWidget {
  const OfferBuildSection({super.key, required this.offerDetails, required this.onSeeReportPressed});

  final OfferDetails offerDetails;
  final VoidCallback onSeeReportPressed;

  static const int _maxPlotResults = 6;
  static const List<PlanHint> _hintsWithoutWz = [PlanHint.needsMpzp, PlanHint.noWzWithoutPog];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferPlanBadge planBadge = OfferPlanBadge.fromOffer(offerDetails.offer);
    final String badgeLabel = planBadge.label(localizations);
    final List<OfferBullet> bullets = planBadge.isMixed
        ? _getPlotResults(localizations)
        : _getBullets(localizations, planBadge);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(overline: localizations.offerBuildOverline, title: localizations.offerBuildTitle),
        OfferCardContainer(
          tone: planBadge.tone,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planBadge.kind == OfferPlanBadgeKind.basis ? badgeLabel : localizations.offerBuildHeading(badgeLabel),
                style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600, color: planBadge.tone.contentColor),
              ),
              ...bullets.map((OfferBullet bullet) => OfferBulletItem(bullet: bullet)),
              if (offerDetails.firstPlotWithReport != null) ...{
                TextLinkButton(text: localizations.offerBuildSeeReport, onPressed: onSeeReportPressed),
              },
              OfferToneBadge(text: localizations.offerSourceOfficial, tone: PlanBadgeTone.neutral),
            ].withVerticalElementsSpacing(10),
          ),
        ),
      ].withVerticalElementsSpacing(16),
    );
  }

  List<OfferBullet> _getBullets(AppLocalizations localizations, OfferPlanBadge planBadge) {
    final List<OfferBullet> bullets = [];
    final PlanHint? hint = planBadge.hint;
    if (hint != null) {
      bullets.add(_getHintBullet(localizations, hint));
    }
    for (final String detail in _getDetails(localizations)) {
      if (planBadge.tone == PlanBadgeTone.success) {
        bullets.add(OfferBullet.positive(detail));
      } else {
        bullets.add(OfferBullet.info(detail));
      }
    }
    return bullets;
  }

  OfferBullet _getHintBullet(AppLocalizations localizations, PlanHint hint) {
    if (hint == PlanHint.wzPossible) {
      return OfferBullet.positive(hint.description(localizations));
    }
    return OfferBullet.warning(hint.description(localizations));
  }

  List<String> _getDetails(AppLocalizations localizations) {
    final List<String> details = [];
    for (final String apiValue in offerDetails.offer.planTypes) {
      final PlanType? planType = PlanType.fromApiValue(apiValue);
      if (planType != null) {
        details.add(planType.label(localizations));
      }
    }
    if (offerDetails.offer.zoneSymbols.isNotEmpty) {
      details.add(localizations.offerBuildZones(offerDetails.offer.zoneSymbols.join(", ")));
    }
    if (offerDetails.offer.pogZoneSymbols.isNotEmpty) {
      details.add(localizations.offerBuildPogZones(offerDetails.offer.pogZoneSymbols.join(", ")));
    }
    return details;
  }

  List<OfferBullet> _getPlotResults(AppLocalizations localizations) {
    final List<OfferBullet> results = [];
    for (final OfferPlot plot in offerDetails.plots.take(_maxPlotResults)) {
      results.add(_getPlotResult(localizations, plot));
    }
    final int hiddenPlotsCount = offerDetails.plots.length - _maxPlotResults;
    if (hiddenPlotsCount > 0) {
      results.add(OfferBullet.info(localizations.offerBuildMore(hiddenPlotsCount)));
    }
    return results;
  }

  OfferBullet _getPlotResult(AppLocalizations localizations, OfferPlot plot) {
    final OfferPlanBadge plotBadge = OfferPlanBadge.fromPlot(plot);
    final String text = localizations.offerBuildPlotResult(
      plot.displayNumber,
      plotBadge.label(localizations, withHint: true),
    );
    if (_hintsWithoutWz.contains(plotBadge.hint) || plotBadge.tone == PlanBadgeTone.warning) {
      return OfferBullet.warning(text);
    } else if (plotBadge.tone == PlanBadgeTone.success) {
      return OfferBullet.positive(text);
    }
    return OfferBullet.info(text);
  }
}
