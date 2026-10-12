import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/view/shared_components/widgets/universal_app_bar_widget.dart';

@RoutePage(name: "SearchRoute")
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBarWidget(),
      body: SafeArea(child: _getSearchPage(context)),
    );
  }

  Widget _getSearchPage(BuildContext context) {
    return Center(
      child: Text('Search'),
    );
  }
}
