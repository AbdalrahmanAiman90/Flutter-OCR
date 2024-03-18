import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  // i want to show circalerindidictor
  bool _isBusy = false;
// the text will extract from image
  String controller = '';
// instance to speech
  FlutterTts tt = FlutterTts();

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
        title: const Text("recognized page"),
      ),
      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: SelectableText(controller),
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              tt.pause();
            },
            label: Icon(Icons.pause),
          ),
          SizedBox(
            height: 15,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (controller != '') {
                tt.setLanguage('en-US');
                tt.speak(controller);
              }
            },
            label: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}
