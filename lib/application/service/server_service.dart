import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:http/http.dart' as http;

class ServerService implements ServerRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

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
    final refNew = _database.child('$userId/Grupos/$languageCode');
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
  Future<EitherListMap> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final refNew = _database.child('$userId/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final data = jsonEncode(resNew.value);
      // print('returned from bew');
      return Right(jsonDecode(data));
    }

    final refOld = _database.child('Frases/$userId/$language/$type');
    final resOld = await refOld.get();
    if (resOld.exists && resOld.value != null) {
      final data = resOld.children.first.value as String;
      return Right(jsonDecode(data));
    }

    return const Left("no_data_found");
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
    final ref = _database.child('$userId/Grupos/$language');
    try {
      await ref.set(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/Pictos/$language');

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
      await ref.set(data);
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
}
