import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/cubits/signup/signup_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/types/enum/signup_field.dart';
import 'package:map_maker_new/utils/auth_failure_label_extension.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/utils/validation/form_validators.dart';
import 'package:map_maker_new/view/pages/auth/signup/components/signup_footer_widget.dart';
import 'package:map_maker_new/view/pages/auth/signup/components/signup_terms_and_condition_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/back_app_bar_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/failure_box.dart';
import 'package:map_maker_new/view/shared_components/widgets/password_visibility_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/txt_form_field.dart';

@RoutePage(name: "SignupRoute")
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  static const double _elementsSpacing = 20;
  static const double _headerSpacing = 8;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBarWidget(),
      body: SafeArea(
        child: BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(
            serviceLocator.get<AuthService>(),
            serviceLocator.get<AuthCubit>(),
          ),
          child: BlocConsumer<SignupCubit, SignupState>(
            listenWhen: (SignupState previous, SignupState current) =>
                !previous.isRegistered && current.isRegistered,
            listener: _onRegistered,
            builder: _getSignupBody,
          ),
        ),
      ),
    );
  }

  Widget _getSignupBody(BuildContext context, SignupState state) {
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
              ..._getSignupFormFields(context, state),
              SignupTermsAndConditionWidget(enabled: !state.isLoading),
              if (failure != null) FailureBox(text: failure.label(AppLocalizations.of(context)!)),
              _getSignupButton(context, state),
              SignupFooterWidget(onLoginPressed: state.isLoading ? null : () => _goBack(context)),
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
        Text(localizations.signupTitle, style: textTheme.headingH3_24),
        Text(
          localizations.signupSubtitle,
          style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
        ),
      ].withVerticalElementsSpacing(_headerSpacing),
    );
  }

  List<Widget> _getSignupFormFields(BuildContext context, SignupState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return [
      _getTextField(
        context,
        state,
        field: SignupField.firstName,
        controller: _firstName,
        label: localizations.optionalField(localizations.firstName),
        autofillHints: const [AutofillHints.givenName],
      ),
      _getTextField(
        context,
        state,
        field: SignupField.lastName,
        controller: _lastName,
        label: localizations.optionalField(localizations.lastName),
        autofillHints: const [AutofillHints.familyName],
      ),
      _getTextField(
        context,
        state,
        field: SignupField.username,
        controller: _username,
        label: localizations.username,
        autofillHints: const [AutofillHints.newUsername],
        validator: FormValidators.requiredValidator(localizations),
      ),
      _getTextField(
        context,
        state,
        field: SignupField.email,
        controller: _email,
        label: localizations.email,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: FormValidators.emailValidator(localizations),
      ),
      _getPasswordField(context, state),
    ];
  }

  Widget _getTextField(
    BuildContext context,
    SignupState state, {
    required SignupField field,
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    Iterable<String>? autofillHints,
    String? Function(String?)? validator,
  }) {
    return TxtFormField(
      label: label,
      controller: controller,
      validator: validator,
      errorText: state.fieldErrors[field],
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      onChanged: (_) => context.read<SignupCubit>().onFieldChanged(field),
      enabled: !state.isLoading,
    );
  }

  Widget _getPasswordField(BuildContext context, SignupState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TxtFormField(
      label: localizations.password,
      controller: _password,
      validator: FormValidators.passwordValidator(localizations),
      errorText: state.fieldErrors[SignupField.password],
      helperText: localizations.passwordRules(FormValidators.passwordMinLength),
      obscureText: state.isPasswordHidden,
      suffixIcon: PasswordVisibilityButton(
        isPasswordHidden: state.isPasswordHidden,
        onPressed: context.read<SignupCubit>().onShowHidePasswordPressed,
      ),
      autofillHints: const [AutofillHints.newPassword],
      textInputAction: TextInputAction.done,
      onChanged: (_) => context.read<SignupCubit>().onFieldChanged(SignupField.password),
      onSubmitted: (_) => _onSignupPressed(context),
      enabled: !state.isLoading,
    );
  }

  Widget _getSignupButton(BuildContext context, SignupState state) {
    return PrimaryButton(
      text: AppLocalizations.of(context)!.signupSubmit,
      onPressed: () => _onSignupPressed(context),
      isLoading: state.isLoading,
    );
  }

  void _onSignupPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<SignupCubit>().signup(
      username: _username.text,
      email: _email.text,
      password: _password.text,
      firstName: _getOptionalValue(_firstName),
      lastName: _getOptionalValue(_lastName),
    );
  }

  String? _getOptionalValue(TextEditingController controller) {
    final String value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  void _onRegistered(BuildContext context, SignupState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.signupSuccess)),
    );
    _goBack(context);
  }

  void _goBack(BuildContext context) {
    AutoRouter.of(context).maybePop();
  }
}
