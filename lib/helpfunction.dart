import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:translator/translator.dart';

// translat(
//     {required String from, required String to, required String text}) async {
//   final translator = GoogleTranslator();
//   var textTranslation = await translator.translate(text, from: from, to: to);
//   // prints Hello. Are you okay?
//   return textTranslation.text;

//   // prints exemplo
// }

Future<void> play(
    {required String language,
    required FlutterTts tts,
    required String text}) async {
  try {
    await tts.setSpeechRate(0.5); // Decrease speed by 50%

    await tts.setLanguage(language); // Change language to German

    final voices = await tts.getVoices;
    print(voices);
    await tts.speak(text);
  } on Exception catch (e) {
    print(e);
  }
}

Future<String> processImage(InputImage image) async {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  log(image.filePath!);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(image);
  return recognizedText.text;
}
