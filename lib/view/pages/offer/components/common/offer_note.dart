import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferNote extends StatelessWidget {
  const OfferNote({super.key, required this.text, this.icon = IconConstants.info});

  final String text;
  final IconData icon;

  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: _iconSize, color: ColorConstants.textMuted),
        Expanded(
          child: Text(text, style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
        ),
      ].withHorizontalElementsSpacing(6),
    );
  }
}
