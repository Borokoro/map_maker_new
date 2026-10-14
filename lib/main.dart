import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/theme/app_theme.dart';
import 'package:map_maker_new/types/enum/language.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'router/app_router.dart';

const String _mapboxAccessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken(_mapboxAccessToken);
  setupDependencies();
  await serviceLocator.get<AuthService>().restoreSession();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MapMakerApp());
}

class MapMakerApp extends StatefulWidget {
  const MapMakerApp({super.key});

  @override
  State<MapMakerApp> createState() => _MapMakerAppState();
}

class _MapMakerAppState extends State<MapMakerApp> {
  late final AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale.fromSubtags(languageCode: Language.pl.langCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      routerConfig: appRouter.config(),
    );
  }
}
