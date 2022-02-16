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
    print('the result is for file 2: $fileExists');

    /// updated one for loading the pictos...
    /// check if data exists online or not
    final User? auth = firebaseRed.currentUser;
    print('the value from stream is ${auth!.displayName}');
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth.uid}/');
    final res = await ref.once();

    if (res.value != null) {
      /// it means file does exists online
      /// now check if you are on phone or web
      if (kIsWeb) {
        /// it means the system is on web
        final User? auth = firebaseRed.currentUser;
        final ref = databaseRef.child('Picto/${auth!.uid}/');
        final res = await ref.once();
        final data = res.value['data'];
        final da =
            (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList();
        print('from web bitches');
        return da;
      } else {
        /// it means the system is mobile
        if (fileExists! == true) {
          ///it means the file exists
          print('from file bitches');
          return _fileController.readPictoFromFile();
        } else {
          ///it means teh file does not exists
          ///we will create the file here and return the data
          final User? auth = firebaseRed.currentUser;
          final ref = databaseRef.child('Picto/${auth!.uid}/');
          final res = await ref.get();
          final data = res.value['data'];
          await _fileController.writePictoToFile(data: data);
          await instance.setBool('Pictos_file', true);
          final da =
              (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList();
          print('from online bitches');
          return da;
        }
      }
    } else {
      if (fileExists! == true) {
        ///it means the file exists
        print('from file bitches');
        return _fileController.readPictoFromFile();
      } else {
        /// if does not exists just load the basic one from the assets
        final String pictsString =
            await rootBundle.loadString('assets/pictos.json');

        return (jsonDecode(pictsString) as List)
            .map((e) => Pict.fromJson(e))
            .toList();
      }
    }
  }
}
