import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/cubits/saved_offers/saved_offers_cubit.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filter_button.dart';
import 'package:map_maker_new/view/pages/search/components/offer_preview/offer_preview_card.dart';
import 'package:map_maker_new/view/pages/search/components/offers_map_layer.dart';
import 'package:map_maker_new/view/pages/search/components/quick_filters_horizontal_scrollable.dart';
import 'package:map_maker_new/view/pages/search/components/search_page_map.dart';
import 'package:map_maker_new/view/pages/search/components/searchbar/searchbar_wrapper.dart';
import 'package:map_maker_new/view/shared_components/widgets/universal_app_bar_widget.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

@RoutePage(name: "SearchRoute")
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();
  final AuthCubit _authCubit = serviceLocator.get<AuthCubit>();
  final SavedOffersCubit _savedOffersCubit = serviceLocator.get<SavedOffersCubit>();
  MapboxMap? _mapboxMap;
  String _mapStyleUri = MapboxStyles.STANDARD_SATELLITE;

  @override
  void initState() {
    super.initState();
    if (_cubit.state is SearchInitial) {
      _cubit.fetchPublicOffers();
    }
  }

  static const double _searchControlsTopMargin = 12;
  static const double _searchControlsSpacing = 8;
  static const double _offerPreviewMargin = 16;
  static const double _offerPreviewHeight = OfferPreviewCard.height + _offerPreviewMargin * 2;
  static const double _mapActionsIconSize = 20;
  static const double _searchControlsHeight = _searchControlsTopMargin +
      FilterButton.size +
      _searchControlsSpacing +
      QuickFiltersHorizontalScrollable.quickFiltersHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBarWidget(),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          bloc: _authCubit,
          listenWhen: (AuthState previous, AuthState current) => previous.runtimeType != current.runtimeType,
          listener: (_, _) => _cubit.refreshPublicOffers(),
          child: BlocBuilder<SearchCubit, SearchState>(
            bloc: _cubit,
            builder: _mapStateToWidget,
          ),
        ),
      ),
    );
  }

  Widget _mapStateToWidget(BuildContext context, SearchState searchState) {
    if (searchState is SearchLoading || searchState is SearchInitial) {
      return _getSearchLoadingBody();
    } else if (searchState is SearchLoaded) {
      return _getSearchLoadedBody(context, searchState);
    } else {
      return _getSearchErrorBody(context, searchState as SearchError);
    }
  }

  Widget _getSearchLoadingBody() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getSearchLoadedBody(BuildContext context, SearchLoaded state) {
    final Offer? selectedOffer = _getSelectedOffer(state);

    return Stack(
      children: [
        SearchPageMap(
          offers: state.publicOffers.results,
          selectedOfferId: selectedOffer?.offerId,
          onOfferTap: _cubit.onOfferTapped,
          onMapTap: _cubit.unselectOffer,
          initMapController: (MapboxMap mapboxMap) => _mapboxMap = mapboxMap,
          styleUri: _mapStyleUri,
          searchedLocation: _getSearchedLocation(state.searchCriteria),
          topPadding: _searchControlsHeight,
          bottomPadding: _offerPreviewHeight,
        ),
        _getSearchControls(
          state.searchCriteria,
          isLoading: state is SearchFiltersLoading,
        ),
        Positioned(
          right: _offerPreviewMargin,
          top: _searchControlsHeight + _offerPreviewMargin,
          child: _getMapStyleButton(),
        ),
        Positioned(
          right: _offerPreviewMargin,
          bottom: selectedOffer != null ? _offerPreviewHeight : _offerPreviewMargin,
          child: _getMapActionButton(
            icon: IconConstants.recenter,
            onPressed: _onRecenterClick,
          ),
        ),
        if (selectedOffer != null)
          Positioned(
            left: _offerPreviewMargin,
            right: _offerPreviewMargin,
            bottom: _offerPreviewMargin,
            child: OfferPreviewCard(
              offer: selectedOffer,
              onSavePressed: () => _onSaveOfferPressed(selectedOffer.offerId),
            ),
          ),
      ],
    );
  }

  Widget _getMapStyleButton() {
    final bool isSatellite = _mapStyleUri == MapboxStyles.STANDARD_SATELLITE;
    return _getMapActionButton(
      icon: isSatellite ? IconConstants.standardMap : IconConstants.satelliteMap,
      onPressed: _onMapStyleClick,
    );
  }

  Widget _getMapActionButton({required IconData icon, required VoidCallback onPressed}) {
    return FloatingActionButton(
      heroTag: null,
      elevation: 3,
      highlightElevation: 3,
      backgroundColor: ColorConstants.bgSurface,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: StyleConstants.radius100,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mini: true,
      child: Icon(
        icon,
        color: ColorConstants.textPrimary,
        size: _mapActionsIconSize,
      ),
    );
  }

  void _onMapStyleClick() {
    final String styleUri = _mapStyleUri == MapboxStyles.STANDARD_SATELLITE
        ? MapboxStyles.STANDARD
        : MapboxStyles.STANDARD_SATELLITE;
    setState(() => _mapStyleUri = styleUri);
    _mapboxMap?.loadStyleURI(styleUri);
  }

  void _onRecenterClick() {
    _cubit.unselectOffer();
    _mapboxMap?.flyTo(
      CameraOptions(center: SearchPageMap.polandCenter, zoom: SearchPageMap.polandZoom),
      MapAnimationOptions(duration: OffersMapLayer.flyToDuration),
    );
  }

  Future<void> _onSaveOfferPressed(String offerId) async {
    final bool isSuccess = await _cubit.onSaveOfferPressed(offerId);
    if (isSuccess) {
      _savedOffersCubit.refreshSavedOffers();
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.saveOfferError)),
    );
  }

  Offer? _getSelectedOffer(SearchLoaded state) {
    final String? selectedOfferId = state.selectedOfferId;
    if (selectedOfferId == null) return null;
    for (final Offer offer in state.publicOffers.results) {
      if (offer.offerId == selectedOfferId) return offer;
    }
    return null;
  }

  Widget _getSearchErrorBody(BuildContext context, SearchError state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _getSearchControls(state.searchCriteria),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(localizations.offersLoadingError, style: textTheme.bodyLarge),
                TextButton(
                  onPressed: _cubit.fetchPublicOffers,
                  child: Text(localizations.retry),
                ),
              ].withVerticalElementsSpacing(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getSearchControls(OfferSearchCriteria searchCriteria, {bool isLoading = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: StyleConstants.edgeInsetsH16T12,
          child: SearchbarWrapper(searchCriteria: searchCriteria),
        ),
        QuickFiltersHorizontalScrollable(searchCriteria: searchCriteria),
        if (isLoading)
          const Padding(
            padding: StyleConstants.edgeInsetsH16,
            child: LinearProgressIndicator(
              color: ColorConstants.bgBrand,
              backgroundColor: ColorConstants.bgBrandSoft,
            ),
          ),
      ].withVerticalElementsSpacing(_searchControlsSpacing),
    );
  }

  String? _getSearchedLocation(OfferSearchCriteria searchCriteria) {
    if (!searchCriteria.hasLocation && searchCriteria.query == null) return null;
    return [
      searchCriteria.query,
      searchCriteria.voivodeship,
      searchCriteria.county,
      searchCriteria.commune,
    ].join("|");
  }
}
