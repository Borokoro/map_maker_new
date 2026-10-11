import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/theme/app_theme.dart';
import 'package:map_maker_new/types/enum/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale.fromSubtags(languageCode: Language.pl.langCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),

    );
  }
}
