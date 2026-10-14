import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/saved_offers/saved_offers_cubit.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/router/app_router.gr.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/infinite_scroll/infinite_scroll_refresh_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_card.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';

class SavedOffersList extends StatefulWidget {
  const SavedOffersList({super.key});

  @override
  State<SavedOffersList> createState() => _SavedOffersListState();
}

class _SavedOffersListState extends State<SavedOffersList> {
  final SavedOffersCubit _cubit = serviceLocator.get<SavedOffersCubit>();
  final SearchCubit _searchCubit = serviceLocator.get<SearchCubit>();

  static const double _cardsSpacing = 16;
  static const double _headerSpacing = 4;
  static const double _emptyIconSize = 48;

  @override
  void initState() {
    super.initState();
    _cubit.fetchSavedOffers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedOffersCubit, SavedOffersState>(
      bloc: _cubit,
      builder: _mapStateToWidget,
    );
  }

  Widget _mapStateToWidget(BuildContext context, SavedOffersState state) {
    if (state is SavedOffersLoaded) {
      return state.items.isEmpty ? _getEmptyBody(context) : _getOffersList(context, state);
    } else if (state is SavedOffersError) {
      return _getErrorBody(context);
    }
    return const Center(child: CircularProgressIndicator(color: ColorConstants.bgBrand));
  }

  Widget _getOffersList(BuildContext context, SavedOffersLoaded state) {
    return InfiniteScrollRefreshWidget(
      items: [
        _getHeader(context, state.itemsCount),
        ...state.items.map(
          (Offer offer) => OfferCard(offer: offer, onSavePressed: () => _onUnsavePressed(offer.offerId)),
        ),
      ],
      hasReachedEnd: state.hasReachedEnd,
      hasLoadMoreError: state.hasLoadMoreError,
      loadMore: _cubit.loadMore,
      refreshContent: _cubit.refreshSavedOffers,
      itemSpacing: _cardsSpacing,
      padding: StyleConstants.edgeInsetsH16V20,
    );
  }

  Widget _getHeader(BuildContext context, int offersCount) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.savedTitle, style: textTheme.headingH3_24),
        Text(
          localizations.savedSubtitle,
          style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
        ),
        Text(
          localizations.savedCount(offersCount),
          style: textTheme.bodySmall14.copyWith(color: ColorConstants.textSecondary),
        ),
      ].withVerticalElementsSpacing(_headerSpacing),
    );
  }

  Widget _getEmptyBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return _getInfoBody(
      context,
      icon: IconConstants.saved,
      title: localizations.savedEmptyTitle,
      description: localizations.savedEmptyDescription,
      action: PrimaryButton(
        text: localizations.browseOffers,
        onPressed: () => AutoRouter.of(context).navigate(const SearchRoute()),
      ),
    );
  }

  Widget _getErrorBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return _getInfoBody(
      context,
      icon: IconConstants.alert,
      title: localizations.savedLoadingError,
      action: TextButton(onPressed: _cubit.fetchSavedOffers, child: Text(localizations.retry)),
    );
  }

  Widget _getInfoBody(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget action,
    String? description,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: StyleConstants.edgeInsetsH24V32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: _emptyIconSize, color: ColorConstants.iconDefault),
            Text(title, style: textTheme.headingH4_20, textAlign: TextAlign.center),
            if (description != null)
              Text(
                description,
                style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
                textAlign: TextAlign.center,
              ),
            action,
          ].withVerticalElementsSpacing(12),
        ),
      ),
    );
  }

  Future<void> _onUnsavePressed(String offerId) async {
    final bool isSuccess = await _cubit.onUnsavePressed(offerId);
    if (isSuccess) {
      _searchCubit.onOfferSavedChanged(offerId, false);
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.saveOfferError)),
    );
  }
}
