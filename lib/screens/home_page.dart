import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/screens/recognize_page.dart';
import 'package:extract_text/widget/droupdowento.dart';
import 'package:extract_text/widget/droupdownfrom.dart';
import 'package:extract_text/widget/image_crop.dart';
import 'package:extract_text/widget/image_picker.dart';
import 'package:extract_text/widget/model_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SelctLanguageCubit>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              const Text(
                'Translartion ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    "From ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  DropdownMenuLanguageFrom(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "To ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: DroupDownLangageTo(),
                  ),
                ],
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
                            cubit: cubit,
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
                            cubit: cubit,
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
        label: const Text("scan photo"),
      ),
    );
  }
}
