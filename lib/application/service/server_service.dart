import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:http/http.dart' as http;

class ServerService implements ServerRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageRef = FirebaseStorage.instance.ref();

  @override
  Future<void> init() async {}

  @override
  Future<void> close() async {}

  @override
  Future<UserType> getUserType(String userId) async {
    final ref = _database.child('$userId/Pago/Pago');
    final res = await ref.get();
    if (res.value == null || res.value.toString() == "0") return UserType.free;

    return UserType.premium;
  }

  @override
  Future<EitherListMap> getAllGroups(String userId, String languageCode) async {
    //Fetch new data from server
    final refNew = _database.child('$userId/groups/$languageCode');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return Right(resNew.value as dynamic);
    }

    //Fetch old data from serve (for compatibility)
    final refOld = _database.child('Grupos/$userId/$languageCode');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return Right(resOld.value as dynamic);
    }

    return const Left("no_data_found");
  }

  @override
  Future<EitherListMap> getAllPictograms(String userId, String languageCode) async {
    //Fetch new data from server
    final refNew = _database.child('$userId/Pictos/$languageCode');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return Right(resNew.value as dynamic);
    }

    //Fetch old data from serve (for compatibility)
    final refOld = _database.child('Pictos/$userId/$languageCode');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return Right(resOld.value as dynamic);
    }

    return const Left("no_data_found");
  }

  @override
  Future<EitherString> getAvailableAppVersion(String platform) async {
    final DatabaseReference ref = _database.child('version/');
    final DataSnapshot res = await ref.get();

    if (!res.exists || res.value == null) return const Left("no_data_found");

    return Right(res.toString());
  }

  @override
  Future<EitherMap> getUserInformation(String id) async {
    final userRef = _database.child('$id/Usuarios/');

    final userValue = await userRef.get();

    if (!userValue.exists || userValue.value == null) return const Left("no_data_found");

    final dynamic user = userValue.value as dynamic;

    return Right(Map<String, dynamic>.from(user));
  }

  @override
  Future<EitherString> getUserProfilePicture(String userId) async {
    final refNew = _database.child('$userId/Usuarios/Avatar/urlFoto/');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return Right(resNew.value.toString());
    }

    /// Get the profile picture from the database at the old path
    final refOld = _database.child('Avatar/$userId/urlFoto/');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return Right(resOld.value.toString());
    }

    return const Left("no_data_found");
  }

  @override
  Future<List<SentenceModel>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final refNew = _database.child('$userId/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      // print('returned from bew');
      return (jsonDecode(encode) as List).map((e) => SentenceModel.fromJson(e)).toList();
      // print('returned from bew');
      // return Right(jsonDecode(data));
    }

    final refOld = _database.child('Frases/$userId/$language/$type');
    final resOld = await refOld.get();
    if (resOld.exists && resOld.value != null) {
      final data = resOld.children.first.value as String;
      return (jsonDecode(data) as List).map((e) => SentenceModel.fromJson(e)).toList();
    }

    return const [];
  }

  @override
  Future<EitherVoid> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.child('$userId/Grupos/$language/$index');

    try {
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.child('$userId/Pictos/$language/$index');

    try {
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/groups/$language');
    try {
      await ref.set({
        'maps':true
      });
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/pictos/$language');

    try {
      await ref.set(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    final ref = _database.child('$userId/Usuarios/');

    try {
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserPicture(String userId, String picture, String photoUrl) async {
    final ref = _database.child('$userId/Usuarios/Avatar/');

    try {
      await ref.update({
        'name': photoUrl,
        'urlFoto': picture,
      });
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data) async {
    final ref = _database.child('$userId/Frases/$language/$type');

    try {
      await ref.set(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherMap> getMostUsedSentences(String userId, String languageCode) async {
    final uri = Uri.parse(
      'https://us-central1-ottaaproject-flutter.cloudfunctions.net/onReqFunc',
    );
    //todo: get the language here after talking with Emir
    final body = {
      'UserID': userId,
      'Language': languageCode,
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return Right(data);
    } else {
      return Left("an error occurred"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> getPictogramsStatistics(String userId, String languageCode) async {
    final uri = Uri.parse('https://us-central1-ottaaproject-flutter.cloudfunctions.net/readFile');
    final body = {
      'UserID': userId,
      //todo: add here the language too
      'Language': 'ES-AR',
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return Right(data);
    } else {
      return Left("an error occurred"); //TODO: Handle the main error
    }
  }

  @override
  Future<void> updateUser({
    required Map<String, dynamic> data,
    required String userId,
  }) async {
    final ref = _database.child('$userId/settings/data/');
    try {
      await ref.update(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> uploadUserImage({
    required String path,
    required String name,
    required String userId,
  }) async {
    Reference ref = _storageRef.child('userProfilePics').child('$name.jpg');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': path},
    );
    late String url;
    if (kIsWeb) {
      // uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      final uploadTask = await ref.putFile(File(path), metadata);
      url = await uploadTask.ref.getDownloadURL();
    }
    return url;
  }

  @override
  Future<EitherMap> getConnectedUsers({required String userId}) async {
    final ref = _database.child('temp/linkTests/$userId/users'); //TODO: Change this to the real path
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> fetchConnectedUserData({required String userId}) async {
    final ref = _database.child('$userId'); //TODO: Change to real path
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<void> removeCurrentUser({required String userId, required String careGiverId}) async {
    await _database.child('$careGiverId/users/$userId').remove();
  }

  @override
  Future<EitherVoid> setShortcutsForUser({required Map<String, dynamic> shortcuts, required String userId}) async {
    final ref = _database.child('$userId/shortcuts/');

    try {
      await ref.set(shortcuts);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherMap> getEmailToken(String ownEmail, String email) async {
    final uri = Uri.parse('https://us-central1-ottaaproject-flutter.cloudfunctions.net/linkUserRequest');
    final body = {
      'src': ownEmail,
      'dst': email,
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return Right(data);
    } else {
      return Left(data["code"] ?? res.body); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> verifyEmailToken(String ownEmail, String email, String token) async {
    final uri = Uri.parse('https://us-central1-ottaaproject-flutter.cloudfunctions.net/linkUserConfirm');
    final body = {
      'src': ownEmail,
      'dst': email,
      'token': token,
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return Right(data);
    } else {
      return Left(data["code"] ?? res.body); //TODO: Handle the main error
    }
  }

  @override
  Future<void> updateUserData({
    required Map<String, dynamic> data,
    required String userId,
  }) async {
    final ref = _database.child('$userId/settings/data/');
    try {
      await ref.update(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<EitherMap> getProfileByEmail({required String email}) async {
    final ref = _database.child("/").orderByChild("Usuarios.Email").equalTo(email);

    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<dynamic> getDefaultGroups(String languageCode) async {
    final ref = _database.child('default/groups/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(res.value as dynamic);
    }

    return const Left("no_data_found");
  }
}
