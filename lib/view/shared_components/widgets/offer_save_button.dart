import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/view/shared_components/widgets/guarded_tab.dart';

class OfferSaveButton extends StatelessWidget {
  const OfferSaveButton({
    super.key,
    required this.isSaved,
    required this.onPressed,
    this.backgroundColor,
  });

  final bool isSaved;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  static const double _iconSize = 22;

  @override
  Widget build(BuildContext context) {
    return GuardedTab(
      childWhenUnauthenticated: const SizedBox.shrink(),
      childWhenAuthenticated: _getSaveButton(context),
    );
  }

  Widget _getSaveButton(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: isSaved ? localizations.removeFromSaved : localizations.addToSaved,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(backgroundColor: backgroundColor),
      icon: Icon(
        isSaved ? IconConstants.savedFilled : IconConstants.saved,
        color: isSaved ? ColorConstants.iconSaved : ColorConstants.iconDefault,
        size: _iconSize,
      ),
    );
  }
}
