import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/public_offers_service.dart';
import 'package:map_maker_new/view/shared_components/widgets/universal_app_bar_widget.dart';

@RoutePage(name: "SearchRoute")
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBarWidget(),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _createSearchCubit(),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: _mapStateToWidget,
          ),
        ),
      ),
    );
  }

  SearchCubit _createSearchCubit() {
    return SearchCubit(serviceLocator.get<PublicOffersService>())
      ..fetchPublicOffers();
  }

  Widget _mapStateToWidget(BuildContext context, SearchState searchState) {
    if (searchState is SearchLoading || searchState is SearchInitial) {
      return _getSearchLoadingBody();
    } else if (searchState is SearchLoaded) {
      return _getSearchLoadedBody(searchState);
    } else {
      return _getSearchErrorBody();
    }
  }

  Widget _getSearchLoadingBody() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getSearchLoadedBody(SearchLoaded state) {
    return Center(child: Text('udalo sie'));
  }

  Widget _getSearchErrorBody() {
    return Center(child: Text('nie udalo sie'));
  }
}
