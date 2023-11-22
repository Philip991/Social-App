import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirebaseService{
  static Future<String> uploadImage(File imageFile) async{
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');

      await storageReference.putFile(imageFile);

      return 'Image uploaded successfully!';
    } catch (e) {
      print(e.toString());
      return 'Error uploading image.';
    }
  }
}
