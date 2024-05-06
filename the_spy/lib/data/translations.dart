import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations, TranslationLocales;

final Map<String, Map<Locale, String>> _translations = {
  "Welcome": {
    TranslationLocales.german: "Willkommen",
  },
  "New Game": {
    TranslationLocales.german: "Neues Spiel",
  },
  "Categories": {
    TranslationLocales.german: "Kategorien",
  },
};

/// Getter for the Translations.
/// Adds the Standard Translations to the
/// Custom Translations.
Map<String, Map<Locale, String>> get translations {
  _translations.addAll(StandardTranslations.all);
  return _translations;
}
