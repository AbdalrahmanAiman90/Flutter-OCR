import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/screens/home_page.dart';
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelctLanguageCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
