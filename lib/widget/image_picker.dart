import 'dart:developer';

import 'package:image_picker/image_picker.dart';

Future<String> pickImage({ImageSource? source}) async {
  //instance from ImagePicker
  final picker = ImagePicker();

  String path = '';

  try {
    //pick image
    final getImage = await picker.pickImage(source: source!);
//if choose image else not
    if (getImage != null) {
      //path image
      path = getImage.path;
    } else {
      path = '';
    }
  } catch (e) {
    log(e.toString());
  }
  return path;
}
