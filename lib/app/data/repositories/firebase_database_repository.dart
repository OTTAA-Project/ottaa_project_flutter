import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
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
    required String languageCode,
  }) async =>
      await _firebaseDatabaseService.uploadDataToFirebaseRealTime(
        data: data,
        type: type,
        languageCode: languageCode,
      );

  Future<void> uploadGruposToFirebaseRealTime({
    required List<Grupos> data,
    required String type,
    required String languageCode,
  }) async =>
      await _firebaseDatabaseService.uploadGruposToFirebaseRealTime(
        data: data,
        type: type,
        languageCode: languageCode,
      );

  Future<void> uploadPictosToFirebaseRealTime({
    required List<Pict> data,
    required String type,
    required String languageCode,
  }) async =>
      await _firebaseDatabaseService.uploadPictosToFirebaseRealTime(
        data: data,
        type: type,
        languageCode: languageCode,
      );

  Future<void> uploadEditingPictoToFirebaseRealTime({
    required Pict data,
    required String type,
    required String languageCode,
    required int index,
  }) async =>
      await _firebaseDatabaseService.uploadEditingPictoToFirebaseRealTime(
        data: data,
        type: type,
        languageCode: languageCode,
        index: index,
      );

  Future<void> uploadGruposEditToFirebaseRealTime({
    required Grupos data,
    required String type,
    required String languageCode,
    required int index,
  }) async =>  await _firebaseDatabaseService.uploadGruposEditToFirebaseRealTime(
    data: data,
    type: type,
    languageCode: languageCode,
    index: index,
  );

  Future<void> uploadBoolToFirebaseRealtime({
    required bool data,
    required String type,
  }) async =>
      await _firebaseDatabaseService.uploadBoolToFirebaseRealtime(
        data: data,
        type: type,
      );

  Future<String> uploadImageToStorageForWeb({
    required String storageName,
    required Uint8List imageInBytes,
  }) async =>
      await _firebaseDatabaseService.uploadImageToStorageForWeb(
        imageInBytes: imageInBytes,
        storageName: storageName,
      );

  Future<void> logFirebaseAnalyticsEvent({required String eventName}) async =>
      await _firebaseDatabaseService.logFirebaseAnalyticsEvent(
        eventName: eventName,
      );

  Future<int> fetchAccountType() async =>
      await _firebaseDatabaseService.fetchAccountType();

  Future<String> fetchUserEmail() async =>
      await _firebaseDatabaseService.fetchUserEmail();

  Future<double> fetchCurrentVersion() async =>
      await _firebaseDatabaseService.fetchCurrentVersion();

  Future<int> getPicNumber() async =>
      await _firebaseDatabaseService.getPicNumber();

  Future<void> uploadAvatar({required int photoNumber}) async =>
      await _firebaseDatabaseService.uploadAvatar(photoNumber: photoNumber);

  Future<void> uploadInfo(
      {required String name,
      required String gender,
      required int dateOfBirthInMs}) async {
    await _firebaseDatabaseService.uploadInfo(
      name: name,
      gender: gender,
      dateOfBirthInMs: dateOfBirthInMs,
    );
  }

  Future<void> saveUserPhotoUrl({required String photoUrl}) async =>
      await _firebaseDatabaseService.saveUserPhotoUrl(photoUrl: photoUrl);

  Future<String> fetchUserPhotoUrl() async =>
      await _firebaseDatabaseService.fetchUserPhotoUrl();

  String fetchCurrentUserUID() =>
      _firebaseDatabaseService.fetchCurrentUserUID();

  Future<List<Pict>> fetchOtherPictos({
    required String languageName,
    required String assetName,
    required String firebaseName,
    required String fileName,
  }) async =>
      await _firebaseDatabaseService.fetchOtherPictos(
        languageName: languageName,
        assetName: assetName,
        firebaseName: firebaseName,
        fileName: fileName,
      );

  Future<List<Grupos>> fetchOtherGrupos({
    required String languageName,
    required String assetName,
    required String firebaseName,
    required String fileName,
  }) async =>
      await _firebaseDatabaseService.fetchOtherGrupos(
        languageName: languageName,
        assetName: assetName,
        firebaseName: firebaseName,
        fileName: fileName,
      );

  Future<void> uploadFrases({
    required String language,
    required List<Sentence> data,
    required String type,
  }) async =>
      await _firebaseDatabaseService.uploadFrases(
          language: language, data: data, type: type);

  Future<List<Sentence>> fetchFrases({
    required String language,
    required String type,
  }) async =>
      await _firebaseDatabaseService.fetchFrases(
        language: language,
        type: type,
      );

  Future<List<Sentence>> fetchFavouriteFrases({
    required String language,
    required String type,
  }) async =>
      await _firebaseDatabaseService.fetchFavouriteFrases(
        language: language,
        type: type,
      );
}
