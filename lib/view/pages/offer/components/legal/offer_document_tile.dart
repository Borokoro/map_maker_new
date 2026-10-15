import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/document_type.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/models/plot_document.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_tone_badge.dart';
import 'package:map_maker_new/view/shared_components/widgets/text_link_button.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferDocumentTile extends StatelessWidget {
  const OfferDocumentTile({
    super.key,
    required this.document,
    required this.plotNumber,
    required this.onDownloadPressed,
  });

  final PlotDocument document;
  final String? plotNumber;
  final VoidCallback onDownloadPressed;

  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String typeLabel = _getTypeLabel(localizations);
    final String meta = _getMeta(localizations, typeLabel);

    return Container(
      padding: StyleConstants.edgeInsets12,
      decoration: BoxDecoration(
        borderRadius: StyleConstants.radius12,
        border: Border.all(color: ColorConstants.borderDefault),
      ),
      child: Row(
        children: [
          const Icon(IconConstants.document, size: _iconSize, color: ColorConstants.textBrand),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(document.title.isNotEmpty ? document.title : typeLabel, style: textTheme.bodySmall14),
                if (document.isVerified) ...{
                  OfferToneBadge(
                    text: localizations.offerDocumentVerified,
                    tone: PlanBadgeTone.success,
                    icon: IconConstants.verified,
                  ),
                },
                if (meta.isNotEmpty) ...{
                  Text(meta, style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
                },
              ].withVerticalElementsSpacing(4),
            ),
          ),
          TextLinkButton(text: localizations.offerDocumentDownload, onPressed: onDownloadPressed),
        ].withHorizontalElementsSpacing(12),
      ),
    );
  }

  String _getMeta(AppLocalizations localizations, String typeLabel) {
    final List<String> parts = [];
    final String? fileExtension = document.fileExtension;
    final String? fileSize = OfferFormatters.formatFileSize(localizations, document.documentSize);
    final String? plot = plotNumber;
    if (document.title.isNotEmpty && typeLabel.isNotEmpty) {
      parts.add(typeLabel);
    }
    if (fileExtension != null && fileExtension.isNotEmpty) {
      parts.add(fileExtension.toUpperCase());
    }
    if (fileSize != null) {
      parts.add(fileSize);
    }
    if (plot != null) {
      parts.add(localizations.offerDocumentPlot(plot));
    }
    return parts.join(localizations.textSeparator);
  }

  String _getTypeLabel(AppLocalizations localizations) {
    return DocumentType.fromApiValue(document.documentType)?.label(localizations) ?? document.documentType;
  }
}
