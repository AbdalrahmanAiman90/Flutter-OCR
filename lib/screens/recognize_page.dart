import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/helpfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class RecognizePage extends StatefulWidget {
  final String path;
  final SelctLanguageCubit cubit;
  const RecognizePage({Key? key, required this.path, required this.cubit})
      : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = true;

  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path);

    processImage(inputImage).then((value) async {
      if (value == "") {
        value = "You have not selected any text";
      }
      await widget.cubit.translat(text: value);
      //translat(from: "de", to: "ja", text: value);
      setState(() {
        _isBusy = false;
      });
    });
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
                child: SelectableText(widget.cubit.textAftertrans!),
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
              await play(
                  language: widget.cubit.tolanguage ?? "en",
                  tts: tts,
                  text: widget.cubit.textAftertrans!);
            },
            label: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }

//function to extract text
}
