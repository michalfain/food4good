import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'he'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<Translations>(Translations(locale));
  }

  @override
  bool shouldReload(TranslationsDelegate old) => true;
}
