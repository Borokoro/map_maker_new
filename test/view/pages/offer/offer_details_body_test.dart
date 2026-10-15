import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/cubits/offer/offer_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/services/offer_service.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/services/token_storage.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/view/pages/offer/components/offer_details_body.dart';

import '../../../fixtures/offer_details_fixture.dart';

void main() {
  setUpAll(() {
    serviceLocator.registerSingleton<AuthCubit>(AuthCubit(AuthService(dio: Dio(), tokenStorage: TokenStorage())));
  });

  testWidgets("renders offer details sections", (WidgetTester tester) async {
    final OfferDetails offerDetails = OfferDetailsFixture.load();
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale("pl"),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: BlocProvider<OfferCubit>(
          create: (_) => OfferCubit(OfferService(dio: Dio()), SavedOffersService(dio: Dio())),
          child: Scaffold(
            body: OfferDetailsBody(state: OfferLoaded(offerDetails: offerDetails)),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining("2 działki — Miastko"), findsOneWidget);
    expect(find.text("Najważniejsze liczby"), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text("Zobacz szacunek PlotFinder"),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text("Zobacz szacunek PlotFinder"));
    await tester.pump();
    await tester.tap(find.text("Zobacz szacunek PlotFinder"));
    await tester.pump();
    expect(find.text("Ocena ceny"), findsOneWidget);
    expect(find.text("Powyżej rynku"), findsOneWidget);

    await tester.scrollUntilVisible(find.text("Co jest na działce"), 300, scrollable: find.byType(Scrollable).first);
    expect(find.text("Co jest na działce"), findsOneWidget);

    await tester.scrollUntilVisible(find.text("Własność i dokumenty"), 300, scrollable: find.byType(Scrollable).first);
    expect(find.text("Własność i dokumenty"), findsOneWidget);
  });
}
