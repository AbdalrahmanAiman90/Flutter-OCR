import 'dart:developer';

import 'package:extract_text/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  String textAfterTranslate = '';
  String textBeforTranslate = '';

  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation page"),
      ),
      body: _isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: SelectableText(textAfterTranslate),
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              tts.pause();
            },
            label: Icon(Icons.pause),
          ),
          SizedBox(height: 15),
          FloatingActionButton.extended(
            onPressed: () async {
              //!function play the text after translate
              await play(language: "ja-JP", tts: tts, text: textAfterTranslate);
            },
            label: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }

//function to extract text
  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    String translateControllar = "";
    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    textBeforTranslate = recognizedText.text;
    //!function to translate text extract from image
    translateControllar =
        await translat(from: "en", to: "ja", text: textBeforTranslate);

    textAfterTranslate = translateControllar;

    setState(() {
      _isBusy = false;
    });
  }
}
