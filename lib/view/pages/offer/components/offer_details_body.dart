import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/offer/offer_cubit.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/legal/offer_legal_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_build_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_contact_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_description_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_gallery.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_header_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_numbers_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_plots_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_price_section.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_report_cta.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_seller_section.dart';
import 'package:map_maker_new/view/pages/offer/components/utilities/offer_utilities_section.dart';

class OfferDetailsBody extends StatelessWidget {
  const OfferDetailsBody({super.key, required this.state});

  final OfferLoaded state;

  static const double _sectionsSpacing = 32;
  static const double _gallerySpacing = 24;

  @override
  Widget build(BuildContext context) {
    final OfferDetails offerDetails = state.offerDetails;

    return SingleChildScrollView(
      padding: StyleConstants.edgeInsetsB24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OfferGallery(offerDetails: offerDetails),
          Padding(
            padding: StyleConstants.edgeInsetsH16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OfferHeaderSection(offerDetails: offerDetails),
                if (OfferContactSection.isVisible(offerDetails)) ...{
                  OfferContactSection(state: state),
                },
                OfferNumbersSection(offerDetails: offerDetails),
                OfferPriceSection(offerDetails: offerDetails),
                OfferBuildSection(offerDetails: offerDetails, onSeeReportPressed: () {}),
                OfferReportCta(hasReport: offerDetails.firstPlotWithReport != null, onOpenReportPressed: () {}),
                if (offerDetails.plots.isNotEmpty) ...{
                  OfferPlotsSection(offerDetails: offerDetails, onOpenReportPressed: (_) {}),
                },
                OfferUtilitiesSection(offerDetails: offerDetails),
                OfferLegalSection(offerDetails: offerDetails, onDownloadDocumentPressed: (_) {}),
                if (offerDetails.description.isNotEmpty) ...{
                  OfferDescriptionSection(description: offerDetails.description),
                },
                OfferSellerSection(offerDetails: offerDetails),
              ].withVerticalElementsSpacing(_sectionsSpacing),
            ),
          ),
        ].withVerticalElementsSpacing(_gallerySpacing),
      ),
    );
  }
}
