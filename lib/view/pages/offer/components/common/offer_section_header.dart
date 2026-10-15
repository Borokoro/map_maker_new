import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferSectionHeader extends StatelessWidget {
  const OfferSectionHeader({super.key, required this.title, this.overline, this.subtitle});

  final String title;
  final String? overline;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? overlineText = overline;
    final String? subtitleText = subtitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (overlineText != null) ...{
          Text(overlineText.toUpperCase(), style: textTheme.overline12.copyWith(color: ColorConstants.textMuted)),
        },
        Text(title, style: textTheme.headingH4_20),
        if (subtitleText != null) ...{
          Text(
            subtitleText,
            style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted, fontWeight: FontWeight.w400),
          ),
        },
      ].withVerticalElementsSpacing(4),
    );
  }
}
