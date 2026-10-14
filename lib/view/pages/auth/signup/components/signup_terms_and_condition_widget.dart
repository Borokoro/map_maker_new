import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/app_constants.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/router/app_router.gr.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class SignupTermsAndConditionWidget extends StatefulWidget {
  const SignupTermsAndConditionWidget({super.key, this.enabled = true});

  final bool enabled;

  @override
  State<SignupTermsAndConditionWidget> createState() => _SignupTermsAndConditionWidgetState();
}

class _SignupTermsAndConditionWidgetState extends State<SignupTermsAndConditionWidget> {
  late final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer()..onTap = _openTerms;
  late final TapGestureRecognizer _privacyPolicyRecognizer = TapGestureRecognizer()..onTap = _openPrivacyPolicy;

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyPolicyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return FormField<bool>(
      initialValue: false,
      enabled: widget.enabled,
      validator: (bool? isAccepted) => isAccepted == true ? null : localizations.termsRequired,
      builder: _getTermsField,
    );
  }

  Widget _getTermsField(FormFieldState<bool> field) {
    final String? errorText = field.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getCheckboxRow(field),
        if (errorText != null) _getErrorText(errorText),
      ].withVerticalElementsSpacing(4),
    );
  }

  Widget _getCheckboxRow(FormFieldState<bool> field) {
    return Row(
      children: [
        Checkbox(
          value: field.value ?? false,
          onChanged: widget.enabled ? field.didChange : null,
          activeColor: ColorConstants.bgBrand,
          side: BorderSide(
            color: field.hasError ? ColorConstants.textDanger : ColorConstants.borderStrong,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: widget.enabled ? () => field.didChange(!(field.value ?? false)) : null,
            child: _getTermsText(),
          ),
        ),
      ],
    );
  }

  Widget _getTermsText() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle textStyle = textTheme.bodySmall14.copyWith(color: ColorConstants.textSecondary);
    final TextStyle linkStyle = textStyle.copyWith(
      color: ColorConstants.textBrand,
      decoration: TextDecoration.underline,
      decorationColor: ColorConstants.textBrand,
    );

    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: localizations.termsAcceptPrefix),
          TextSpan(text: localizations.termsLink, style: linkStyle, recognizer: _termsRecognizer),
          TextSpan(text: localizations.termsAnd),
          TextSpan(text: localizations.privacyPolicyLink, style: linkStyle, recognizer: _privacyPolicyRecognizer),
        ],
      ),
    );
  }

  Widget _getErrorText(String errorText) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: StyleConstants.edgeInsetsL48,
      child: Text(errorText, style: textTheme.caption12.copyWith(color: ColorConstants.textDanger)),
    );
  }

  void _openTerms() {
    AutoRouter.of(context).push(
      WebViewRoute(title: AppLocalizations.of(context)!.termsTitle, url: AppConstants.termsUrl),
    );
  }

  void _openPrivacyPolicy() {
    AutoRouter.of(context).push(
      WebViewRoute(title: AppLocalizations.of(context)!.privacyPolicyTitle, url: AppConstants.privacyPolicyUrl),
    );
  }
}
