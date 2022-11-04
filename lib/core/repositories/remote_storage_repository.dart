import 'package:flutter/services.dart';

abstract class RemoteStorageRepository {
  Future<String> uploadFile(String path, String fileName, Uint8List file);
  Future<void> deleteFile(String path, String fileName);
  Future<String> readRemoteFile({
    required String path,
    required String fileName,
  });
}
