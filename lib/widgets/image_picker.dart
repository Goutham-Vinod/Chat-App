import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

getImageFromCamera(context) async {
  // try {
  final image = await ImagePicker().pickImage(source: ImageSource.camera);
  if (image != null) {
    File setDpImage = File(image.path);
    return setDpImage;
  }
  // } catch (e) {
  //   print("Error at getImageFromCamera");
  // }
}

Future getImageFromGallery(context) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File setDpImage = File(image.path);
      return setDpImage;
    }
  } catch (e) {
    print("Error at getImageFromGallery");
  }
}

Future<String> uploadFile(File image) async {
  String downloadURL;
  String postId = DateTime.now().millisecondsSinceEpoch.toString();
  Reference ref =
      FirebaseStorage.instance.ref().child("images").child("post_$postId.jpg");

  await ref.putFile(image);
  downloadURL = await ref.getDownloadURL();
  return downloadURL;
}

deleteFileFromFirebase(String url) {
  FirebaseStorage.instance.refFromURL(url).delete();
}
