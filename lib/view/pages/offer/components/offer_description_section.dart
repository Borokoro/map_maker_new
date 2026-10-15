import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';

class OfferDescriptionSection extends StatelessWidget {
  const OfferDescriptionSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(
          overline: localizations.offerDescriptionOverline,
          title: localizations.offerDescriptionTitle,
        ),
        Text(description, style: textTheme.bodyBase16.copyWith(color: ColorConstants.textSecondary)),
      ].withVerticalElementsSpacing(12),
    );
  }
}
