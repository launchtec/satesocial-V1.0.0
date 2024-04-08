import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sate_social/core/data/data_sources/response.dart';

class StorageDataSource {
  FirebaseStorage instance = FirebaseStorage.instance;

  Future<Response<String>> uploadUserProfilePhoto(
      String filePath, String userId) async {
    String userPhotoPath = "user_photos/$userId/profile_photo";

    try {
      await instance.ref(userPhotoPath).putFile(File(filePath));
      String downloadUrl = await instance.ref(userPhotoPath).getDownloadURL();
      return Response.success(downloadUrl);
    } catch (e) {
      return Response.error(((e as FirebaseException).message ?? e.toString()));
    }
  }

  Future<Response<String>> uploadUserGigDocument(
      String filePath, String fileName, String userId) async {
    String userFilePath = "user_docs/$userId/$fileName";

    try {
      await instance.ref(userFilePath).putFile(File(filePath));
      String downloadUrl = await instance.ref(userFilePath).getDownloadURL();
      return Response.success(downloadUrl);
    } catch (e) {
      return Response.error(((e as FirebaseException).message ?? e.toString()));
    }
  }
}