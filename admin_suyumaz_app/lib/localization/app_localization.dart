import 'dart:async' show Future;

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

import 'localization_constants.dart';

class AppLocalizations {
  final Map<String, dynamic> localizedValues;

  AppLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  Map<String, dynamic> localizedValues;

  AppLocalizationsDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) =>
      LocalizationConstants.languages.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
        AppLocalizations(locale, localizedValues));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
