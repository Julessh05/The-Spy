import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;
import 'package:the_spy/data/translations.dart';

void main() {
  runApp(const SpyGame());
}

final class SpyGame extends StatefulWidget {
  const SpyGame({super.key});

  @override
  State<SpyGame> createState() => _SpyGameState();
}

final class _SpyGameState extends State<SpyGame> {
  @override
  void initState() {
    Translation.init(
      supportedLocales: TranslationLocales.all,
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* DEBUG STUFF */
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      // TODO: change for screenshots
      debugShowCheckedModeBanner: true,
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,

      /* LOCALE */
      locale: Translation.activeLocale,
      supportedLocales: TranslationLocales.all,
      localizationsDelegates: TranslationDelegates.localizationDelegates,

      /* THEME & COLOR */
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,

      /* ROUTING */
      // TODO: add Routing
    );
  }
}
