import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/models/auth_user.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class AccountDetails extends StatelessWidget {
  AccountDetails({super.key});

  final AuthCubit _authCubit = serviceLocator.get<AuthCubit>();

  static const double _accountIconSize = 48;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: _authCubit,
      builder: _getAccountDetailsBody,
    );
  }

  Widget _getAccountDetailsBody(BuildContext context, AuthState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AuthUser? user = state is AuthAuthenticated ? state.user : null;

    return Padding(
      padding: StyleConstants.edgeInsetsH20V24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(IconConstants.account, color: ColorConstants.iconDefault, size: _accountIconSize),
          Text(
            user != null ? localizations.loggedInAs(user.username) : localizations.loggedIn,
            style: textTheme.headingH4_20,
            textAlign: TextAlign.center,
          ),
          OutlinedButton.icon(
            onPressed: _authCubit.logout,
            icon: const Icon(IconConstants.logout),
            label: Text(localizations.logout),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorConstants.textDanger,
              side: const BorderSide(color: ColorConstants.borderDefault),
              shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radius12),
            ),
          ),
        ].withVerticalElementsSpacing(16),
      ),
    );
  }
}
