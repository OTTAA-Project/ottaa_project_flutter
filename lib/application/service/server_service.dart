import 'dart:convert';
import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/arsaac_data_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:universal_io/io.dart';

const String kBaseURL = "https://us-central1-ottaaproject-flutter.cloudfunctions.net";

@Singleton(as: ServerRepository)
class ServerService implements ServerRepository {
  late final FirebaseDatabase _database;
  late final FirebaseStorage _storage;
  late final FirebaseFunctions _functions;
  late final Dio _dio;

  //We need to inject the dio instance, database instance, storage instance and functions isntace to be able to use it in the server service
  ServerService({Dio? dio, FirebaseDatabase? database, FirebaseStorage? storage, FirebaseFunctions? functions}) {
    _dio = dio ?? Dio();
    _dio.options.baseUrl = kBaseURL;
    _database = database ?? FirebaseDatabase.instance;
    _storage = storage ?? FirebaseStorage.instance;
    _functions = functions ?? FirebaseFunctions.instance;
  }

  @FactoryMethod()
  factory ServerService.create() => ServerService();

  @override
  Future<UserType> getUserType(String userId) async {
    final ref = _database.ref().child('$userId/type');
    final res = await ref.get();

    return UserType.values.firstWhere(
      (element) => element.name == res.value.toString(),
      orElse: () => UserType.none,
    );
  }

  @override
  Future<EitherListMap> getAllGroups(String userId, String languageCode) async {
    //Fetch new data from server
    final ref = _database.ref().child('$userId/groups/$languageCode');
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
    final ref = _database.ref().child('$userId/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      final valu = jsonEncode((res.value as dynamic));
      return Right(List.from(jsonDecode(valu).values.toList() as List));
    }
    return const Left("no_data_found");
  }

  @override
  Future<EitherString> getAvailableAppVersion(String platform) async {
    final DatabaseReference ref = _database.ref().child('version/');
    final DataSnapshot res = await ref.get();

    if (!res.exists || res.value == null) return const Left("no_data_found");

    return Right(res.value.toString());
  }

  @override
  Future<EitherMap> getUserInformation(String id) async {
    final userRef = _database.ref().child(id);

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
    final refNew = _database.ref().child('$userId/settings/data/avatar/');
    final resNew = await refNew.get();

    if (resNew.exists && resNew.value != null) {
      return Right(Map.from(resNew.value as Map)["network"]);
    }

    return const Left("no_data_found");
  }

  @override
  Future<List<Map<String, dynamic>>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final refNew = _database.ref().child('$userId/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      print(encode);
      // print('returned from bew');
      return List.from(jsonDecode(encode));
    }

    final refOld = _database.ref().child('Frases/$userId/$language/$type');
    final resOld = await refOld.get();
    if (resOld.exists && resOld.value != null) {
      final encode = jsonEncode(resOld.value);
      // print('returned from bew');
      return List.from(jsonDecode(encode));
    }

