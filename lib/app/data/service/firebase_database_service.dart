import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> uploadInfo(
      {required String name,
      required String gender,
      required int dateOfBirthInMs}) async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('Usuarios/${auth!.uid}/');
    await ref.set(<String, Object>{
      'Nombre': name,
      'birth_date': dateOfBirthInMs,
      'pref_sexo': gender,
    }).then((onValue) {
      return true;
    }).catchError((onError) {
      print(onError.toString());
      return false;
    });
    print('hi');
  }

  Future<void> uploadAvatar({required int photoNumber}) async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('Avatar/${auth!.uid}/');
    await ref.set({
      'name': 'TestName',
      'urlFoto': photoNumber,
    });
  }

  Future<int> getPicNumber() async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('Avatar/${auth!.uid}/');
    final res = await ref.get();
    return res.value['urlFoto'];
  }

  Future<String> fetchCurrentVersion() async {
    final ref = databaseRef.child('version/');
    final res = await ref.get();
    return res.value;
  }

  Future<String> fetchUserEmail() async {
    final auth = firebaseRed.currentUser!.providerData[0].email;
    return auth!;
  }

  Future<int> fetchAccountType() async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('Pago/${auth!.uid}/Pago');
    final res = await ref.get();
    if (res.value == null) return 0;
    return res.value;
  }

  Future<void> logFirebaseAnalyticsEvent({required String eventName}) async =>
      await FirebaseAnalytics.instance.logEvent(name: "Talk");

  Future<void> uploadDataToFirebaseRealTime({
    required String data,
    required String type,
  }) async {
    final String? auth = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('$type/${auth!}/');
    await ref.set({
      'data': data,
    });
  }

  Future<void> uploadBoolToFirebaseRealtime({
    required bool data,
    required String type,
  }) async {
    final String? auth = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('$type/${auth!}/');
    await ref.set({
      'value': true,
    });
  }

  Future<String> uploadImageToStorageForWeb({
    required String storageName,
    required Uint8List imageInBytes,
  }) async {
    late String url;
    Reference _reference =
        FirebaseStorage.instance.ref().child('$storageName/');
    await _reference
        .putData(
      imageInBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        url = value;
      });
    });
    return url;
  }

  Future<String> uploadImageToStorage({
    required String path,
    required String storageDirectory,
    required String childName,
  }) async {
    Reference ref =
        FirebaseStorage.instance.ref().child(storageDirectory).child(childName);
    final UploadTask uploadTask = ref.putFile(File(path));
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }

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
        pictosOrGrupos: true,
      );
    } else {
      return await mobileFiles(
        assetsFileName: 'assets/pictos.json',
        fileName: 'Pictos_file',
        firebaseName: 'Picto',
        pictoOrGrupo: true,
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
        assetsFileName: 'assets/grupos.json',
        firebaseName: 'Grupo',
        pictosOrGrupos: false,
      );
    } else {
      return await mobileFiles(
        onlineSnapshot: res,
        assetsFileName: 'assets/grupos.json',
        fileName: 'Grupos_file',
        firebaseName: 'Grupo',
        pictoOrGrupo: false,
      );
    }
  }

  Future<dynamic> mobileFiles({
    required DataSnapshot onlineSnapshot,
    required String fileName,
    required String assetsFileName,
    required String firebaseName,
    required bool pictoOrGrupo,
  }) async {
    final instance = await SharedPreferences.getInstance();
    final fileExists = instance.getBool(fileName);
    debugPrint('the result is for file : $fileExists');
    if (onlineSnapshot.exists && onlineSnapshot.value != null) {
      if (fileExists == true && fileExists != null) {
        debugPrint('from file on the device : mobile');
        if (pictoOrGrupo) {
          return await _fileController.readPictoFromFile();
        } else {
          return await _fileController.readGruposFromFile();
        }
      } else {
        final ref =
            databaseRef.child('$firebaseName/${firebaseRed.currentUser!.uid}/');
        final res = await ref.get();
        final data = res.value['data'];
        final da = pictoOrGrupo
            ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
            : (jsonDecode(data) as List)
                .map((e) => Grupos.fromJson(e))
                .toList();
        debugPrint('from online firebase : mobile');
        if (pictoOrGrupo) {
          await _fileController.writePictoToFile(data: data);
          await instance.setBool(fileName, true);
        } else {
          await _fileController.writeGruposToFile(data: data);
          await instance.setBool(fileName, true);
        }
        return da;
      }
    } else {
      //todo: make different types of conversion
      final pictsString = await rootBundle.loadString(assetsFileName);
      final listData = pictoOrGrupo
          ? (jsonDecode(pictsString) as List)
              .map((e) => Pict.fromJson(e))
              .toList()
          : (jsonDecode(pictsString) as List)
              .map((e) => Grupos.fromJson(e))
              .toList();
      final data = listData;
      List<String> fileData = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileData.add(obj);
      });
      debugPrint('from file user first time: mobile');
      //todo: make different functions to write
      if (pictoOrGrupo) {
        await _fileController.writePictoToFile(data: data.toString());
        await instance.setBool('Pictos_file', true);
      } else {
        await _fileController.writeGruposToFile(data: data.toString());
        await instance.setBool('Pictos_file', true);
      }
      return listData;
    }
  }

  Future<dynamic> webFiles({
    required DataSnapshot snapshot,
    required String assetsFileName,
    required String firebaseName,
    required bool pictosOrGrupos,
  }) async {
    if (snapshot.exists && snapshot.value != null) {
      final ref =
          databaseRef.child('$firebaseName/${firebaseRed.currentUser!.uid}/');
      final res = await ref.get();
      final data = res.value['data'];
      //todo: write different conversions here
      final da = pictosOrGrupos
          ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(data) as List).map((e) => Grupos.fromJson(e)).toList();
      debugPrint('from online realtime : web');
      return da;
    } else {
      //todo: write different assets here and convert different one's
      final String listData = await rootBundle.loadString(assetsFileName);
      debugPrint('from json realtime : web');
      return pictosOrGrupos
          ? (jsonDecode(listData) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(listData) as List)
              .map((e) => Grupos.fromJson(e))
              .toList();
    }
  }

  Future<Map<String, dynamic>> fetchGameData(
      {required int gameNumber, required int grupoNumber}) async {
    final ref = databaseRef
        .child('${firebaseRed.currentUser!.uid}/$gameNumber/$grupoNumber');
    final res = await ref.get();
    final bol = res.exists;
    if (bol) {
      final data = res.value['data'];
      return data;
    } else {
      return {'': ''};
    }
  }

  Future<void> uploadGameData({
    required int gameNumber,
    required int grupoNumber,
    required Map<dynamic, dynamic> data,
  }) async {
    final ref = databaseRef
        .child('${firebaseRed.currentUser!.uid}/$gameNumber/$grupoNumber');
    await ref.set({
      data,
    });
  }

  Future<void> saveUserPhotoUrl({required String photoUrl}) async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('PhotoUrl/${auth!.uid}/');
    await ref.set({
      'PhotoUrl': photoUrl,
    });
  }
  Future<String> fetchUserPhotoUrl()async{
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('PhotoUrl/${auth!.uid}/');
    final res = await ref.get();
    return res.value['PhotoUrl'];
  }

  Future<void> uploadFrases({required String data})async{
    final String? auth = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('frases/${auth!}/');
    await ref.set({
      'data': data,
    });
  }
}
