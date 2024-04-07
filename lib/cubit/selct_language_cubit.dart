import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:translator/translator.dart';

part 'selct_language_state.dart';

class SelctLanguageCubit extends Cubit<SelctLanguageState> {
  SelctLanguageCubit() : super(SelctLanguageInitial());

  final translator = GoogleTranslator();

  String? textbefortrans;
  String? textAftertrans;
  String? fromlanguage;
  String? tolanguage;

  translat({required String text}) async {
    emit(SelctLanguageLooding());

    final translator = GoogleTranslator();
    log("${text}");
    log("cubit from:${fromlanguage}");
    log("cubit to:${tolanguage}");

    try {
      var textTranslation = await translator.translate(text,
          from: fromlanguage ?? "en", to: tolanguage ?? "en");
      // prints Hello. Are you okay?

      textAftertrans = textTranslation.text;

      emit(SelctLanguageSuccses());
    } on Exception catch (e) {
      emit(SelctLanguageFaliuer());
    }

    // prints exemplo
  }

  @override
  void onChange(Change<SelctLanguageState> change) {
    // TODO: implement onChange
    print(change);
  }
}
