import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class WebRemoteStorageService implements RemoteStorageRepository {
  final ServerRepository _serverRepository;

  final AuthRepository _authService;
  final I18N _i18n;

  WebRemoteStorageService(this._authService, this._serverRepository, this._i18n);

  @override
  Future<void> deleteFile(String path, String fileName) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> readRemoteFile({required String path, required String fileName}) async {
    final result = await _authService.getCurrentUser();

    if (result.isLeft) return "";

    final UserModel auth = result.right;
    final languageCode = _i18n.languageCode;

    EitherListMap? fetchedData;

    if (path == "Pictos") {
      fetchedData = await _serverRepository.getAllPictograms(auth.id, languageCode);
    } else if (path == "Grupos") {
      fetchedData = await _serverRepository.getAllGroups(auth.id, languageCode);
    }

    if (fetchedData != null && fetchedData.isRight) {
      final encode = jsonEncode(fetchedData.right);
      return encode;
    }

    final cachedData = await rootBundle.loadString(fileName);
    return cachedData;
  }

  @override
  Future<String> uploadFile(String path, String fileName, Uint8List file) async {
    Reference ref = FirebaseStorage.instance.ref().child(path).child(fileName);
    final UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: 'image/png'));
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }
}
