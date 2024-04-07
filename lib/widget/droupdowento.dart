import 'dart:developer';

import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DroupDownLangageTo extends StatefulWidget {
  const DroupDownLangageTo({super.key});

  @override
  State<DroupDownLangageTo> createState() => _DroupDownLangageToState();
}

class _DroupDownLangageToState extends State<DroupDownLangageTo> {
  String? selectedLanguage;

  final Map<String, String> languages = {
    "Arabic": "ar",
    "English": "en",
    "Italian": "it",
    "French": "fr",
    "German": "de",
    "Japanese": "ja",
    "Russian": "ru",
    "Hindi": "hi",
    "Turkish": "tr",
    "Spanish": "es",
    "Korean": "ko"
  };

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SelctLanguageCubit>(context);

    log("$selectedLanguage");
    return Padding(
      padding: EdgeInsets.only(right: 3),
      child: Container(
        color: Colors.blue,
        child: DropdownButton<String>(
          hint: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("choose language"),
          ),
          dropdownColor: Color.fromARGB(255, 126, 145, 180),
          value: selectedLanguage, //القيمه النهائيه الي ظهرت
          items: languages.entries
              .map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
            return DropdownMenuItem<String>(
              value: entry.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(entry.key),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            cubit.tolanguage = newValue;
            setState(() {
              selectedLanguage = newValue;
            });
          },
        ),
      ),
    );
  }
}
