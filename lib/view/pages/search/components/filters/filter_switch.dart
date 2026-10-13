import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class FilterSwitch extends StatelessWidget {
  const FilterSwitch({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      activeTrackColor: ColorConstants.bgBrand,
      title: Text(label, style: textTheme.bodyBase16),
      subtitle: Text(
        hint,
        style: textTheme.caption12.copyWith(color: ColorConstants.textMuted),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
