import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferInfoBody extends StatelessWidget {
  const OfferInfoBody({super.key, required this.icon, required this.title, required this.action, this.description});

  final IconData icon;
  final String title;
  final Widget action;
  final String? description;

  static const double _iconSize = 48;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? descriptionText = description;

    return Center(
      child: SingleChildScrollView(
        padding: StyleConstants.edgeInsetsH24V32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: _iconSize, color: ColorConstants.iconDefault),
            Text(title, style: textTheme.headingH4_20, textAlign: TextAlign.center),
            if (descriptionText != null) ...{
              Text(
                descriptionText,
                style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
                textAlign: TextAlign.center,
              ),
            },
            action,
          ].withVerticalElementsSpacing(12),
        ),
      ),
    );
  }
}
