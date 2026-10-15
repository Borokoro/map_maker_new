import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/plan_badge_tone_colors_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferUtilityTile extends StatelessWidget {
  const OfferUtilityTile({
    super.key,
    required this.icon,
    required this.name,
    required this.status,
    required this.tone,
    this.sourceIcon,
    this.sourceLabel,
    this.note,
    this.declaration,
    this.declarationLabel,
  });

  final IconData icon;
  final String name;
  final String status;
  final PlanBadgeTone tone;
  final IconData? sourceIcon;
  final String? sourceLabel;
  final String? note;
  final String? declaration;
  final String? declarationLabel;

  static const double _dotSize = 26;
  static const double _iconSize = 14;
  static const double _sourceIconSize = 12;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle mutedStyle = textTheme.caption12.copyWith(color: ColorConstants.textMuted);
    final IconData? source = sourceIcon;
    final String? sourceText = sourceLabel;
    final String? noteText = note;
    final String? declarationText = declaration;
    final String? declarationLabelText = declarationLabel;

    return Container(
      padding: StyleConstants.edgeInsets12,
      decoration: BoxDecoration(
        borderRadius: StyleConstants.radius12,
        border: Border.all(color: ColorConstants.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(color: tone.backgroundColor, shape: BoxShape.circle),
                child: Icon(icon, size: _iconSize, color: tone.contentColor),
              ),
              Expanded(child: Text(name, style: textTheme.bodySmall14)),
            ].withHorizontalElementsSpacing(8),
          ),
          Text(status, style: textTheme.bodySmall14.copyWith(color: tone.contentColor)),
          if (source != null && sourceText != null) ...{
            Row(
              children: [
                Icon(source, size: _sourceIconSize, color: ColorConstants.textMuted),
                Expanded(child: Text(sourceText, style: mutedStyle)),
              ].withHorizontalElementsSpacing(4),
            ),
          },
          if (noteText != null) ...{
            Text(noteText, style: mutedStyle),
          },
          if (declarationText != null) ...{
            Text(declarationText, style: textTheme.caption12),
          },
          if (declarationText != null && declarationLabelText != null) ...{
            Text(declarationLabelText, style: mutedStyle),
          },
        ].withVerticalElementsSpacing(6),
      ),
    );
  }
}
