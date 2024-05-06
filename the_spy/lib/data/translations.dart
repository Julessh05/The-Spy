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
  "Game Settings": {
    TranslationLocales.german: "Spiel Einstellungen",
  },
  "Start": {
    TranslationLocales.german: "Start",
  },
};

final Map<String, Map<Locale, String>> _wordtranslations = {
  // Home Words
  "Bedroom": {
    TranslationLocales.german: "Schlafzimmer",
  },
  "Living Room": {
    TranslationLocales.german: "Wohnzimmer",
  },
  "Kitchen": {
    TranslationLocales.german: "Küche",
  },
  "Garage": {
    TranslationLocales.german: "Garage",
  },

  // Country words
  "Germany": {
    TranslationLocales.german: "Deutschland",
  },
  "United States of America": {
    TranslationLocales.german: "Vereinigte Staaten von Amerika",
  },
  "Great Britain": {
    TranslationLocales.german: "Großbritannien",
  },
  "Australia": {
    TranslationLocales.german: "Australien",
  },
  "Switzerland": {
    TranslationLocales.german: "Schweiz",
  },
  "China": {
    TranslationLocales.german: "China",
  },
  "Austria": {
    TranslationLocales.german: "Österreich",
  },
  "France": {
    TranslationLocales.german: "Frankreich",
  },
  // Places words
  "Park": {
    TranslationLocales.german: "Park",
  },
  "Mall": {
    TranslationLocales.german: "Einkaufscenter",
  },
  "Restaurant": {
    TranslationLocales.german: "Restaurant",
  },

  // Food words
  "Burger": {
    TranslationLocales.german: "Burger",
  },
  "Bread": {
    TranslationLocales.german: "Brot",
  },
  "Pizza": {
    TranslationLocales.german: "Pizza",
  },

  // Vehicle words
  "Car": {
    TranslationLocales.german: "Auto",
  },
  "Bus": {
    TranslationLocales.german: "Bus",
  },
  // TODO: fahrrad oder motorrad?
  "Bike": {
    TranslationLocales.german: "Fahrrad",
  },
  "Truck": {
    TranslationLocales.german: "Laster",
  },

  // animal words
  "Horse": {
    TranslationLocales.german: "Pferd",
  },
  "Dog": {
    TranslationLocales.german: "Hund",
  },
  "Cat": {
    TranslationLocales.german: "Katze",
  },
  "Fish": {
    TranslationLocales.german: "Fisch",
  },
  "Mouse": {
    TranslationLocales.german: "Maus",
  },

  // technical words
  "Computer": {
    TranslationLocales.german: "Computer",
  },
  "Camera": {
    TranslationLocales.german: "Kamera",
  },
  "Keyboard": {
    TranslationLocales.german: "Tastatur",
  },
};

/// Getter for the Translations.
/// Adds the Standard Translations to the
/// Custom Translations.
Map<String, Map<Locale, String>> get translations {
  _translations.addAll(StandardTranslations.all);
  _translations.addAll(_wordtranslations);
  return _translations;
}
