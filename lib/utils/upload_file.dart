import 'dart:io';

import 'package:children_now/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFile {
  static Future<String?> uploadPicture(
      File file, String email, String name) async {
    try {
      FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: Bucket);
      UploadTask _uploadTask;
      String filePath =
          'users/$email/${name.replaceAll(' ', '-').replaceAll('/', '_').replaceAll('.', '-')}_${DateTime.now().millisecondsSinceEpoch}';
      _uploadTask = _storage.ref().child(filePath).putFile(file);
      String url = await (await _uploadTask).ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  static Future<void> deletePicture(String urlPhoto) async {
    try {
      FirebaseStorage _stoage = FirebaseStorage.instanceFor(bucket: Bucket);
      await _stoage.refFromURL(urlPhoto).delete();
    } catch (e) {
      return null;
    }
  }
}
