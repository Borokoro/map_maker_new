import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class FailureBox extends StatelessWidget {
  const FailureBox({super.key, required this.text});

  final String text;

  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: StyleConstants.edgeInsets12,
      decoration: const BoxDecoration(
        color: ColorConstants.bgDangerSoft,
        borderRadius: StyleConstants.radius12,
      ),
      child: Row(
        children: [
          const Icon(IconConstants.alert, color: ColorConstants.textDanger, size: _iconSize),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodySmall14.copyWith(color: ColorConstants.textDanger),
            ),
          ),
        ].withHorizontalElementsSpacing(8),
      ),
    );
  }
}
