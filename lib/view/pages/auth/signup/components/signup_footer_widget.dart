import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/text_link_button.dart';

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({super.key, required this.onLoginPressed});

  final VoidCallback? onLoginPressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localizations.hasAccount,
          style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted),
        ),
        TextLinkButton(text: localizations.loginSubmit, onPressed: onLoginPressed),
      ],
    );
  }
}
