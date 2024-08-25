import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trad/cubit/locale_cubit.dart';
import 'applocalistions.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLangage(),
        ),
      ],
      child: BlocBuilder<LocaleCubit,  ChangeLocaleState>(
        builder: (context, state) {
       
            return MaterialApp(
              locale: state.locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                if (locale != null && supportedLocales.contains(locale)) {
                  return locale;
                }
                return supportedLocales.first;
              },
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }

          // Show a loading indicator while waiting for locale to be resolved
      
   
      ),
    );
  }
}
