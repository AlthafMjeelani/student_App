import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicProvider with ChangeNotifier {
  File? image;
  Future<void> getimage() async {
    final pikImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pikImage == null) {
      return;
    } else {
      final imageTemp = File(pikImage.path);

      image = imageTemp;
      log("image picked ");
      notifyListeners();
    }
  }
}
