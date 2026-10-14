import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/cubits/login/login_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/router/app_router.gr.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/utils/auth_failure_label_extension.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/utils/validation/form_validators.dart';
import 'package:map_maker_new/view/pages/auth/login/components/reset_password_dialog.dart';
import 'package:map_maker_new/view/shared_components/widgets/failure_box.dart';
import 'package:map_maker_new/view/shared_components/widgets/password_visibility_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/text_link_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/txt_form_field.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _identifier = TextEditingController();
  final TextEditingController _password = TextEditingController();

  static const double _elementsSpacing = 20;
  static const double _headerSpacing = 8;

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(
        serviceLocator.get<AuthService>(),
        serviceLocator.get<AuthCubit>(),
      ),
      child: BlocBuilder<LoginCubit, LoginState>(builder: _getLoginBody),
    );
  }

  Widget _getLoginBody(BuildContext context, LoginState state) {
    return Column(
      children: [
        Expanded(child: _getLoginForm(context, state)),
        Padding(
          padding: StyleConstants.edgeInsetsH24B16,
          child: _getRegisterButton(context, state),
        ),
      ],
    );
  }

  Widget _getLoginForm(BuildContext context, LoginState state) {
    final AuthFailureType? failure = state.failure;

    return SingleChildScrollView(
      padding: StyleConstants.edgeInsetsH24V32,
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getHeader(context),
              _getIdentifierField(context, state),
              _getPasswordField(context, state),
              if (failure != null) FailureBox(text: failure.label(AppLocalizations.of(context)!)),
              _getLoginButton(context, state),
              _getForgotPasswordButton(context, state),
            ].withVerticalElementsSpacing(_elementsSpacing),
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.loginTitle, style: textTheme.headingH3_24),
        Text(
          localizations.loginSubtitle,
          style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
        ),
      ].withVerticalElementsSpacing(_headerSpacing),
    );
  }

  Widget _getIdentifierField(BuildContext context, LoginState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TxtFormField(
      label: localizations.loginIdentifier,
      controller: _identifier,
      validator: FormValidators.requiredValidator(localizations),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.username, AutofillHints.email],
      enabled: !state.isLoading,
    );
  }

  Widget _getPasswordField(BuildContext context, LoginState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TxtFormField(
      label: localizations.password,
      controller: _password,
      validator: FormValidators.requiredValidator(localizations),
      obscureText: state.isPasswordHidden,
      suffixIcon: PasswordVisibilityButton(
        isPasswordHidden: state.isPasswordHidden,
        onPressed: context.read<LoginCubit>().onShowHidePasswordPressed,
      ),
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _onLoginPressed(context),
      enabled: !state.isLoading,
    );
  }

  Widget _getLoginButton(BuildContext context, LoginState state) {
    return PrimaryButton(
      text: AppLocalizations.of(context)!.loginSubmit,
      onPressed: () => _onLoginPressed(context),
      isLoading: state.isLoading,
    );
  }

  Widget _getForgotPasswordButton(BuildContext context, LoginState state) {
    return Center(
      child: TextLinkButton(
        text: AppLocalizations.of(context)!.forgotPassword,
        onPressed: state.isLoading ? null : () => _openResetPasswordDialog(context),
      ),
    );
  }

  Widget _getRegisterButton(BuildContext context, LoginState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localizations.noAccount,
          style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted),
        ),
        TextLinkButton(
          text: localizations.signupSubmit,
          onPressed: state.isLoading ? null : () => _openSignup(context),
        ),
      ],
    );
  }

  void _onLoginPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<LoginCubit>().login(identifier: _identifier.text, password: _password.text);
  }

  void _openResetPasswordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => ResetPasswordDialog(initialEmail: _getInitialResetEmail()),
    );
  }

  String? _getInitialResetEmail() {
    final String identifier = _identifier.text.trim();
    return identifier.contains("@") ? identifier : null;
  }

  void _openSignup(BuildContext context) {
    AutoRouter.of(context).push(const SignupRoute());
  }
}
