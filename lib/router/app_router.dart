import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter{
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LandingRoute.page,
    initial: true,
    path: "/",
    children: [
      AutoRoute(page: SearchRoute.page, initial: true, path: "search"),
      AutoRoute(page: SavedRoute.page, path: "saved"),
      AutoRoute(page: SellRoute.page, path: "sell"),
      AutoRoute(page: MessagesRoute.page, path: "messages"),
      AutoRoute(page: AccountRoute.page, path: "account"),
    ])
  ];
}