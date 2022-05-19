import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/firebase_database_repository.dart';

class DataController extends GetxController {
  final _firebaseDatabaseController = Get.find<FirebaseDatabaseRepository>();

  Future<List<Pict>> fetchPictos() async =>
      await _firebaseDatabaseController.fetchPictos();

  Future<List<Grupos>> fetchGrupos() async =>
      await _firebaseDatabaseController.fetchGrupos();

  Future<String> uploadImageToStorage({
    required String path,
    required String storageDirectory,
    required String childName,
  }) async =>
      await _firebaseDatabaseController.uploadImageToStorage(
        path: path,
        storageDirectory: storageDirectory,
        childName: childName,
      );


  Future<void> uploadDataToFirebaseRealTime({
    required String data,
    required String type,
  }) async =>
      await _firebaseDatabaseController.uploadDataToFirebaseRealTime(
        data: data,
        type: type,
      );

  Future<void> uploadBoolToFirebaseRealtime({
    required bool data,
    required String type,
  }) async => await _firebaseDatabaseController.uploadBoolToFirebaseRealtime(
    data: data,
    type: type,
  );

  Future<String> uploadImageToStorageForWeb({
    required String storageName,
    required dynamic imageInBytes,
  }) async => await _firebaseDatabaseController.uploadImageToStorageForWeb(
    imageInBytes: imageInBytes,
    storageName: storageName,
  );

  @override
  void onInit() async {
    super.onInit();
  }
}
