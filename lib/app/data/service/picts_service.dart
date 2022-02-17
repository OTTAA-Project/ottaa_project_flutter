import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PictsService {
  final _fileController = LocalFileController();
  final databaseRef = FirebaseDatabase.instance.reference();
  final firebaseRed = FirebaseAuth.instance;

  Future<List<Pict>> getAll() async {
    if (kIsWeb) {
      await Future.delayed(
        Duration(seconds: 1),
      );
    }
    final instance = await SharedPreferences.getInstance();
    final fileExists = instance.getBool('Pictos_file');
    debugPrint('the result is for file : $fileExists');

    /// updated one for loading the pictos...
    /// check if data exists online or not
    final User? auth = firebaseRed.currentUser;
    debugPrint('the value from stream is ${auth!.displayName}');
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth.uid}/');
    final res = await ref.get();

    if (kIsWeb) {
      return await webFiles(snapshot: res);
    } else {
      return await mobileFiles(
        onlineSnapshot: res,
        fileExists: fileExists != null ? fileExists : false,
      );
    }
  }

  Future<List<Pict>> mobileFiles({
    required DataSnapshot onlineSnapshot,
    required bool fileExists,
  }) async {
    final instance = await SharedPreferences.getInstance();
    if (onlineSnapshot.exists && onlineSnapshot.value != null) {
      if (fileExists) {
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
      await _fileController.writePictoToFile(data: data.toString());
      await instance.setBool('Pictos_file', true);
      return pictos;
    }
  }

  Future<List<Pict>> webFiles({required DataSnapshot snapshot}) async {
    if (snapshot.exists && snapshot.value != null) {
      final ref = databaseRef.child('Picto/${firebaseRed.currentUser!.uid}/');
      final res = await ref.get();
      final data = res.value['data'];
      final da =
          (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList();
      debugPrint('from online realtime : web');
      return da;
    } else {
      final String pictsString =
          await rootBundle.loadString('assets/pictos.json');
      debugPrint('from json realtime : web');
      return (jsonDecode(pictsString) as List)
          .map((e) => Pict.fromJson(e))
          .toList();
    }
  }
}
