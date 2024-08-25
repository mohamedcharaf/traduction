import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trad/LangageCacheHelper.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit< ChangeLocaleState> {
  LocaleCubit() : super( ChangeLocaleState(locale: const Locale("en")));

  Future<void> getSavedLangage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode))); // Ajoutez cette ligne
  }
}
