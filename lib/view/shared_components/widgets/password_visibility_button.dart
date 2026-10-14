import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';

class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    super.key,
    required this.isPasswordHidden,
    required this.onPressed,
  });

  final bool isPasswordHidden;
  final VoidCallback onPressed;

  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: isPasswordHidden ? localizations.showPassword : localizations.hidePassword,
      onPressed: onPressed,
      icon: Icon(
        isPasswordHidden ? IconConstants.passwordHidden : IconConstants.passwordVisible,
        color: ColorConstants.iconDefault,
        size: _iconSize,
      ),
    );
  }
}
