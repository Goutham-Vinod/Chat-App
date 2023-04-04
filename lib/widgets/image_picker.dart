import 'dart:io';

import 'package:image_picker/image_picker.dart';

getImageFromCamera(context) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      File setDpImage = File(image.path);
      // return setDpImage;
    }
  } catch (e) {
    print("Error at getImageFromCamera");
  }
}

getImageFromGallery(context) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File setDpImage = File(image.path);
      // return setDpImage;
    }
  } catch (e) {
    print("Error at getImageFromGallery");
  }
}
