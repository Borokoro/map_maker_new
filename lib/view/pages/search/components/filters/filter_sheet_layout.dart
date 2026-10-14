import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';

class FilterSheetLayout extends StatelessWidget {
  const FilterSheetLayout({
    super.key,
    required this.title,
    required this.body,
    required this.applyText,
    required this.clearText,
    required this.onApply,
    required this.onClear,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final String applyText;
  final String clearText;
  final void Function() onApply;
  final void Function() onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHeader(context),
          Flexible(
            child: SingleChildScrollView(
              padding: StyleConstants.edgeInsetsH20,
              child: body,
            ),
          ),
          _getFooter(context),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: StyleConstants.edgeInsetsH20V12,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.headingH4_20),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: textTheme.caption12.copyWith(color: ColorConstants.textMuted),
                  ),
              ],
            ),
          ),
          IconButton(
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(IconConstants.close, color: ColorConstants.iconDefault),
          ),
        ].withHorizontalElementsSpacing(8),
      ),
    );
  }

  Widget _getFooter(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: StyleConstants.edgeInsetsH20V12,
        decoration: const BoxDecoration(border: StyleConstants.borderT1),
        child: Row(
          children: [
            TextButton(
              onPressed: onClear,
              style: TextButton.styleFrom(foregroundColor: ColorConstants.textSecondary),
              child: Text(clearText),
            ),
            Expanded(
              child: PrimaryButton(
                text: applyText,
                onPressed: onApply,
              ),
            ),
          ].withHorizontalElementsSpacing(12),
        ),
      ),
    );
  }
}
