import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/app_constants.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/cubits/offer/offer_cubit.dart';
import 'package:map_maker_new/cubits/saved_offers/saved_offers_cubit.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/router/app_router.gr.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/offer_service.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/types/enum/offer_view_source.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_actions_bar.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_details_body.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_info_body.dart';
import 'package:map_maker_new/view/shared_components/widgets/back_app_bar_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_save_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';

@RoutePage(name: "OfferRoute")
class OfferPage extends StatelessWidget {
  const OfferPage({
    super.key,
    @PathParam("offerId") required this.offerId,
    this.viewSource = OfferViewSource.link,
  });

  final String offerId;
  final OfferViewSource viewSource;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfferCubit>(
      create: _createOfferCubit,
      child: BlocBuilder<OfferCubit, OfferState>(builder: _getScaffold),
    );
  }

  OfferCubit _createOfferCubit(BuildContext context) {
    return OfferCubit(
      serviceLocator.get<OfferService>(),
      serviceLocator.get<SavedOffersService>(),
    )..fetchOffer(offerId, viewSource: viewSource);
  }

  Widget _getScaffold(BuildContext context, OfferState state) {
    return Scaffold(
      appBar: BackAppBarWidget(actions: _getAppBarActions(context, state)),
      body: SafeArea(child: _mapStateToWidget(context, state)),
      bottomNavigationBar:
          state is OfferLoaded && state.offerDetails.allowMessages
          ? OfferActionsBar(onWritePressed: () {}, onViewingPressed: () {})
          : null,
    );
  }

  List<Widget> _getAppBarActions(BuildContext context, OfferState state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return [
      if (state is OfferLoaded) ...{
        OfferSaveButton(
          isSaved: state.offerDetails.offer.isSaved,
          onPressed: () => _onSavePressed(context),
        ),
      },
      IconButton(
        tooltip: localizations.offerCopyLink,
        onPressed: () => _onCopyLinkPressed(context),
        icon: const Icon(
          IconConstants.share,
          color: ColorConstants.textPrimary,
        ),
      ),
    ];
  }

  Widget _mapStateToWidget(BuildContext context, OfferState state) {
    if (state is OfferLoaded) {
      return OfferDetailsBody(state: state);
    } else if (state is OfferError) {
      return _getErrorBody(context, state);
    }
    return const Center(
      child: CircularProgressIndicator(color: ColorConstants.bgBrand),
    );
  }

  Widget _getErrorBody(BuildContext context, OfferError state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    if (state.isNotFound) {
      return OfferInfoBody(
        icon: IconConstants.search,
        title: localizations.offerNotFound,
        description: localizations.offerNotFoundHint,
        action: PrimaryButton(
          text: localizations.browseOffers,
          onPressed: () => AutoRouter.of(context).navigate(const SearchRoute()),
        ),
      );
    }
    return OfferInfoBody(
      icon: IconConstants.alert,
      title: localizations.offerLoadingError,
      action: TextButton(
        onPressed: () => context.read<OfferCubit>().fetchOffer(
          offerId,
          viewSource: viewSource,
        ),
        child: Text(localizations.retry),
      ),
    );
  }

  Future<void> _onSavePressed(BuildContext context) async {
    final OfferCubit cubit = context.read<OfferCubit>();
    final bool isSuccess = await cubit.onSaveOfferPressed();
    final OfferState state = cubit.state;
    if (isSuccess && state is OfferLoaded) {
      serviceLocator.get<SearchCubit>().onOfferSavedChanged(
        offerId,
        state.offerDetails.offer.isSaved,
      );
      serviceLocator.get<SavedOffersCubit>().refreshSavedOffers();
      return;
    } else if (isSuccess || !context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.saveOfferError)),
    );
  }

  Future<void> _onCopyLinkPressed(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(text: "${AppConstants.offersUrl}/$offerId"),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.offerLinkCopied)),
    );
  }
}
