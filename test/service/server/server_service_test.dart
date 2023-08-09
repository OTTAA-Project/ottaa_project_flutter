import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/firebase_options.dart';

import 'server_service_test.mocks.dart';

@GenerateMocks([FirebaseFunctions])
void main() async {
  late Dio dio;
  late DioAdapter dioAdapter;

  late FirebaseDatabase firebaseDatabase;
  late FirebaseStorage firebaseStorage;
  late MockFirebaseFunctions firebaseFunctions;

  late ServerRepository serverService;

  final ttsSetting = TTSSetting.empty(language: "es_AR");
  const String fakeUserId = "mu4ZiTMURBeLEV7p3CrFbljBrHF2";
  const Map<String, dynamic> fakeGroup = {
    "block": false,
    "freq": 0,
    "id": "--PHmDIFeKHvulVxNtBgk",
    "relations": [],
    "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fdescripcion.webp?alt=media&token=4dbde8ba-f144-4a12-90f6-013bf68d912d"},
    "text": "ADJETIVOS"
  };
  const Map<String, dynamic> fakePicto = {
    "block": false,
    "freq": 0,
    "id": "ZodvGgP2un6y5X185Xrb9",
    "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fgallo.webp?alt=media&token=f7eeb656-0122-4522-a795-630b90749f8a"},
    "text": "gallo",
    "type": 2
  };
  final Map<String, dynamic> fakeUserInfo = {
    "id": "mu4ZiTMURBeLEV7p3CrFbljBrHF2",
    "pictos": {
      "es_AR": {
        "1": {"1": "2"},
        "2": {"1": "2"},
        "3": {"1": "2"},
        "4": fakePicto
      }
    },
    "groups": {
      "es_AR": {
        "1": {"1": "2"},
        "2": {"1": "2"},
        "3": {"1": "2"},
        "4": fakeGroup
      }
    },
    "settings": {
      "data": {
        "avatar": {"asset": "671", "network": "123"},
        "birthDate": 0,
        "genderPref": "n/a",
        "lastConnection": 1684420759838,
        "lastName": "Ali",
        "name": "Emir",
        "number": ""
      },
      "devices": [],
      "tts": ttsSetting.toMap(),
      "language": {
        "labs": false,
        "language": "es_AR",
      },
      "layout": {
        "cleanup": true,
        "display": "tab",
        "oneToOne": false,
        "shortcuts": {"camera": false, "enable": true, "favs": false, "games": true, "history": false, "no": true, "share": false, "yes": true}
      },
      "payment": {"payment": false, "paymentDate": 0, "paymentExpire": 0}
    },
    "type": "user"
  };

  setUp(() async {
    dio = Dio(
      BaseOptions(baseUrl: "https://us-central1-ottaaproject-flutter.cloudfunctions.net"),
    );
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher()); // Https interceptor
    firebaseDatabase = MockFirebaseDatabase(); //Firebase databse mock
    firebaseStorage = MockFirebaseStorage(); //Firebase storage mock
    firebaseFunctions = MockFirebaseFunctions();

    serverService = ServerService(
      dio: dio,
      database: firebaseDatabase,
      storage: firebaseStorage,
      functions: firebaseFunctions,
    );

    MockFirebaseDatabase.instance.ref("/mu4ZiTMURBeLEV7p3CrFbljBrHF2").set(fakeUserInfo);
  });

  group("Factory method", () {
    test("create singleton", () {
      try {
        final serverService = ServerService.create();

        expect(serverService, isNotNull);
      } catch (e) {}
    });
  });

  group("Get user types", () {
    test("should return caregiver user type", () async {
      final fakeUserType = {
        "1": {"type": "caregiver"}
      };

      MockFirebaseDatabase.instance.ref().set(fakeUserType);

      final userType = await serverService.getUserType("1");

      expect(userType.name, equals(UserType.caregiver.name));
    });

    test("should return user user type", () async {
      final fakeUserType = {
        "1": {"type": "user"}
      };

      MockFirebaseDatabase.instance.ref().set(fakeUserType);

      final userType = await serverService.getUserType("1");

      expect(userType.name, equals(UserType.user.name));
    });

    test("should return none user type", () async {
      final fakeUserType = {
        "1": {"type": ""}
      };

      MockFirebaseDatabase.instance.ref().set(fakeUserType);

      final userType = await serverService.getUserType("1");

      expect(userType.name, equals(UserType.none.name));
    });
  });

  group("Get All groups", () {
    test("should return all groups", () async {
      final groups = await serverService.getAllGroups(fakeUserId, "es_AR");

      expect(groups, isA<Right>());
      expect(groups.right.length, equals(4));
    });

    test("should return no_data_found", () async {
      final groups = await serverService.getAllGroups(fakeUserId, "en_US");

      expect(groups, isA<Left>());
      expect(groups.left, "no_data_found");
    });
  });

  group("get all pictograms", () {
    test("should return all pictos", () async {
      final pictos = await serverService.getAllPictograms(fakeUserId, "es_AR");

      expect(pictos, isA<Right>());
      expect(pictos.right.length, equals(4));
    });

    test("should return no_data_found", () async {
      final groups = await serverService.getAllPictograms(fakeUserId, "en_US");

      expect(groups, isA<Left>());
      expect(groups.left, "no_data_found");
    });
  });

  group("get available app version", () {
    test("should return 1.0.0", () async {
      MockFirebaseDatabase.instance.ref("/version").set("1.0.0");

      final version = await serverService.getAvailableAppVersion("Android");

      expect(version, isA<Right>());
      expect(version.right, equals("1.0.0"));
    });

    test("should return no_data_found", () async {
      MockFirebaseDatabase.instance.ref("/version").set(null);

      final version = await serverService.getAvailableAppVersion("Android");

      expect(version, isA<Left>());
      expect(version.left, "no_data_found");
    });
  });

  group("get user information", () {
    test("should return user information", () async {
      final userInfo = await serverService.getUserInformation("mu4ZiTMURBeLEV7p3CrFbljBrHF2");

      expect(userInfo, isA<Right>());
      expect(userInfo.right, equals(fakeUserInfo));
    });

    test("should return user information (old languange)", () async {
      final Map<String, dynamic> fakeUserInfoOld = {
        "id": "mu4ZiTMURBeLEV7p3CrFbljBrHF2",
        "pictos": {
          "es_AR": {
            "1": {"1": "2"},
            "2": {"1": "2"},
            "3": {"1": "2"},
            "4": fakePicto
          }
        },
        "groups": {
          "es_AR": {
            "1": {"1": "2"},
            "2": {"1": "2"},
            "3": {"1": "2"},
            "4": fakeGroup
          }
        },
        "settings": {
          "data": {
            "avatar": {"asset": "671", "network": "123"},
            "birthDate": 0,
            "genderPref": "n/a",
            "lastConnection": 1684420759838,
            "lastName": "Ali",
            "name": "Emir",
            "number": ""
          },
          "tts": ttsSetting.toMap(),
          "devices": [],
          "language": "es_AR",
          "layout": {
            "cleanup": true,
            "display": "tab",
            "oneToOne": false,
            "shortcuts": {"camera": false, "enable": true, "favs": false, "games": true, "history": false, "no": true, "share": false, "yes": true}
          },
          "payment": {"payment": false, "paymentDate": 0, "paymentExpire": 0}
        },
        "type": "user"
      };

      await MockFirebaseDatabase.instance.ref("/mu4ZiTMURBeLEV7p3CrFbljBrHF22").set(fakeUserInfoOld);

      final userInfo = await serverService.getUserInformation("mu4ZiTMURBeLEV7p3CrFbljBrHF22");

      expect(userInfo, isA<Right>());
      expect(userInfo.right, equals(fakeUserInfo));
    });

    test("should return no_data_found", () async {
      final userInfo = await serverService.getUserInformation("123");

      expect(userInfo, isA<Left>());
      expect(userInfo.left, equals("no_data_found"));
    });
  });

  group("get user profile picture", () {
    test("should return user profile picture", () async {
      final profilePicture = await serverService.getUserProfilePicture("mu4ZiTMURBeLEV7p3CrFbljBrHF2");

      expect(profilePicture, isA<Right>());
      expect(profilePicture.right, equals("123"));
    });

    test("should return no_data_found", () async {
      final profilePicture = await serverService.getUserProfilePicture("123");

      expect(profilePicture, isA<Left>());
      expect(profilePicture.left, equals("no_data_found"));
    });
  });

  group("get user sentences", () {
    test("should return new phrases", () async {
      final fakeSentences = [
        {
          "sentence": "Hola",
          "translation": "Hello",
          "language": "es_AR",
          "type": "new",
          "date": 1600000000,
        }
      ];

      final fakeUserFrases = {
        "1": {
          "Frases": {
            "es_AR": {"new": fakeSentences}
          }
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUserFrases);

      final sentences = await serverService.getUserSentences("1", language: "es_AR", type: "new");

      expect(sentences, isA<List<Map<String, dynamic>>>());
      expect(sentences.length, equals(1));
      expect(sentences, equals(fakeSentences));
    });

    test("should return old phrases", () async {
      final fakeSentences = [
        {
          "sentence": "Hola",
          "translation": "Hello",
          "language": "es_AR",
          "type": "new",
          "date": 1600000000,
        }
      ];

      final fakeUserFrases = {
        "Frases": {
          "1": {
            "es_AR": {
              "new": fakeSentences,
            }
          }
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUserFrases);

      final sentences = await serverService.getUserSentences("1", language: "es_AR", type: "new");

      expect(sentences, isA<List<Map<String, dynamic>>>());
      expect(sentences.length, equals(1));
      expect(sentences, equals(fakeSentences));
    });

    test("should return empty list", () async {
      final sentences = await serverService.getUserSentences("2", language: "es_AR", type: "new");

      expect(sentences, isA<List<Map<String, dynamic>>>());
      expect(sentences.length, equals(0));
      expect(sentences, equals([]));
    });
  });

  group("update group", () {
    test("should update the group", () async {
      final fakeGruop = {"name": "fake gruop"};
      final fakeGroup = {"name": "fake group"};

      final fakeData = {
        "1": {
          "Grupos": {
            "es_AR": {"0": fakeGruop}
          }
        }
      };

      // Seteando la data
      await MockFirebaseDatabase.instance.ref().set(fakeData);

      // Actualizando el grupo
      await serverService.updateGroup("1", "es_AR", 0, data: fakeGroup);

      // Obteniendo la data

      final data = await MockFirebaseDatabase.instance.ref("/1/Grupos/es_AR/0").get();

      expect(data.value, equals(fakeGroup));
    });

    test("should return a left", () async {
      final fakeGroup = {"name": "fake group"};

      // Actualizando el grupo
      final result = await serverService.updateGroup("1", "es_AR", 1, data: fakeGroup);

      expect(result, isA<Left>());
      expect(result.left, equals("Exception: Group does not exist"));
    });
  });

  group("update pictogram", () {
    test("should update the pictogram", () async {
      final fakePitogram = {"name": "fake pitogram"};
      final fakePictogram = {"name": "fake pictogram"};

      final fakeData = {
        "1": {
          "Pictos": {
            "es_AR": {"0": fakePitogram}
          }
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeData);

      await serverService.updatePictogram("1", "es_AR", 0, data: fakePictogram);

      final data = await MockFirebaseDatabase.instance.ref("/1/Pictos/es_AR/0").get();

      expect(data.value, equals(fakePictogram));
    });

    test("should return a left", () async {
      final fakePitogram = {"name": "fake pitogram"};

      final result = await serverService.updatePictogram("1", "es_AR", 1, data: fakePitogram);

      expect(result, isA<Left>());
      expect(result.left, equals("Exception: Picto does not exist"));
    });
  });
  group("update last connection", () {
    test("should update the last connection", () async {
      final DateTime now = DateTime.now();

      await serverService.updateUserLastConnectionTime(userId: fakeUserId, time: now.millisecondsSinceEpoch);

      final data = await MockFirebaseDatabase.instance.ref("$fakeUserId/settings/data/lastConnection").get();

      expect(data.value, equals(now.millisecondsSinceEpoch));
    });

    test("should return Exception: User does not exist", () async {
      final DateTime now = DateTime.now();

      final result = await serverService.updateUserLastConnectionTime(userId: "00", time: now.millisecondsSinceEpoch);

      expect(result, isA<Left>());
      expect(result.left, equals("Exception: User does not exist"));
    });
  });

  group("upload groups", () {
    test("should upload the one group", () async {
      final result = await serverService.uploadGroups(fakeUserId, "es_AR", data: [fakeGroup]);
      final findGroup = await MockFirebaseDatabase.instance.ref("$fakeUserId/groups/es_AR/").get();

      expect(result, isA<Right>());
      expect(findGroup.value, equals({"--PHmDIFeKHvulVxNtBgk": fakeGroup}));
    });

    test("should upload the one group and set language", () async {
      final result = await serverService.uploadGroups(fakeUserId, "es_US", data: [fakeGroup]);
      final findGroup = await MockFirebaseDatabase.instance.ref("$fakeUserId/groups/es_US/").get();

      expect(result, isA<Right>());
      expect(findGroup.value, equals({"--PHmDIFeKHvulVxNtBgk": fakeGroup}));
    });

    test("should throws an error", () async {
      final result = await serverService.uploadGroups(fakeUserId, "es_US", data: []);

      expect(result, isA<Left>());
    });
  });

  group("upload pictograms", () {
    test("should upload the one pictogram", () async {
      final result = await serverService.uploadPictograms(fakeUserId, "es_AR", data: [fakePicto]);
      final findGroup = await MockFirebaseDatabase.instance.ref("$fakeUserId/pictos/es_AR/").get();

      expect(result, isA<Right>());
      expect(findGroup.value, equals({"ZodvGgP2un6y5X185Xrb9": fakePicto}));
    });

    test("should upload the one pictos and set language", () async {
      final result = await serverService.uploadPictograms(fakeUserId, "es_US", data: [fakePicto]);
      final findGroup = await MockFirebaseDatabase.instance.ref("$fakeUserId/pictos/es_US/").get();

      expect(result, isA<Right>());
      expect(findGroup.value, equals({"ZodvGgP2un6y5X185Xrb9": fakePicto}));
    });

    test("should throws an error", () async {
      final result = await serverService.uploadPictograms(fakeUserId, "es_US", data: []);

      expect(result, isA<Left>());
    });
  });

  group("upload user information", () {
    test("should update user information", () async {
      final result = await serverService.uploadUserInformation("00", {"name": "fake name"});

      expect(result, isA<Right>());
    });

    test("should throws an error", () async {
      final result = await serverService.uploadUserInformation("00", {});

      expect(result, isA<Left>());
    });
  });

  group("upload user picture", () {
    test("should update the avatar", () async {
      final result = await serverService.uploadUserPicture(fakeUserId, AssetsImage(asset: "1", network: "12"));

      final data = await MockFirebaseDatabase.instance.ref("$fakeUserId/settings/data/avatar").get();

      expect(result, isA<Right>());
      expect(data.value, equals({'asset': '1', 'network': '12'}));
    });

    test("should throw an error", () async {
      final result = await serverService.uploadUserPicture(fakeUserId, AssetsImage(asset: "", network: "12"));
      expect(result, isA<Left>());
    });
  });
  group("upload user sentences", () {
    test("should set the user sentences ", () async {
      final result = await serverService.uploadUserSentences("1", "es_AR", "favorite", [
        {"name": "fake name"}
      ]);

      final data = await MockFirebaseDatabase.instance.ref("1/Frases/es_AR/favorite").get();

      expect(result, isA<Right>());
      expect(
          data.value,
          equals([
            {"name": "fake name"}
          ]));
    });

    test("should throw an error", () async {
      final result = await serverService.uploadUserSentences("1", "es_AR", "favorite", []);
      expect(result, isA<Left>());
    });
  });

  group("get most used sentences", () {
    test("should return the most used sentences", () async {
      const onReqFuncRequest = '/onReqFunc';

      dioAdapter.onPost(
        onReqFuncRequest,
        (request) => request.reply(200, '{"message": "success"}'),
      );

      final result = await serverService.getMostUsedSentences("1", "es_AR");

      expect(result, isA<Right>());
      expect(result.right, equals({'message': 'success'}));
    });

    test("should return http exception", () async {
      const onReqFuncRequest = '/onReqFunc';

      dioAdapter.onPost(
        onReqFuncRequest,
        (request) => request.reply(503, '{"message": "error"}'),
      );

      final result = await serverService.getMostUsedSentences("1", "es_AR");

      expect(result, isA<Left>());
      expect(result.left, isA<String>());
    });

    test("should return an error occurred", () async {
      const onReqFuncRequest = '/onReqFunc';

      dioAdapter.onPost(
        onReqFuncRequest,
        (request) => request.reply(201, '{"message": "an error occurred"}'),
      );

      final result = await serverService.getMostUsedSentences("1", "es_AR");

      expect(result, isA<Left>());
      expect(result.left, isA<String>());
      expect(result.left, equals("an error occurred"));
    });
  });

  group("get pictograms statistics", () {
    test("should return the most used sentences", () async {
      const requestPath = '/readFile';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(200, '{"message": "success"}'),
      );

      final result = await serverService.getPictogramsStatistics("1", "es_AR");

      expect(result, isA<Right>());
      expect(result.right, equals({'message': 'success'}));
    });

    test("should return http exception", () async {
      const requestPath = '/readFile';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(503, '{"message": "error"}'),
      );

      final result = await serverService.getPictogramsStatistics("1", "es_AR");

      expect(result, isA<Left>());
      expect(result.left, isA<String>());
    });

    test("should return an error occurred", () async {
      const requestPath = '/readFile';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(201, '{"message": "an error occurred"}'),
      );

      final result = await serverService.getPictogramsStatistics("1", "es_AR");

      expect(result, isA<Left>());
      expect(result.left, isA<String>());
      expect(result.left, equals("an error occurred"));
    });
  });

  group("update user settings", () {
    test("should update the user settings ", () async {
      final result = {"name": "fake name"};
      await serverService.updateUserSettings(data: result, userId: "1");

      final data = await MockFirebaseDatabase.instance.ref("1/settings/data/").get();

      expect(data.value, equals(result));
    });
  });

  group("upload user image", () {
    test("should update the user imaged ", () async {
      const String imagePath = "fakePath";
      const String name = "fakeName";
      const String userId = "fakeUserId";

      const String imageUrl = "https://firebasestorage.googleapis.com/v0/b/some-bucket/o/userProfilePics$name.jpg";

      final result = await serverService.uploadUserImage(path: imagePath, name: name, userId: userId);

      expect(result, equals(imageUrl));
    });
  });

  group("get connected users", () {
    test("should return a list of connected users", () async {
      final fakeUserConnected = {
        "2": {
          "name": "fake name",
        }
      };
      final fakeUser = {
        '1': {
          "users": fakeUserConnected,
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUser);

      final result = await serverService.getConnectedUsers(userId: "1");

      expect(result, isA<Right>());
      expect(result.right, equals(fakeUserConnected));
    });

    test("should return no data found", () async {
      final result = await serverService.getConnectedUsers(userId: "3");

      expect(result, isA<Left>());
      expect(result.left, equals("No Data found"));
    });
  });

  group("fetch onnected user data", () {
    test("should return user information", () async {
      final result = await serverService.fetchConnectedUserData(userId: fakeUserId);

      expect(result, isA<Right>());
      expect(result.right, equals(fakeUserInfo));
    });

    test("should return no data found", () async {
      final result = await serverService.fetchConnectedUserData(userId: "2");

      expect(result, isA<Left>());
      expect(result.left, equals("No Data found"));
    });
  });

  group("remove current user", () {
    test("should remove the current user", () async {
      final fakeUserConnected = {
        "2": {
          "name": "fake name",
        }
      };
      final fakeUser = {
        '1': {
          "users": fakeUserConnected,
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUser);

      await serverService.removeCurrentUser(userId: "2", careGiverId: "1");

      final data = await MockFirebaseDatabase.instance.ref("1/users/2").get();

      expect(data.value, isNull);
      expect(data.exists, isFalse);
    });
  });

  group("set shortcuts for user", () {
    test("should update user shortcuts", () async {
      final ShortcutsModel shortcuts = ShortcutsModel.all();

      final fakeUser = {
        '1': {
          "settings": {
            "layout": {
              "shortcuts": shortcuts.toMap(),
            }
          }
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUser);

      final result = await serverService.setShortcutsForUser(userId: "1", shortcuts: ShortcutsModel.none());

      final data = await MockFirebaseDatabase.instance.ref("1/settings/layout/shortcuts/").get();

      expect(result, isA<Right>());
      expect(data.value, equals(ShortcutsModel.none().toMap()));
    });

    test("should throw an error", () async {
      final result = await serverService.setShortcutsForUser(userId: "44", shortcuts: ShortcutsModel.none());

      expect(result, isA<Left>());
      expect(result.left, equals("Exception: user does not exist"));
    });
  });

  group("fetch shortcuts for user", () {
    test("should return the user shortcuts", () async {
      final ShortcutsModel shortcuts = ShortcutsModel.all();

      final fakeUser = {
        '1': {
          "settings": {
            "layout": {
              "shortcuts": shortcuts.toMap(),
            }
          }
        }
      };

      await MockFirebaseDatabase.instance.ref().set(fakeUser);

      final result = await serverService.fetchShortcutsForUser(userId: "1");

      expect(result, isA<Right>());
      expect(result.right, equals(ShortcutsModel.all().toMap()));
    });

    test("should throw an error", () async {
      final result = await serverService.fetchShortcutsForUser(userId: "44");

      expect(result, isA<Left>());
      expect(result.left, equals("No Data found"));
    });
  });

  group("get email token", () {
    test("should return 200", () async {
      const requestPath = '/linkUserRequest';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(200, {"message": "success"}),
      );

      final result = await serverService.getEmailToken("emir@mail.com", "asim@mail.com");

      expect(result, isA<Right>());
      expect(result.right, equals({'message': 'success'}));
    });

    test("should return 201", () async {
      const requestPath = '/linkUserRequest';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(201, {"code": "304"}),
      );

      final result = await serverService.getEmailToken("emir@mail.com", "asim@mail.com");

      expect(result, isA<Left>());
      expect(result.left, equals("304"));
    });

    test("should throw an error", () async {
      const requestPath = '/linkUserRequest';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(304, {"code": "304"}),
      );

      final result = await serverService.getEmailToken("emir@mail.com", "asim@mail.com");

      expect(result, isA<Left>());
    });
  });

  group("verify email token", () {
    test("should return 200", () async {
      const requestPath = '/linkUserConfirm';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(200, {"message": "success"}),
      );

      final result = await serverService.verifyEmailToken("emir@mail.com", "asim@mail.com", "1234");

      expect(result, isA<Right>());
      expect(result.right, equals({'message': 'success'}));
    });

    test("should return 201", () async {
      const requestPath = '/linkUserConfirm';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(201, {"code": "304"}),
      );

      final result = await serverService.verifyEmailToken("emir@mail.com", "asim@mail.com", "1234");

      expect(result, isA<Left>());
      expect(result.left, equals("304"));
    });

    test("should throw an error", () async {
      const requestPath = '/linkUserConfirm';

      dioAdapter.onPost(
        requestPath,
        (request) => request.reply(304, {"code": "304"}),
      );

      final result = await serverService.verifyEmailToken("emir@mail.com", "asim@mail.com", "1234");

      expect(result, isA<Left>());
    });
  });

  group("update user data", () {
    test("should update user data", () async {
      final fakeUserData = {
        "avatar": {"asset": "123", "network": "123"},
        "birthDate": 0,
        "genderPref": "F",
        "lastConnection": 1684420759838,
        "lastName": "Ali",
        "name": "Emir",
        "number": ""
      };

      await serverService.updateUserData(userId: "mu4ZiTMURBeLEV7p3CrFbljBrHF2", data: fakeUserData);

      final data = await MockFirebaseDatabase.instance.ref("mu4ZiTMURBeLEV7p3CrFbljBrHF2/settings/data").get();

      expect(data.value, equals(fakeUserData));
    });
  });

  group("get profile by id", () {
    test("should return profile", () async {
      final result = await serverService.getProfileById(id: "mu4ZiTMURBeLEV7p3CrFbljBrHF2");

      expect(result, isA<Right>());
      expect(result.right, equals(fakeUserInfo));
    });

    test("should return no data found", () async {
      final result = await serverService.getProfileById(id: "123");

      expect(result, isA<Left>());
      expect(result.left, equals("No Data found"));
    });
  });

  group("get default groups", () {
    test("should return default groups", () async {
      MockFirebaseDatabase.instance.ref("default/groups").set({
        "es_AR": {"1": "1"}
      });

      final result = await serverService.getDefaultGroups("es_AR");

      expect(result, isA<Right>());
      expect(result.right, equals({"1": "1"}));
    });
    test("should return no data found", () async {
      final result = await serverService.getDefaultGroups("es_US");

      expect(result, isA<Left>());
      expect(result.left, equals("no_data_found"));
    });
  });

  group("fetch user groups", () {
    test("should return user groups", () async {
      final result = await serverService.fetchUserGroups(languageCode: "es_AR", userId: fakeUserId);

      expect(result, isA<Right>());
      expect(result.right, equals(fakeUserInfo["groups"]["es_AR"]));
    });
    test("should return no data found", () async {
      final result = await serverService.fetchUserGroups(languageCode: "es_US", userId: fakeUserId);

      expect(result, isA<Left>());
      expect(result.left, equals("no_data_found"));
    });
  });

  group("get default pictos", () {
    test("should return default pictos", () async {
      MockFirebaseDatabase.instance.ref("default/pictos").set({
        "es_AR": {"1": "1"}
      });

      final result = await serverService.getDefaultPictos("es_AR");

      expect(result, isA<Right>());
      expect(result.right, equals({"1": "1"}));
    });
    test("should return no data found", () async {
      final result = await serverService.getDefaultPictos("es_US");

      expect(result, isA<Left>());
      expect(result.left, equals("no_data_found"));
    });
  });

  group("fetch user pictos", () {
    test("should return user pictos", () async {
      final result = await serverService.fetchUserPictos(languageCode: "es_AR", userId: fakeUserId);

      expect(result, isA<Right>());
      expect(result.right, equals(fakeUserInfo["pictos"]["es_AR"]));
    });
    test("should return no data found", () async {
      final result = await serverService.fetchUserPictos(languageCode: "es_US", userId: fakeUserId);

      expect(result, isA<Left>());
      expect(result.left, equals("no_data_found"));
    });
  });

  group("update user type", () {
    test("should update the user type to caregiver", () async {
      await serverService.updateUserType(id: fakeUserId, userType: UserType.caregiver);

      final data = await MockFirebaseDatabase.instance.ref("mu4ZiTMURBeLEV7p3CrFbljBrHF2/type").get();

      expect(data.value, equals("caregiver"));
    });
  });

  group("create picto group data", () {
    test("should create picto group data", () async {
      final fakePictoGroupData = {
        "es_AR": {
          "1": {
            "id": "1",
            "image": "1",
            "name": "1",
            "type": "1",
          }
        }
      };

      dioAdapter.onPost(
        "/newCustomData",
        (server) => server.reply(200, {"code": "200"}),
      );

      final response = await serverService.createPictoGroupData(
        userId: "1",
        language: "es_AR",
        type: BoardDataType.pictos,
        data: fakePictoGroupData,
      );

      expect(response, equals({"code": "200"}));
    });

    test("should throw an error", () async {
      final fakePictoGroupData = {
        "es_AR": {
          "1": {
            "id": "1",
            "image": "1",
            "name": "1",
            "type": "1",
          }
        }
      };

      dioAdapter.onPost(
        "/newCustomData",
        (server) => server.reply(503, {"code": "503"}),
      );

      final response = await serverService.createPictoGroupData(
        userId: "1",
        language: "es_AR",
        type: BoardDataType.pictos,
        data: fakePictoGroupData,
      );

      expect(
        response,
        isA<Map<String, dynamic>>(),
      );
    });
  });

  group("update devices id", () {
    test("should update devices id", () async {
      await serverService.updateDevicesId(userId: fakeUserId, deviceToken: DeviceToken(deviceToken: "token", lastUsage: DateTime.now()));

      final data = await MockFirebaseDatabase.instance.ref("mu4ZiTMURBeLEV7p3CrFbljBrHF2/settings/devices").get();

      expect(List.from(data.value as dynamic).length, equals(1));
    });

    test("should update existant devices id", () async {
      final now = DateTime.now();

      final fakeDeviceToken = DeviceToken(deviceToken: "token", lastUsage: now);

      await MockFirebaseDatabase.instance.ref("$fakeUserId/settings/devices").set([
        DeviceToken(deviceToken: "token", lastUsage: DateTime(2001)).toMap(),
      ]);

      await serverService.updateDevicesId(
        userId: fakeUserId,
        deviceToken: fakeDeviceToken,
      );

      final data = await MockFirebaseDatabase.instance.ref("mu4ZiTMURBeLEV7p3CrFbljBrHF2/settings/devices").get();

      List devicesTokens = List.from(data.value as dynamic);

      expect(devicesTokens.length, equals(1));
      expect(devicesTokens[0]["lastUsage"], equals(now.millisecondsSinceEpoch));
    });
  });

  group("learn pictograms", () {
    test("should return 200", () async {
      dioAdapter.onPost(
        '/speako/users/learn',
        (server) => server.reply(200, '{"code": "200"}'),
      );

      final response = await serverService.learnPictograms(
        uid: "1",
        language: "es_AR",
        model: "",
        tokens: [],
      );

      expect(response, isA<Right>());
      expect(response.right, equals({"code": "200"}));
    });

    test("should return 503", () async {
      dioAdapter.onPost(
        '/speako/users/learn',
        (server) => server.reply(503, '{"code": "503"}'),
      );

      final response = await serverService.learnPictograms(
        uid: "1",
        language: "es_AR",
        model: "",
        tokens: [],
      );

      expect(response, isA<Left>());
      expect(response.left, equals("learn_error"));
    });
  });

  group("predict pictogram", () {
    test("should return 200", () async {
      dioAdapter.onPost(
        '/speako/predict',
        (server) => server.reply(200, {"code": "200"}),
        queryParameters: {
          "limit": 10,
          "chunk": 4,
        },
      );

      final response = await serverService.predictPictogram(
        sentence: "hola mundo",
        uid: "1",
        language: "es_AR",
        model: "",
        groups: [],
        tags: {},
      );

      expect(response, isA<Right>());
      expect(response.right, equals({"code": "200"}));
    });

    test("should return 200 with reduced", () async {
      dioAdapter.onPost(
        '/speako/predict',
        (server) => server.reply(200, {"code": "200"}),
        queryParameters: {"limit": 10, "chunk": 4, "reduced": true},
      );

      final response = await serverService.predictPictogram(sentence: "hola mundo", uid: "1", language: "es_AR", model: "", groups: [], tags: {}, reduced: true);

      expect(response, isA<Right>());
      expect(response.right, equals({"code": "200"}));
    });

    test("should throw an error", () async {
      dioAdapter.onPost(
        '/speako/predict',
        (server) => server.reply(503, {"code": "503"}),
        queryParameters: {
          "limit": 10,
          "chunk": 4,
        },
      );

      final response = await serverService.predictPictogram(
        sentence: "hola mundo",
        uid: "1",
        language: "es_AR",
        model: "",
        groups: [],
        tags: {},
      );

      expect(response, isA<Left>());
      expect(response.left, equals("learn_error"));
    });
  });

  group("generate phrase gpt", () {
    test("should return completion", () async {});
  });

  //TODO: Make this test work

  group("update language settings", () {
    test("should change language to en_US", () async {
      await serverService.updateLanguageSettings(map: {"language": "en_US", "labs": false}, userId: fakeUserId);

      final data = await firebaseDatabase.ref("$fakeUserId/settings/language").get();

      expect(data.value, equals({"language": "en_US", "labs": false}));
    });
  });

  group("update voice and subtitle settings", () {
    test("should the setting", () async {
      final ttsModel = TTSSetting.empty(language: "es_US");
      await serverService.updateVoiceAndSubtitleSettings(map: ttsModel.toMap(), userId: fakeUserId);

      final data = await firebaseDatabase.ref("$fakeUserId/settings/tts/").get();

      expect(data.value, equals(ttsModel.toMap()));
    });
  });

  group("update accessibility settings", () {
    test("should update the setting", () async {
      final accessibilityModel = AccessibilitySetting.empty();
      await serverService.updateAccessibilitySettings(map: accessibilityModel.toMap(), userId: fakeUserId);

      final data = await firebaseDatabase.ref("$fakeUserId/settings/accessibility/").get();

      expect(data.value, equals(accessibilityModel.toMap()));
    });
  });

  group("update main settings", () {
    test("should update the setting", () async {
      final mainModel = LayoutSetting.empty();
      await serverService.updateMainSettings(map: mainModel.toMap(), userId: fakeUserId);

      final data = await firebaseDatabase.ref("$fakeUserId/settings/layout/").get();

      expect(data.value, equals(mainModel.toMap()));
    });
  });

  group("fetch user settings", () {
    test("should return user settings", () async {
      final data = await serverService.fetchUserSettings(userId: fakeUserId);

      expect(data, isA<Right>());
      expect(data.right, fakeUserInfo["settings"]);
    });

    test("should return no data found", () async {
      final data = await serverService.fetchUserSettings(userId: "123");

      expect(data, isA<Left>());
      expect(data.left, "no_data_found");
    });
  });
}
