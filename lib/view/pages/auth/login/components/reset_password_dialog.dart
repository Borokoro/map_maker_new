import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/reset_password/reset_password_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/utils/auth_failure_label_extension.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/utils/validation/form_validators.dart';
import 'package:map_maker_new/view/shared_components/widgets/failure_box.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/txt_form_field.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _email = TextEditingController(text: widget.initialEmail);

  static const double _headerIconSize = 40;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstants.bgSurface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radius12),
      insetPadding: StyleConstants.edgeInsets16,
      child: BlocProvider<ResetPasswordCubit>(
        create: (_) => ResetPasswordCubit(serviceLocator.get<AuthService>()),
        child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(builder: _getDialogBody),
      ),
    );
  }

  Widget _getDialogBody(BuildContext context, ResetPasswordState state) {
    final String? sentToEmail = state.sentToEmail;

    return SingleChildScrollView(
      padding: StyleConstants.edgeInsets20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getCloseButton(context),
          if (sentToEmail != null) ..._getEmailSentContent(context, sentToEmail),
          if (sentToEmail == null) ..._getResetPasswordForm(context, state),
        ],
      ),
    );
  }

  Widget _getCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        onPressed: () => _closeDialog(context),
        icon: const Icon(IconConstants.close, color: ColorConstants.iconDefault),
      ),
    );
  }

  List<Widget> _getResetPasswordForm(BuildContext context, ResetPasswordState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AuthFailureType? failure = state.failure;

    return [
      _getHeader(
        context,
        icon: IconConstants.lock,
        title: localizations.resetPasswordTitle,
        description: localizations.resetPasswordSubtitle,
      ),
      Form(key: _formKey, child: _getEmailField(context, state)),
      if (failure != null) FailureBox(text: failure.label(localizations)),
      PrimaryButton(
        text: localizations.resetPasswordSubmit,
        onPressed: () => _onSendPressed(context),
        isLoading: state.isLoading,
      ),
    ].withVerticalElementsSpacing(16);
  }

  List<Widget> _getEmailSentContent(BuildContext context, String email) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return [
      _getHeader(
        context,
        icon: IconConstants.mail,
        title: localizations.resetPasswordSentTitle,
        description: localizations.resetPasswordSent(email),
      ),
      PrimaryButton(
        text: localizations.backToLogin,
        onPressed: () => _closeDialog(context),
      ),
    ].withVerticalElementsSpacing(16);
  }

  Widget _getHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(icon, color: ColorConstants.textBrand, size: _headerIconSize),
        Text(title, style: textTheme.headingH4_20, textAlign: TextAlign.center),
        Text(
          description,
          style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
          textAlign: TextAlign.center,
        ),
      ].withVerticalElementsSpacing(8),
    );
  }

  Widget _getEmailField(BuildContext context, ResetPasswordState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TxtFormField(
      label: localizations.email,
      controller: _email,
      validator: FormValidators.emailValidator(localizations),
      errorText: state.emailError,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.done,
      onChanged: (_) => context.read<ResetPasswordCubit>().onEmailChanged(),
      onSubmitted: (_) => _onSendPressed(context),
      enabled: !state.isLoading,
    );
  }

  void _onSendPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<ResetPasswordCubit>().requestPasswordReset(_email.text);
  }

  void _closeDialog(BuildContext context) {
    AutoRouter.of(context).maybePop();
  }
}
