import 'dart:convert';
import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:universal_io/io.dart';

@Singleton(as: ServerRepository)
class ServerService implements ServerRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageRef = FirebaseStorage.instance.ref();
  final functions = FirebaseFunctions.instance;

  final Dio _dio = Dio();

  @FactoryMethod(preResolve: true)
  static Future<ServerService> create() async => ServerService()..init();

  @override
  Future<void> init() async {
    _dio.options.baseUrl = "https://us-central1-ottaaproject-flutter.cloudfunctions.net";
  }

  @override
  Future<void> close() async {}

  @override
  Future<UserType> getUserType(String userId) async {
    final ref = _database.child('$userId/type');
    final res = await ref.get();

    return UserType.values.firstWhere(
      (element) => element.name == res.value.toString(),
      orElse: () => UserType.none,
    );
  }

  @override
  Future<EitherListMap> getAllGroups(String userId, String languageCode) async {
    //Fetch new data from server
    final ref = _database.child('$userId/groups/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      final valu = jsonEncode((res.value as dynamic));
      return Right(List.from(jsonDecode(valu).values.toList() as List));
    }
    return const Left("no_data_found");
  }

  @override
  Future<EitherListMap> getAllPictograms(String userId, String languageCode) async {
    //Fetch new data from server
    final ref = _database.child('$userId/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      final valu = jsonEncode((res.value as dynamic));
      return Right(List.from(jsonDecode(valu).values.toList() as List));
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
    final userRef = _database.child(id);

    final userValue = await userRef.get();

    if (!userValue.exists || userValue.value == null) return const Left("no_data_found");

    final dynamic user = userValue.value as dynamic;

    Map settingsData = user["settings"];

    if (settingsData["language"].runtimeType == String) {
      settingsData["language"] = {
        "language": settingsData["language"] ?? "es_AR",
        "labs": false,
      };
    }

    user["settings"] = settingsData;

    return Right(Map<String, dynamic>.from(user));
  }

  @override
  Future<EitherString> getUserProfilePicture(String userId) async {
    final refNew = _database.child('$userId/settings/data/avatar/');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return Right(resNew.value.toString());
    }

    return const Left("no_data_found");
  }

  @override
  Future<List<Phrase>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final refNew = _database.child('$userId/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      // print('returned from bew');
      return (jsonDecode(encode) as List).map((e) => Phrase.fromJson(e)).toList();
      // print('returned from bew');
      // return Right(jsonDecode(data));
    }

    final refOld = _database.child('Frases/$userId/$language/$type');
    final resOld = await refOld.get();
    if (resOld.exists && resOld.value != null) {
      final data = resOld.children.first.value as String;
      return (jsonDecode(data) as List).map((e) => Phrase.fromJson(e)).toList();
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
  Future<EitherVoid> updateUserLastConnectionTime({
    required String userId,
    required int time,
  }) async {
    final ref = _database.child('$userId/settings/data');

    try {
      await ref.update({'lastConnection': time});
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/groups/$language');
    try {
      final mapData = Map.fromIterables(data.map((e) => e["id"]), data);
      bool hasGroups = (await _database.child('$userId/groups').get()).exists;
      if (!hasGroups) {
        await _database.child('$userId/groups').set({language: mapData});
      } else {
        await ref.set(mapData);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.child('$userId/pictos/$language');

    try {
      final mapData = Map.fromIterables(data.map((e) => e["id"]), data);
      await ref.set(mapData);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    final ref = _database.child(userId);

    try {
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserPicture(String userId, AssetsImage image) async {
    final ref = _database.child('$userId/settings/data/avatar');

    try {
      await ref.update(image.toMap());
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
  Future<EitherMap> getMostUsedSentences(String userId, String languageCode, [CancelToken? cancelToken]) async {
    //todo: get the language here after talking with Emir
    final body = {
      'UserID': userId,
      'Language': languageCode,
    };
    final res = await _dio.post(
      '/onReqFunc',
      data: jsonEncode(body),
      cancelToken: cancelToken,
      options: Options(
        contentType: 'application/json',
      ),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.data) as Map<String, dynamic>;
      return Right(data);
    } else {
      return const Left("an error occurred"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> getPictogramsStatistics(String userId, String languageCode, [CancelToken? cancelToken]) async {
    final uri = Uri.parse('');
    final body = {
      'UserID': userId,
      //todo: add here the language too
      'Language': 'es_AR',
    };
    final res = await _dio.post(
      'readFile',
      data: jsonEncode(body),
      cancelToken: cancelToken,
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.data) as Map<String, dynamic>;
      return Right(data);
    } else {
      return const Left("an error occurred"); //TODO: Handle the main error
    }
  }

  @override
  Future<void> updateUserSettings({
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

    var uploadTask = await ref.putFile(File(path), metadata);

    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<EitherMap> getConnectedUsers({required String userId}) async {
    final ref = _database.child('$userId/users'); //TODO: Change this to the real path
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> fetchConnectedUserData({required String userId}) async {
    final ref = _database.child(userId); //TODO: Change to real path
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
  Future<EitherVoid> setShortcutsForUser({required ShortcutsModel shortcuts, required String userId}) async {
    final ref = _database.child('$userId/settings/layout/shortcuts/');

    try {
      final data = shortcuts.toMap();
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherMap> fetchShortcutsForUser({
    required String userId,
  }) async {
    final ref = _database.child('$userId/settings/shortcuts');

    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> getEmailToken(String ownEmail, String email, [CancelToken? cancelToken]) async {
    final body = {
      'src': ownEmail,
      'dst': email,
    };

    try {
      final res = await _dio.post(
        '/linkUserRequest',
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );

      final data = res.data as Map<String, dynamic>;
      print(res.statusCode);
      if (res.statusCode == 200) {
        return Right(data);
      } else {
        return Left(data["code"] ?? res.statusCode.toString()); //TODO: Handle the main error
      }
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<EitherMap> verifyEmailToken(String ownEmail, String email, String token, [CancelToken? cancelToken]) async {
    final body = {
      'src': ownEmail,
      'dst': email,
      'token': token,
    };
    final res = await _dio.post(
      "/linkUserConfirm",
      data: jsonEncode(body),
      cancelToken: cancelToken,
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );

    final data = res.data as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return Right(data);
    } else {
      return Left(data["code"] ?? res.statusMessage); //TODO: Handle the main error
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
  Future<EitherMap> getProfileById({required String id}) async {
    final ref = _database.child(id);

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
    final DataSnapshot res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> fetchUserGroups({required String languageCode, required String userId}) async {
    final ref = _database.child('$userId/groups/$languageCode');
    final DataSnapshot res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> getDefaultPictos(String languageCode) async {
    final ref = _database.child('default/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> fetchUserPictos({required String languageCode, required String userId}) async {
    final ref = _database.child('$userId/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<void> updateUserType({required String id, required UserType userType}) async {
    final ref = _database.child("$id/type");

    await ref.set(userType.name);
  }

  @override
  Future<Map<String, dynamic>?> createPictoGroupData({
    required String userId,
    required String language,
    required BoardDataType type,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
  }) async {
    final body = {"uid": userId, "lang": language, "type": type.name, "data": data};
    try {
      final res = await _dio.post(
        '/newCustomData',
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );

      return res.data as Map<String, dynamic>;
    } catch (e) {
      return {
        "error": e.toString(),
      };
    }
  }

  @override
  Future<void> updateDevicesId({required String userId, required DeviceToken deviceToken}) async {
    final ref = _database.child("$userId/settings/devices");

    final currentList = (await ref.get()).value;

    List list = List<dynamic>.from((currentList ?? []) as List<dynamic>);

    final existsElement = list.firstWhereOrNull((element) => element != null ? element["deviceToken"] == deviceToken.deviceToken : false);

    final index = list.indexOf(existsElement);

    if (index == -1) {
      list.add(deviceToken.toMap());
    } else {
      existsElement["lastUsage"] = DateTime.now().millisecondsSinceEpoch;
      list[index] = deviceToken.toMap();
    }
    list = list.where((element) => element != null).toList();

    await ref.set(list);
  }

  @override
  Future<EitherMap> learnPictograms({
    required String uid,
    required String language,
    required String model,
    required List<Map<String, dynamic>> tokens,
    CancelToken? cancelToken,
  }) async {
    final body = {
      "uid": uid,
      "language": language,
      "model": model,
      "tokens": tokens,
    };

    print(tokens);

    try {
      final res = await _dio.post(
        '/speako/users/learn',
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );

      return Right(res.data);
    }  on DioError catch(e) {
      // handle te responde error
      print(e.response);
      return Left("Server error");
    } catch (e) {
      print(e);
      // handle te responde error
      return const Left("learn_error");
    }
  }

  @override
  Future<EitherMap> predictPictogram({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    required List<String> groups,
    required Map<String, List<String>> tags,
    bool reduced = false,
    int limit = 10,
    int chunk = 4,
    CancelToken? cancelToken,
  }) async {
    String url = '/speako/predict';

    url = "$url?limit=$limit&chunk=$chunk";

    if (reduced) url = "$url&reduced";

    print(reduced);

    final body = {
      "sentence": sentence,
      "uid": uid,
      "language": language,
      "model": model,
      "groups": groups,
      "tags": tags,
    };

    try {
      final res = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        cancelToken: cancelToken,
      );

      return Right(res.data);
    } catch (e) {
      // handle te responde error
      return const Left("learn_error");
    }
  }

  @override
  Future<EitherString> generatePhraseGPT({required String prompt, required int maxTokens, double temperature = 0}) async {
    try {
      final response = await functions.httpsCallable("openai").call<Map<String, dynamic>>({
        "model": "text-davinci-003",
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": maxTokens,
      });

      if (response.data["choices"] == null || response.data["choices"][0] == null) {
        return const Left("no_data_found");
      }
      return Right(response.data["choices"][0]["text"].toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> updateLanguageSettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.child("$userId/settings/language/");

    ref.set(map);
  }

  @override
  Future<void> updateVoiceAndSubtitleSettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.child("$userId/settings/tts/");

    ref.update(map);
  }

  @override
  Future<void> updateAccessibilitySettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.child("$userId/settings/accessibility/");

    ref.update(map);
  }

  @override
  Future<void> updateMainSettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.child("$userId/settings/layout/");

    ref.update(map);
  }

  @override
  Future<dynamic> fetchUserSettings({required String userId}) async {
    final ref = _database.child('$userId/settings/');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }
    return const Left("no_data_found");
  }
}
