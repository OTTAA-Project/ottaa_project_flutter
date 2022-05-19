import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/firebase_database_service.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseService _firebaseDatabaseService =
      Get.find<FirebaseDatabaseService>();

  Future<List<Pict>> fetchPictos() async =>
      await _firebaseDatabaseService.fetchPictos();

  Future<List<Grupos>> fetchGrupos() async =>
      await _firebaseDatabaseService.fetchGrupos();

  Future<String> uploadImageToStorage({
    required String path,
    required String storageDirectory,
    required String childName,
  }) async =>
      await _firebaseDatabaseService.uploadImageToStorage(
        path: path,
        storageDirectory: storageDirectory,
        childName: childName,
      );

  Future<void> uploadDataToFirebaseRealTime({
    required String data,
    required String type,
  }) async =>
      await _firebaseDatabaseService.uploadDataToFirebaseRealTime(
        data: data,
        type: type,
      );
}
