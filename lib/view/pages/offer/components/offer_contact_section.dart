import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/cubits/offer/offer_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/contact_failure_type.dart';
import 'package:map_maker_new/types/models/offer_contact.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/failure_box.dart';
import 'package:map_maker_new/view/shared_components/widgets/secondary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferContactSection extends StatelessWidget {
  const OfferContactSection({super.key, required this.state});

  final OfferLoaded state;

  static const String _phoneScheme = "tel";
  static const String _emailScheme = "mailto";
  static const double _contactIconSize = 18;

  static bool isVisible(OfferDetails offerDetails) {
    return !offerDetails.allowMessages ||
        offerDetails.hasPhone ||
        offerDetails.hasEmail ||
        offerDetails.sourceUri != null;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferDetails offerDetails = state.offerDetails;
    final ContactFailureType? contactFailure = state.contactFailure;
    final Uri? sourceUri = offerDetails.sourceUri;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!offerDetails.allowMessages) ...{
          Text(
            localizations.offerSellerMessagesOff,
            style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted, fontWeight: FontWeight.w400),
          ),
        },
        ..._getContactWidgets(context),
        if (contactFailure != null) ...{
          FailureBox(text: _getFailureText(localizations, contactFailure)),
        },
        if (sourceUri != null) ...{
          TextButton.icon(
            onPressed: () => launchUrl(sourceUri, mode: LaunchMode.externalApplication),
            style: TextButton.styleFrom(foregroundColor: ColorConstants.textBrand, textStyle: textTheme.bodySmall14),
            icon: const Icon(IconConstants.openExternal, size: _contactIconSize),
            label: Text(localizations.offerSellerSource),
          ),
        },
      ].withVerticalElementsSpacing(8),
    );
  }

  List<Widget> _getContactWidgets(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final OfferDetails offerDetails = state.offerDetails;
    final OfferContact? contact = state.contact;

    if (contact != null) {
      return [
        if (contact.phone.isNotEmpty) ...{
          _getContactValue(
            context,
            IconConstants.phone,
            contact.phone,
            Uri(scheme: _phoneScheme, path: _getDialablePhone(contact.phone)),
          ),
        },
        if (contact.email.isNotEmpty) ...{
          _getContactValue(context, IconConstants.mail, contact.email, Uri(scheme: _emailScheme, path: contact.email)),
        },
      ];
    }
    final OfferCubit cubit = context.read<OfferCubit>();
    return [
      if (offerDetails.hasPhone) ...{
        SecondaryButton(
          text: localizations.offerContactShowPhone,
          icon: IconConstants.phone,
          isLoading: state.isContactLoading,
          onPressed: cubit.onRevealContactPressed,
        ),
      },
      if (offerDetails.hasEmail) ...{
        SecondaryButton(
          text: localizations.offerContactShowEmail,
          icon: IconConstants.mail,
          isLoading: state.isContactLoading && !offerDetails.hasPhone,
          onPressed: state.isContactLoading ? null : cubit.onRevealContactPressed,
        ),
      },
    ];
  }

  Widget _getContactValue(BuildContext context, IconData icon, String value, Uri uri) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextButton.icon(
      onPressed: () => launchUrl(uri),
      style: TextButton.styleFrom(
        foregroundColor: ColorConstants.textPrimary,
        textStyle: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600),
        alignment: Alignment.centerLeft,
      ),
      icon: Icon(icon, size: _contactIconSize, color: ColorConstants.textBrand),
      label: Text(value),
    );
  }

  String _getDialablePhone(String phone) => phone.replaceAll(RegExp(r"[^\d+]"), "");

  String _getFailureText(AppLocalizations localizations, ContactFailureType failure) {
    switch (failure) {
      case ContactFailureType.missing:
        return localizations.offerContactMissing;
      case ContactFailureType.other:
        return localizations.offerContactError;
    }
  }
}
