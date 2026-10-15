import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/secondary_button.dart';

class OfferActionsBar extends StatelessWidget {
  const OfferActionsBar({super.key, required this.onWritePressed, required this.onViewingPressed});

  final VoidCallback onWritePressed;
  final VoidCallback onViewingPressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(color: ColorConstants.bgSurface, border: StyleConstants.borderT1),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: StyleConstants.edgeInsetsH16V12,
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(text: localizations.offerSellerViewing, onPressed: onViewingPressed),
              ),
              Expanded(
                child: PrimaryButton(text: localizations.offerSellerWrite, onPressed: onWritePressed),
              ),
            ].withHorizontalElementsSpacing(12),
          ),
        ),
      ),
    );
  }
}
