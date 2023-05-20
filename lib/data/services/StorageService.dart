import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app/controller/controller.dart';

class StorageService {
  StorageService._initInstance();

  static final StorageService ins = StorageService._initInstance();

  final _store = FirebaseStorage.instance;

  uploadPostImages(List<File> listImg, int postId) async {
    try {
      List<String> downloadUrls = [];

      await Future.forEach(listImg, (File image) async {
        Reference ref =
            _store.ref().child("post/${UserController().userToken}/$postId/");
        final UploadTask uploadTask = ref.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        final url = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(url);
      });

      return downloadUrls;
    } catch (e) {
      EasyLoading.showToast(e.toString(), toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  Future<String?> uploadZip(File zipFile, int postId) async {
    try {
      Reference ref = _store.ref().child(
          "posts/${UserController().userToken}/$postId/zip/${DateTime.now()}.zip");
      final UploadTask uploadTask = ref.putFile(zipFile);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      EasyLoading.showToast(e.toString(), toastPosition: EasyLoadingToastPosition.bottom);
    }
    log("upload zip null");
    return null;
  }

  Future<String?> uploadAvatar(File image) async {
    try {
      Reference ref = _store
          .ref()
          .child("user/${UserController().userToken}/avatar/avatar.png");
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      EasyLoading.showToast(e.toString(), toastPosition: EasyLoadingToastPosition.bottom);
    }
    return null;
  }
}
