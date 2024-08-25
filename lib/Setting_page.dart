import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trad/applocalistions.dart';
import 'package:trad/cubit/locale_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr(context)), // Localization function
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<LocaleCubit,  ChangeLocaleState>(
            listener: (context, state) {
          
                Navigator.of(context).pop();
              
            },
            child: BlocBuilder<LocaleCubit,  ChangeLocaleState>(
              builder: (context, state) {
               
                  return DropdownButton<String>(
                    value: state.locale.languageCode, // Default selected value
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ['ar', 'en'].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        context.read<LocaleCubit>().changeLanguage(newValue);
                      }
                    },
                  );
           
              },
            ),
          ),
        ),
      ),
    );
  }
}
