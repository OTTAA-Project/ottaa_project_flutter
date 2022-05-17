import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDatabaseService {
  final _fileController = LocalFileController();
  final databaseRef = FirebaseDatabase.instance.reference();
  final firebaseRed = FirebaseAuth.instance;

  Future<List<Pict>> fetchPictos() async {
    if (kIsWeb) {
      await Future.delayed(
        Duration(seconds: 2),
      );
    }
    if (!kIsWeb) {
      await Future.delayed(
        Duration(seconds: 1),
      );
    }

    /// updated one for loading the pictos...
    /// check if data exists online or not
    final User? auth = firebaseRed.currentUser;
    debugPrint('the value from stream is ${auth!.displayName}');
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth.uid}/');
    final res = await ref.get();

    if (kIsWeb) {
      return await webFiles(
        snapshot: res,
        firebaseName: 'Picto',
        assetsFileName: 'assets/pictos.json',
      );
    } else {
      return await mobileFiles(
        assetsFileName: 'assets/pictos.json',
        fileName: 'Pictos_file',
        firebaseName: 'Picto',
        onlineSnapshot: res,
      );
    }
  }

  Future<List<Grupos>> fetchGrupos() async {
    if (kIsWeb) {
      await Future.delayed(
        Duration(seconds: 2),
      );
    }
    if (!kIsWeb) {
      await Future.delayed(
        Duration(seconds: 1),
      );
    }

    /// updated one for loading the pictos...
    /// check if data exists online or not
    final User? auth = firebaseRed.currentUser;
    debugPrint('the value from stream is ${auth!.displayName}');
    final ref = databaseRef.child('GruposExistsOnFirebase/${auth.uid}/');
    final res = await ref.get();

    if (kIsWeb) {
      return await webFiles(
        snapshot: res,
        assetsFileName: '',
        firebaseName: '',
      );
    } else {
      return await mobileFiles(
        onlineSnapshot: res,
        assetsFileName: '',
        fileName: '',
        firebaseName: '',
      );
    }
  }

  Future<dynamic> mobileFiles({
    required DataSnapshot onlineSnapshot,
    required String fileName,
    required String assetsFileName,
    required String firebaseName,
  }) async {
    final instance = await SharedPreferences.getInstance();
    final fileExists = instance.getBool('Pictos_file');
    debugPrint('the result is for file : $fileExists');
    if (onlineSnapshot.exists && onlineSnapshot.value != null) {
      if (fileExists == true && fileExists != null) {
        debugPrint('from file realtime : mobile');
        return await _fileController.readPictoFromFile();
      } else {
        final ref = databaseRef.child('Picto/${firebaseRed.currentUser!.uid}/');
        final res = await ref.get();
        final data = res.value['data'];
        final da =
            (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList();
        debugPrint('from online realtime : mobile');
        await _fileController.writePictoToFile(data: data);
        await instance.setBool('Pictos_file', true);
        return da;
      }
    } else {
      //todo: make different types of conversion
      final pictsString = await rootBundle.loadString('assets/pictos.json');
      final pictos = (jsonDecode(pictsString) as List)
          .map((e) => Pict.fromJson(e))
          .toList();
      final data = pictos;
      List<String> fileData = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileData.add(obj);
      });
      debugPrint('from file user first time: mobile');
      //todo: make different functions to write
      await _fileController.writePictoToFile(data: data.toString());
      await instance.setBool('Pictos_file', true);
      return pictos;
    }
  }

  Future<dynamic> webFiles({
    required DataSnapshot snapshot,
    required String assetsFileName,
    required String firebaseName,
  }) async {
    if (snapshot.exists && snapshot.value != null) {
      final ref = databaseRef.child('Picto/${firebaseRed.currentUser!.uid}/');
      final res = await ref.get();
      final data = res.value['data'];
      //todo: write different conversions here
      final da =
          (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList();
      debugPrint('from online realtime : web');
      return da;
    } else {
      //todo: write different assets here and convert different one's
      final String pictsString =
          await rootBundle.loadString('assets/pictos.json');
      debugPrint('from json realtime : web');
      return (jsonDecode(pictsString) as List)
          .map((e) => Pict.fromJson(e))
          .toList();
    }
  }
}
