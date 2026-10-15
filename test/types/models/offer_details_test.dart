import 'package:flutter_test/flutter_test.dart';
import 'package:map_maker_new/types/custom_types/offer_utility_summary.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';
import 'package:map_maker_new/types/enum/plot_utility_status.dart';
import 'package:map_maker_new/types/enum/price_verdict.dart';
import 'package:map_maker_new/types/enum/utility_source.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';

import '../../fixtures/offer_details_fixture.dart';

void main() {
  late OfferDetails offerDetails;

  setUp(() {
    offerDetails = OfferDetailsFixture.load();
  });

  test("parses offer fields from the public offer response", () {
    expect(offerDetails.offer.offerId, "e88ce3cb-ab50-49d5-80b9-42c5d15a0eb1");
    expect(offerDetails.offer.price, 204800);
    expect(offerDetails.offer.priceNegotiable, isTrue);
    expect(offerDetails.soldSeparately, isTrue);
    expect(offerDetails.allowMessages, isTrue);
    expect(offerDetails.plots, hasLength(2));
    expect(offerDetails.photos, hasLength(5));
    expect(offerDetails.seller.firstName, "Anna");
    expect(offerDetails.seller.memberSince, DateTime(2026, 9, 29));
    expect(offerDetails.valuation?.priceVerdict, PriceVerdict.above);
    expect(offerDetails.valuation?.total.likelyLow, 54289);
  });

  test("parses plot details", () {
    final plot = offerDetails.plots.first;
    expect(plot.parcelNumber, "169");
    expect(plot.area, 1023.13);
    expect(plot.separatePrice, 89900);
    expect(plot.hasReport, isTrue);
    expect(plot.utilities.first.source, UtilitySource.detected);
  });

  test("computes offer helpers", () {
    expect(offerDetails.plotsCountOrOne, 2);
    expect(offerDetails.separatelyPricedPlots, hasLength(2));
    expect(offerDetails.planSymbols, ["SN"]);
    expect(offerDetails.hasLocalPlanSymbols, isFalse);
    expect(offerDetails.roadAccessPublicEstimate, isNull);
    expect(offerDetails.accessRoads, isEmpty);
    expect(offerDetails.landRegisterNumbers, isEmpty);
  });

  test("summarizes utilities across plots", () {
    final List<OfferUtilitySummary> summaries = OfferUtilitySummary.listFromOfferDetails(offerDetails);
    final Map<OfferUtility, PlotUtilityStatus> statuses = {
      for (final OfferUtilitySummary summary in summaries) summary.utility: summary.status,
    };

    expect(statuses[OfferUtility.electricity], PlotUtilityStatus.atBoundary);
    expect(statuses[OfferUtility.gas], PlotUtilityStatus.notAvailable);
    expect(summaries.first.source, UtilitySource.detected);
  });
}
