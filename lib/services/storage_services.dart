import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final String personId;
  StorageService(this.personId);
  FirebaseStorage save = FirebaseStorage.instance;

  Future saveImage(String imagePath) async {
    String uuid = Uuid().v4();
    File imageFile = File(imagePath);
    try {
      await save.ref("facedata/${personId}/${uuid}.jpg").putFile(imageFile);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future list1Image() async {
    ListResult list =
        await save.ref("facedata/${personId}").list(ListOptions(maxResults: 1));
    return await save
        .ref("facedata/${personId}/${list.items.first.name}")
        .getDownloadURL();
  }

  Future listImage() async {
    ListResult list = await save.ref("facedata/${personId}").listAll();
    return list;
  }
}
