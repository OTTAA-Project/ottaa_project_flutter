import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';

class MobileRemoteStorageService implements RemoteStorageRepository {
  final _databaseRef = FirebaseDatabase.instance.ref();

  final AuthRepository _authService;
  final I18N _i18n;

  MobileRemoteStorageService(this._authService, this._i18n);

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

    final refNew = _databaseRef.child('${auth.id}/$path/$languageCode');
    final resNew = await refNew.get();
    final refOld = _databaseRef.child('$path/${auth.id}/$languageCode');
    final resOld = await refOld.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      return encode;
    } else if (resOld.exists && resOld.value != null) {
      final data = resOld.children.first.value as String;
      return data;
    } else {
      final data = await rootBundle.loadString(fileName);
      return data;
    }
  }

  @override
  Future<String> uploadFile(String path, String fileName, Uint8List file) async {
    Reference ref = FirebaseStorage.instance.ref().child(path).child(fileName);
    final UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: 'image/png'));
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }
}
