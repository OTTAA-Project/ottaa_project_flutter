import 'dart:convert';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDatabaseService {
  final _fileController = LocalFileController();
  final databaseRef = FirebaseDatabase.instance.ref();
  final firebaseRed = FirebaseAuth.instance;

  Future<void> uploadInfo(
      {required String name,
      required String gender,
      required int dateOfBirthInMs}) async {
    final User? auth = firebaseRed.currentUser;
    final ref = databaseRef.child('${auth!.uid}/Usuarios/');
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
    final ref = databaseRef.child('${auth!.uid}/Avatar/');
    await ref.set({
      //todo: change the name over here
      'name': 'TestName',
      'urlFoto': photoNumber,
    });
  }

  Future<int> getPicNumber() async {
    final User? auth = firebaseRed.currentUser;
    final refNew = databaseRef.child('${auth!.uid}/Avatar/urlFoto/');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      return resNew.value as int;
    } else {
      final refOld = databaseRef.child('Avatar/${auth.uid}/urlFoto/');
      final resOld = await refOld.get();
      print('here is the user urlfoto');
      print(resOld.value);
      return resOld.value as int;
    }
  }

  Future<double> fetchCurrentVersion() async {
    final ref = databaseRef.child('version/');
    final res = await ref.get();
    return res.value as double;
  }

  Future<String> fetchUserEmail() async {
    final auth = firebaseRed.currentUser!.providerData[0].email;
    return auth!;
  }

  Future<int> fetchAccountType() async {
    final User? auth = firebaseRed.currentUser;
    final refNew = databaseRef.child('${auth!.uid}/Pago/Pago');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      return resNew.value as int;
    } else {
      final refOld = databaseRef.child('Pago/${auth.uid}/Pago');
      final resOld = await refOld.get();
      if (resOld.value == null) return 0;
      return resOld.value as int;
    }
  }

  Future<void> logFirebaseAnalyticsEvent({required String eventName}) async =>
      await FirebaseAnalytics.instance.logEvent(name: "Talk");

  Future<void> uploadDataToFirebaseRealTime({
    required String data,
    required String type,
    required String languageCode,
  }) async {
    final String? id = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('$type/${id!}/$languageCode');
    await ref.set({
      'data': data,
    });
  }

  Future<void> uploadGruposToFirebaseRealTime({
    required List<Grupos> data,
    required String type,
    required String languageCode,
  }) async {
    dynamic jsonData = List.empty(growable: true);
    data.forEach((e) {
      final relactions = e.relacion.map((e) => e.toJson()).toList();
      jsonData.add({
        'id': e.id,
        'texto': e.texto.toJson(),
        'tipo': e.tipo,
        'imagen': e.imagen.toJson(),
        'relacion': relactions,
        'frecuencia': e.frecuencia,
        'tags': e.tags,
      });
    });
    final String? id = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('${id!}/$type/$languageCode');
    await ref.set(jsonData);
  }

  Future<void> uploadGruposEditToFirebaseRealTime({
    required Grupos data,
    required String type,
    required String languageCode,
    required int index,
  }) async {
    final relactions = data.relacion.map((e) => e.toJson()).toList();
    final String? id = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('${id!}/$type/$languageCode/$index');
    await ref.update({
      'id': data.id,
      'texto': data.texto.toJson(),
      'tipo': data.tipo,
      'imagen': data.imagen.toJson(),
      'relacion': relactions,
      'frecuencia': data.frecuencia,
      'tags': data.tags,
    });
  }

  Future<void> uploadPictosToFirebaseRealTime({
    required List<Pict> data,
    required String type,
    required String languageCode,
  }) async {
    dynamic jsonData = List.empty(growable: true);
    data.forEach((Pict e) {
      final relactions = e.relacion?.map((e) => e.toJson()).toList();
      jsonData.add({
        'id': e.id,
        'texto': e.texto.toJson(),
        'tipo': e.tipo,
        'imagen': e.imagen.toJson(),
        'relacion': relactions,
        'agenda': e.agenda,
        'gps': e.gps,
        'hora': e.hora,
        'edad': e.edad,
        'sexo': e.sexo,
        'esSugerencia': e.esSugerencia,
        'horario': e.horario,
        'ubicacion': e.ubicacion,
        'score': e.score,
      });
    });
    final String? id = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('${id!}/$type/$languageCode');
    await ref.set(jsonData);
  }

  Future<void> uploadEditingPictoToFirebaseRealTime({
    required Pict data,
    required String type,
    required String languageCode,
    required int index,
  }) async {
    final relactions = data.relacion?.map((e) => e.toJson()).toList();
    dynamic jsonData = List.empty(growable: true);
    jsonData.add({
      'id': data.id,
      'texto': data.texto.toJson(),
      'tipo': data.tipo,
      'imagen': data.imagen.toJson(),
      'relacion': relactions,
      'agenda': data.agenda,
      'gps': data.gps,
      'hora': data.hora,
      'edad': data.edad,
      'sexo': data.sexo,
      'esSugerencia': data.esSugerencia,
      'horario': data.horario,
      'ubicacion': data.ubicacion,
      'score': data.score,
    });
    final String? id = firebaseRed.currentUser!.uid;
    final ref = databaseRef.child('${id!}/$type/$languageCode/$index');
    await ref.update(jsonData);
  }

  Future<void> uploadBoolToFirebaseRealtime({
    required bool data,
    required String type,
  }) async {
    final String? id = firebaseRed.currentUser!.uid;
    //todo: check where it is being used and remove it
    final ref = databaseRef.child('$type/${id!}/');
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
    final instance = await SharedPreferences.getInstance();
    final String key = instance.getString('Language_KEY') ?? 'Spanish';
    final String languageCode = Constants.LANGUAGE_CODES[key]!;
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
    // final ref = databaseRef.child('PictsExistsOnFirebase/${auth.uid}/');
    // final res = await ref.get();

    if (kIsWeb) {
      return await webFiles(
        // snapshot: res,
        firebaseName: 'Pictos',
        assetsFileName: 'assets/pictos.json',
        pictosOrGrupos: true,
        languageCode: languageCode,
      );
    } else {
      return await mobileFiles(
        assetsFileName: 'assets/pictos.json',
        fileName: 'Pictos_file',
        firebaseName: 'Pictos',
        pictoOrGrupo: true,
        // onlineSnapshot: res,
        languageCode: languageCode,
      );
    }
  }

  Future<List<Grupos>> fetchGrupos() async {
    final instance = await SharedPreferences.getInstance();
    final String key = instance.getString('Language_KEY') ?? 'Spanish';
    final String languageCode = Constants.LANGUAGE_CODES[key]!;
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
    // final ref = databaseRef.child('GruposExistsOnFirebase/${auth.uid}/');
    // final res = await ref.get();

    if (kIsWeb) {
      return await webFiles(
        // snapshot: res,
        assetsFileName: 'assets/grupos.json',
        firebaseName: 'Grupos',
        pictosOrGrupos: false,
        languageCode: languageCode,
      );
    } else {
      return await mobileFiles(
        // onlineSnapshot: res,
        assetsFileName: 'assets/grupos.json',
        fileName: 'Grupos_file',
        firebaseName: 'Grupos',
        pictoOrGrupo: false,
        languageCode: languageCode,
      );
    }
  }

  Future<List<Pict>> fetchOtherPictos({
    required String languageName,
    required String assetName,
    required String firebaseName,
    required String fileName,
  }) async {
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
    final User? auth = firebaseRed.currentUser;
    debugPrint('the value from stream is ${auth!.displayName}');
    final ref =
        databaseRef.child('PictsExistsOnFirebase$languageName/${auth.uid}/');
    final res = await ref.get();
    if (kIsWeb) {
      return await webFilesOtherLanguages(
        snapshot: res,
        firebaseName: firebaseName,

        /// e.g, firebaseName == FrenchPicto
        languageName: languageName,

        /// e.g, languageName == French
        assetsFileName: assetName,

        /// e.g, assetName == 'assets/languages/picto_fr.json'
        pictosOrGrupos: true,
      );
    } else {
      return await mobileFilesOtherLanguages(
        assetsFileName: assetName,
        fileName: fileName,

        /// e.g, fileName == pictos_fr_file
        firebaseName: firebaseName,
        pictoOrGrupo: true,
        onlineSnapshot: res,
      );
    }
  }

  Future<List<Grupos>> fetchOtherGrupos({
    required String languageName,
    required String assetName,
    required String firebaseName,
    required String fileName,
  }) async {
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
    final ref =
        databaseRef.child('GruposExistsOnFirebase$languageName/${auth.uid}/');
    final res = await ref.get();

    if (kIsWeb) {
      return await webFilesOtherLanguages(
        snapshot: res,
        firebaseName: firebaseName,

        /// e.g, firebaseName == FrenchGrupo
        languageName: languageName,

        /// e.g, languageName == French
        assetsFileName: assetName,

        /// e.g, assetName == 'assets/languages/grupo_fr.json'
        pictosOrGrupos: false,
      );
    } else {
      return await mobileFilesOtherLanguages(
        assetsFileName: assetName,
        fileName: fileName,

        /// e.g, fileName == grupo_fr_file
        firebaseName: firebaseName,
        pictoOrGrupo: false,
        onlineSnapshot: res,
      );
    }
  }

  Future<dynamic> webFilesOtherLanguages({
    required DataSnapshot snapshot,
    required String assetsFileName,
    required String languageName,
    required String firebaseName,
    required bool pictosOrGrupos,
  }) async {
    if (snapshot.exists && snapshot.value != null) {
      final ref =
          databaseRef.child('$firebaseName/${firebaseRed.currentUser!.uid}/');
      final res = await ref.get();
      final data = res.children.first.value as String;

      final da = pictosOrGrupos
          ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(data) as List).map((e) => Grupos.fromJson(e)).toList();
      debugPrint('from online realtime : web');
      return da;
    } else {
      final String listData = await rootBundle.loadString(assetsFileName);
      debugPrint('from json realtime : web');
      return pictosOrGrupos
          ? (jsonDecode(listData) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(listData) as List)
              .map((e) => Grupos.fromJson(e))
              .toList();
    }
  }

  Future<dynamic> mobileFilesOtherLanguages({
    required DataSnapshot onlineSnapshot,
    required String fileName,
    required String assetsFileName,
    required String firebaseName,
    required bool pictoOrGrupo,
  }) async {
    final instance = await SharedPreferences.getInstance();
    final fileExists = instance.getBool(fileName);
    final String key = instance.getString('Language_KEY') ?? 'Spanish';
    final String languageCode = Constants.LANGUAGE_CODES[key]!;
    debugPrint('the result is for file : $fileExists');
    if (onlineSnapshot.exists && onlineSnapshot.value != null) {
      if (fileExists == true && fileExists != null) {
        debugPrint('from file on the device : mobile');
        if (pictoOrGrupo) {
          return await _fileController.readPictoFromFile(
              language: languageCode);
        } else {
          return await _fileController.readGruposFromFile(
              language: languageCode);
        }
      } else {
        final ref =
            databaseRef.child('$firebaseName/${firebaseRed.currentUser!.uid}/');
        final res = await ref.get();
        final data = res.children.first.value as String;
        final da = pictoOrGrupo
            ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
            : (jsonDecode(data) as List)
                .map((e) => Grupos.fromJson(e))
                .toList();
        debugPrint('from online firebase : mobile');
        if (pictoOrGrupo) {
          await _fileController.writePictoToFile(
              data: data, language: languageCode);
          await instance.setBool(fileName, true);
        } else {
          await _fileController.writeGruposToFile(
              data: data, language: languageCode);
          await instance.setBool(fileName, true);
        }
        return da;
      }
    } else {
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

      if (pictoOrGrupo) {
        await _fileController.writePictoToFile(
            data: data.toString(), language: languageCode);
        await instance.setBool(fileName, true);
      } else {
        await _fileController.writeGruposToFile(
          data: data.toString(),
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      }
      return listData;
    }
  }

  Future<dynamic> mobileFiles({
    // required DataSnapshot onlineSnapshot,
    required String fileName,
    required String assetsFileName,
    required String firebaseName,
    required bool pictoOrGrupo,
    required String languageCode,
  }) async {
    final instance = await SharedPreferences.getInstance();
    final fileExists = instance.getBool(fileName);
    final String key = instance.getString('Language_KEY') ?? 'Spanish';
    final String languageCode = Constants.LANGUAGE_CODES[key]!;
    debugPrint('the result is for file : $fileExists');

    if (fileExists == true && fileExists != null) {
      debugPrint('from file on the device : mobile');
      if (pictoOrGrupo) {
        return await _fileController.readPictoFromFile(
          language: languageCode,
        );
      } else {
        return await _fileController.readGruposFromFile(
          language: languageCode,
        );
      }
    }

    final refNew = databaseRef
        .child('${firebaseRed.currentUser!.uid}/$firebaseName/$languageCode');
    final resNew = await refNew.get();
    final refOld = databaseRef
        .child('$firebaseName/${firebaseRed.currentUser!.uid}/$languageCode');
    final resOld = await refOld.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      final data = pictoOrGrupo
          ? (jsonDecode(encode) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(encode) as List)
              .map((e) => Grupos.fromJson(e))
              .toList();
      List<String> fileDataPicts = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileDataPicts.add(obj);
      });
      if (pictoOrGrupo) {
        await _fileController.writePictoToFile(
          data: fileDataPicts.toString(),
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      } else {
        await _fileController.writeGruposToFile(
          data: fileDataPicts.toString(),
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      }
      return data;
    } else if (resOld.exists && resOld.value != null) {
      final data = resOld.children.first.value as String;
      final da = pictoOrGrupo
          ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(data) as List).map((e) => Grupos.fromJson(e)).toList();
      debugPrint('from online firebase : mobile');
      if (pictoOrGrupo) {
        await _fileController.writePictoToFile(
          data: data,
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      } else {
        await _fileController.writeGruposToFile(
          data: data,
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      }
      return da;
    } else {
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
        await _fileController.writePictoToFile(
          data: data.toString(),
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      } else {
        await _fileController.writeGruposToFile(
          data: data.toString(),
          language: languageCode,
        );
        await instance.setBool(fileName, true);
      }
      return listData;
    }
  }

  Future<dynamic> webFiles({
    // required DataSnapshot snapshot,
    required String assetsFileName,
    required String firebaseName,
    required bool pictosOrGrupos,
    required String languageCode,
  }) async {
    final refNew = databaseRef
        .child('$firebaseName/${firebaseRed.currentUser!.uid}/$languageCode');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      return pictosOrGrupos
          ? (jsonDecode(encode) as List).map((e) => Pict.fromJson(e)).toList()
          : (jsonDecode(encode) as List)
              .map((e) => Grupos.fromJson(e))
              .toList();
    } else {
      final refOld = databaseRef
          .child('$firebaseName/${firebaseRed.currentUser!.uid}/$languageCode');
      final resOld = await refOld.get();
      if (resOld.exists && resOld.value != null) {
        final data = resOld.children.first.value as String;
        //todo: write different conversions here
        final da = pictosOrGrupos
            ? (jsonDecode(data) as List).map((e) => Pict.fromJson(e)).toList()
            : (jsonDecode(data) as List)
                .map((e) => Grupos.fromJson(e))
                .toList();
        debugPrint('from online realtime : web');
        return da;
      } else {
        //todo: write different assets here and convert different one's
        final String listData = await rootBundle.loadString(assetsFileName);
        debugPrint('from json realtime : web');
        return pictosOrGrupos
            ? (jsonDecode(listData) as List)
                .map((e) => Pict.fromJson(e))
                .toList()
            : (jsonDecode(listData) as List)
                .map((e) => Grupos.fromJson(e))
                .toList();
      }
    }
  }

  Future<Map<String, dynamic>> fetchGameData(
      {required int gameNumber, required int grupoNumber}) async {
    final ref = databaseRef
        .child('${firebaseRed.currentUser!.uid}/$gameNumber/$grupoNumber');
    final res = await ref.get();
    final bol = res.exists;
    if (bol) {
      //todo: remove changes
      final data = res.children.first.value as String;
      return {};
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
    final ref = databaseRef.child('${auth!.uid}/PhotoUrl/');
    await ref.set({
      'PhotoUrl': photoUrl,
    });
  }

  Future<String> fetchUserPhotoUrl() async {
    final User? auth = firebaseRed.currentUser;
    final refNew = databaseRef.child('${auth!.uid}/PhotoUrl/');
    final resNew = await refNew.get();
    if (resNew.exists) {
      return resNew.children.first.value as String;
    } else {
      final refOld = databaseRef.child('PhotoUrl/${auth.uid}/');
      final resOld = await refOld.get();
      return resOld.children.first.value as String;
    }
  }

  String fetchCurrentUserUID() {
    final User? auth = firebaseRed.currentUser;
    return auth!.uid;
  }

  Future<void> uploadFrases({
    required String language,
    required List<Sentence> data,
    required String type,
  }) async {
    final ref = databaseRef
        .child('${firebaseRed.currentUser!.uid}/Frases/$language/$type');
    final List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    data.forEach((e) {
      jsonData.add(e.toJson());
    });
    await ref.set(jsonData);
  }

  Future<List<Sentence>> fetchFrases({
    required String language,
    required String type,
  }) async {
    final refNew = databaseRef
        .child('${firebaseRed.currentUser!.uid}/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      // print('returned from bew');
      return (jsonDecode(encode) as List)
          .map((e) => Sentence.fromJson(e))
          .toList();
    } else {
      final refOld = databaseRef
          .child('Frases/${firebaseRed.currentUser!.uid}/$language/$type');
      final resOld = await refOld.get();
      if (resOld.exists && resOld.value != null) {
        final data = resOld.children.first.value as String;
        final da = (jsonDecode(data) as List)
            .map((e) => Sentence.fromJson(e))
            .toList();

        return da;
      } else {
        /// if there are no frases we will be returning the empty string
        return [];
      }
    }
  }

  Future<List<Sentence>> fetchFavouriteFrases({
    required String language,
    required String type,
  }) async {
    final refNew = databaseRef
        .child('${firebaseRed.currentUser!.uid}/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      return (jsonDecode(encode) as List)
          .map((e) => Sentence.fromJson(e))
          .toList();
    } else {
      final refOld = databaseRef
          .child('Frases/${firebaseRed.currentUser!.uid}/$language/$type');
      final resOld = await refOld.get();
      if (resOld.exists && resOld.value != null) {
        final data = resOld.children.first.value as String;
        final da = (jsonDecode(data) as List)
            .map((e) => Sentence.fromJson(e))
            .toList();

        return da;
      } else {
        return [];
      }
    }
  }
}
