import 'dart:async' show Future;
import 'dart:convert';
import 'localization_constants.dart';

import 'package:flutter/services.dart' show rootBundle;

Future<String> loadJsonFromAsset(language) async {
  return await rootBundle.loadString('assets/locals/' + language + '.json');
}

Future<Map<String, dynamic>> initLocalization() async {
  Map<String, dynamic> values = {};
  for (String language in LocalizationConstants.languages) {
    Map<String, dynamic> translation =
        json.decode(await loadJsonFromAsset(language));
    values[language] = translation;
  }
  return values;
}
