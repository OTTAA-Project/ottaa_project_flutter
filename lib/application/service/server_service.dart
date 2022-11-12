import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class ServerService implements ServerRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Future<void> init() async {}

  @override
  Future<void> close() async {}

  @override
  Future<List<Map<String, dynamic>>?> getAllGroups(String userId, String languageCode) async {
    //Fetch new data from server
    final refNew = _database.child('$userId/Grupos/$languageCode');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return resNew.value as dynamic;
    }

    //Fetch old data from serve (for compatibility)
    final refOld = _database.child('Grupos/$userId/$languageCode');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return resOld.value as dynamic;
    }

    return null;
  }

  @override
  Future<List<Map<String, dynamic>>?> getAllPictograms(String userId, String languageCode) async {
    //Fetch new data from server
    final refNew = _database.child('$userId/Pictos/$languageCode');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return resNew.value as dynamic;
    }

    //Fetch old data from serve (for compatibility)
    final refOld = _database.child('Pictos/$userId/$languageCode');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return resOld.value as dynamic;
    }

    return null;
  }

  @override
  Future<String> getAvailableAppVersion() async {
    final DatabaseReference ref = _database.child('version/');
    final DataSnapshot res = await ref.get();

    return res.toString();
  }

  @override
  Future<Map<String, dynamic>?> getUserInformation(String id) async {
    final userRef = _database.child('$id/Usuarios/');

    final userValue = await userRef.get();

    if (!userValue.exists || userValue.value == null) return null;

    final dynamic user = userValue.value as dynamic;

    return Map<String, dynamic>.from(user);
  }

  @override
  Future<String?> getUserProfilePicture(String userId) async {
    final refNew = _database.child('$userId/Usuarios/Avatar/urlFoto/');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return resNew.value.toString();
    }

    /// Get the profile picture from the database at the old path
    final refOld = _database.child('Avatar/$userId/urlFoto/');
    final resOld = await refOld.get();

    if (resOld.exists && resOld.value != null) {
      return resOld.value.toString();
    }

    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final refNew = _database.child('$userId/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      // print('returned from bew');
      return jsonDecode(encode);
    } else {
      final refOld = _database.child('Frases/$userId/$language/$type');
      final resOld = await refOld.get();
      if (resOld.exists && resOld.value != null) {
        final data = resOld.children.first.value as String;
        return jsonDecode(data);
      } else {
        /// if there are no frases we will be returning the empty string
        return [];
      }
    }
  }

  @override
  Future<UserType> getUserType(String userId) async {
    final ref = _database.child('$userId/Pago/Pago');
    final res = await ref.get();
    if (res.value == null || res.value.toString() == "0") return UserType.free;

    return UserType.premium;
  }

  @override
  Future<void> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.child('$userId/Grupos/$language/$index');

    await ref.update(data);
  }

  @override
  Future<void> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.child('$userId/Pictos/$language/$index');

    await ref.update(data);
  }

  @override
  Future<void> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/Grupos/$language');

    await ref.set(data);
  }

  @override
  Future<void> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/Pictos/$language');

    await ref.set(data);
  }

  @override
  Future<void> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    final ref = _database.child('$userId/Usuarios/');

    await ref.set(data);
  }

  @override
  Future<void> uploadUserPicture(String userId, String picture, String photoUrl) async {
    final ref = _database.child('$userId/Usuarios/Avatar/');
    await ref.update({
      'name': photoUrl,
      'urlFoto': picture,
    });
  }

  @override
  Future<void> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data) async {
    final ref = _database.child('$userId/Frases/$language/$type');

    await ref.set(data);
  }
}
