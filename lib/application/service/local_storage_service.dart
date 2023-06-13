import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

@Singleton(as: LocalStorageRepository, dependsOn: [])
class LocalStorageService extends LocalStorageRepository {
  late final AssetBundle assetBundler;

  @FactoryMethod()
  factory LocalStorageService.start() => LocalStorageService();

  LocalStorageService({AssetBundle? assetBundler}) {
    this.assetBundler = assetBundler ?? rootBundle;
  }

  @override
  Future<Map<String, dynamic>> readPictosFromLocal({required String locale}) async {
    final fileBundle = await assetBundler.loadString('assets/languages/$locale.json');
    return jsonDecode(fileBundle);
  }
}
