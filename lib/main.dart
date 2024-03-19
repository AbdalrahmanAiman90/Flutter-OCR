import 'package:extract_text/screens/recognize_page.dart';
import 'package:extract_text/widget/image_crop.dart';
import 'package:extract_text/widget/image_picker.dart';
import 'package:extract_text/widget/model_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Application for pick image and extract the text and speech this text',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          imagePickerModal(
            context,
            onCameraTap: () {
              //pick image and return path image
              pickImage(source: ImageSource.camera).then((value) {
                if (value != '') {
                  //crop image and retern path crop image
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => RecognizePage(
                            path: value,
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            },
            onGalleryTap: () {
              pickImage(source: ImageSource.gallery).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        //like ios
                        CupertinoPageRoute(
                          builder: (_) => RecognizePage(
                            path: value,
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            },
          );
        },
        label: Text("scan photo"),
      ),
    );
  }
}
