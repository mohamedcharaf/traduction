// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;
  AppLocalizations({
    required this.locale,
  });

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  static LocalizationsDelegate<AppLocalizations>delegate = _ApplocalizationsDelegate();

  late Map<String, String> _localizedString;
  Future loadJsonLangage() async {
  try {
    String jsonString = await rootBundle.loadString("assets/long/${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  } catch (e) {
    // Si le fichier de langue n'existe pas, utilisez l'anglais par défaut
    String jsonString = await rootBundle.loadString("assets/long/en.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}
    String translate (String key) => _localizedString[key] ?? "" ;
}
class _ApplocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return true ;
  }

  @override
Future<AppLocalizations> load(Locale locale) async {
  // Vérifiez si la langue est supportée, sinon utilisez l'anglais
  Locale supportedLocale = ['en', 'ar'].contains(locale.languageCode) ? locale : Locale('en');
  AppLocalizations localizations = AppLocalizations(locale: supportedLocale);
  await localizations.loadJsonLangage();
  return localizations;
}

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
