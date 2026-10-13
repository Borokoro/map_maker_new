import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class RangeFilter extends StatelessWidget {
  const RangeFilter({
    super.key,
    required this.min,
    required this.max,
    required this.rangeMax,
    required this.step,
    required this.formatValue,
    required this.onChanged,
  });

  final int? min;
  final int? max;
  final int rangeMax;
  final int step;
  final String Function(int) formatValue;
  final void Function(int? min, int? max) onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final int start = (min ?? 0).clamp(0, rangeMax);
    final int end = (max ?? rangeMax).clamp(start, rangeMax);

    return Column(
      children: [
        RangeSlider(
          values: RangeValues(start.toDouble(), end.toDouble()),
          max: rangeMax.toDouble(),
          divisions: rangeMax ~/ step,
          activeColor: ColorConstants.bgBrand,
          inactiveColor: ColorConstants.borderDefault,
          onChanged: _onSliderChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatValue(start), style: textTheme.bodySmall14),
            Text(
              max == null ? AppLocalizations.of(context)!.rangeNoLimit(formatValue(rangeMax)) : formatValue(end),
              style: textTheme.bodySmall14,
            ),
          ],
        ),
      ],
    );
  }

  void _onSliderChanged(RangeValues values) {
    final int newMin = values.start.round();
    final int newMax = values.end.round();
    onChanged(
      newMin <= 0 ? null : newMin,
      newMax >= rangeMax ? null : newMax,
    );
  }
}