    return const [];
  }

  @override
  Future<EitherVoid> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.ref().child('$userId/Grupos/$language/$index');

    final group = await ref.get();
    try {
      if (!group.exists) throw Exception('Group does not exist');
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final ref = _database.ref().child('$userId/Pictos/$language/$index');

    final picto = await ref.get();
    try {
      if (!picto.exists) throw Exception('Picto does not exist');
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
    final ref = _database.ref().child('$userId/settings/data');

    final data = await ref.get();

    try {
      if (!data.exists) throw Exception('User does not exist');
      await ref.update({'lastConnection': time});
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final ref = _database.ref().child('$userId/groups/$language');
    try {
      if (data.isEmpty) throw Exception('Data is empty');
      final mapData = Map.fromIterables(data.map((e) => e["id"]), data);
      bool hasGroups = (await _database.ref().child('$userId/groups').get()).exists;
      if (!hasGroups) {
        await _database.ref().child('$userId/groups').set({language: mapData});
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
    final ref = _database.ref().child('$userId/pictos/$language');

    try {
      if (data.isEmpty) throw Exception('Data is empty');
      final mapData = Map.fromIterables(data.map((e) => e["id"]), data);
      await ref.set(mapData);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    final ref = _database.ref().child(userId);

    try {
      if (data.isEmpty) throw Exception('Data is empty');
      await ref.update(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserPicture(String userId, AssetsImage image) async {
    final ref = _database.ref().child('$userId/settings/data/avatar');
    try {
      if (image.asset.trim().isEmpty) throw Exception('Image is empty');
      await ref.update(image.toMap());
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherVoid> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data) async {
    final ref = _database.ref().child('$userId/Frases/$language/$type');

    try {
      if (data.isEmpty) throw Exception('Data is empty');
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

    try {
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<EitherMap> getPictogramsStatistics(String userId, String languageCode, [CancelToken? cancelToken]) async {
    final body = {
      'UserID': userId,
      //todo: add here the language too
      'Language': 'es_AR',
    };
    try {
      final res = await _dio.post(
        '/readFile',
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> updateUserSettings({
    required Map<String, dynamic> data,
    required String userId,
  }) async {
    final ref = _database.ref().child('$userId/settings/data/');
    await ref.update(data);
  }

  @override
  Future<String> uploadUserImage({
    required String path,
    required String name,
    required String userId,
  }) async {
    Reference ref = _storage.ref().child('userProfilePics').child('$name.jpg');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': path},
    );

    var uploadTask = await ref.putFile(File(path), metadata);

    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<String> uploadOtherImages({
    required String imagePath,
    required String directoryPath,
    required String name,
    required String userId,
  }) async {
    Reference ref = _storage.ref().child(directoryPath).child('$name.jpg');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagePath},
    );

    var uploadTask = await ref.putFile(File(imagePath), metadata);

    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<EitherMap> getConnectedUsers({required String userId}) async {
    final ref = _database.ref().child('$userId/users'); //TODO: Change this to the real path
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<EitherMap> fetchConnectedUserData({required String userId}) async {
    final ref = _database.ref().child(userId); //TODO: Change to real path
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<void> removeCurrentUser({required String userId, required String careGiverId}) async {
    await _database.ref().child('$careGiverId/users/$userId').remove();
  }

  @override
  Future<EitherVoid> setShortcutsForUser({required ShortcutsModel shortcuts, required String userId}) async {
    final ref = _database.ref().child('$userId/settings/layout/shortcuts/');
    final shortcutData = await ref.get();
    try {
      if (!shortcutData.exists) throw Exception('user does not exist');
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
    final ref = _database.ref().child('$userId/settings/layout/shortcuts');

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

      if (res.statusCode == 200) {
        return Right(data);
      } else {
        return Left(data["code"] ?? res.statusCode.toString()); //TODO: Handle the main error
      }
    } catch (e) {
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

    try {
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> updateUserData({
    required Map<String, dynamic> data,
    required String userId,
  }) async {
    final ref = _database.ref().child('$userId/settings/data/');

    await ref.update(data);
  }

  @override
  Future<EitherMap> getProfileById({required String id}) async {
    final ref = _database.ref().child(id);

    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    } else {
      return const Left("No Data found"); //TODO: Handle the main error
    }
  }

  @override
  Future<dynamic> getDefaultGroups(String languageCode) async {
    final ref = _database.ref().child('default/groups/$languageCode');
    final DataSnapshot res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> fetchUserGroups({required String languageCode, required String userId}) async {
    final ref = _database.ref().child('$userId/groups/$languageCode');
    final DataSnapshot res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> getDefaultPictos(String languageCode) async {
    final ref = _database.ref().child('default/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<dynamic> fetchUserPictos({required String languageCode, required String userId}) async {
    final ref = _database.ref().child('$userId/pictos/$languageCode');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }

    return const Left("no_data_found");
  }

  @override
  Future<void> updateUserType({required String id, required UserType userType}) async {
    final ref = _database.ref().child("$id/type");

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
    final ref = _database.ref().child("$userId/settings/devices");

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

    try {
      final res = await _dio.post(
        '/speako/users/learn',
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );

      return Right(jsonDecode(res.data) as Map<String, dynamic>);
    } catch (e) {
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
        queryParameters: {
          "limit": limit,
          "chunk": chunk,
          if(reduced) "reduced": true,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        cancelToken: cancelToken,
      );

      return Right(res.data);
    } catch (e) {
      return const Left("learn_error");
    }
  }

  @override
  Future<EitherString> generatePhraseGPT({required String prompt, required int maxTokens, double temperature = 0}) async {
    try {
      final response = await _functions.httpsCallable("openai").call<Map<String, dynamic>>({
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
    final ref = _database.ref().child("$userId/settings/language/");

    ref.set(map);
  }

  @override
  Future<void> updateVoiceAndSubtitleSettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.ref().child("$userId/settings/tts/");

    ref.update(map);
  }

  @override
  Future<void> updateAccessibilitySettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.ref().child("$userId/settings/accessibility/");

    ref.update(map);
  }

  @override
  Future<void> updateMainSettings({required Map<String, dynamic> map, required String userId}) async {
    final ref = _database.ref().child("$userId/settings/layout/");

    ref.update(map);
  }

  @override
  Future<dynamic> fetchUserSettings({required String userId}) async {
    final ref = _database.ref().child('$userId/settings/');
    final res = await ref.get();

    if (res.exists && res.value != null) {
      return Right(Map.from(res.value as Map<dynamic, dynamic>));
    }
    return const Left("no_data_found");
  }

  @override
  Future<Either<String, List<ArsaacDataModel>>> fetchPhotosFromGlobalSymbols({required String searchText, required String languageCode}) async {
    final String languageFormat = languageCode == 'en_US' ? '639-3' : '639-1';
    final language = languageCode == 'en_US' ? 'eng' : 'es';
    String url = 'https://globalsymbols.com/api/v1/labels/search?query=${searchText.replaceAll(' ', '+')}&language=$language&language_iso_format=$languageFormat&limit=60';
    var urlF = Uri.parse(url);
    http.Response response = await http.get(
      urlF,
      headers: {"Accept": "application/json"},
    );
    // print(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data.toString());
      final List<ArsaacDataModel> res = (jsonDecode(response.body) as List).map((e) => ArsaacDataModel.fromJson(e)).toList();
      print(res.length);
      print(res.last.text);
      print(res.first.text);
      // print(data['symbols'][0]['name']);
      // final res = (jsonDecode(response.body) as List).map((e) => SearchModel.fromJson(e)).toList();
      // SearchModel searchModel = SearchModel.fromJson(jsonDecode(response.body));
      // print(searchModel.itemCount);
      // print(searchModel.symbols[0].name);
      // print(jsonDecode(response.body));
      return Right(res);
    } else {
      return const Left('Error While loading');
    }
  }
}
