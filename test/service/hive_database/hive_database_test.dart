import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/hive_database.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';

import 'hive_database_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() async {
  late MockHiveInterface hive;
  late MockBox box;

  late HiveDatabase hiveDatabase;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    hive = MockHiveInterface();
    box = MockBox();

    MethodChannel methodChannel = const MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMethodCallHandler(
      methodChannel,
      (message) async {
        return ".";
      },
    );

    hiveDatabase = HiveDatabase(hive: hive);
  });

  test("should call close hiveDB", () async {
    await hiveDatabase.close();

    verify(hive.close());
  });

  test("should call clear box", () async {
    when(box.clear()).thenAnswer((_) async => 0);
    when(hive.box('user')).thenReturn(box);
    when(hive.box('caregiver')).thenReturn(box);
    when(hive.box('none')).thenReturn(box);

    await hiveDatabase.deleteUser();

    verifyInOrder([
      hive.box('user'),
      box.clear(),
      hive.box('caregiver'),
      box.clear(),
      hive.box('none'),
      box.clear(),
    ]);
  });

  group("get user", () {
    test("should return user", () async {
      when(box.get(UserType.user.name)).thenReturn(getUserByType(UserType.user));
      when(hive.box(UserType.user.name)).thenReturn(box);

      final user = await hiveDatabase.getUser();

      expect(user!.type, UserType.user);
    });

    test("should return caregiver", () async {
      when(box.get(UserType.user.name)).thenReturn(null);
      when(box.get(UserType.caregiver.name)).thenReturn(getUserByType(UserType.caregiver));
      when(hive.box(UserType.caregiver.name)).thenReturn(box);
      when(hive.box(UserType.user.name)).thenReturn(box);
      when(hive.box(UserType.none.name)).thenReturn(box);

      final user = await hiveDatabase.getUser();

      expect(user!.type, UserType.caregiver);
    });

    test("should return none", () async {
      when(box.get(UserType.user.name)).thenReturn(null);
      when(box.get(UserType.caregiver.name)).thenReturn(null);
      when(box.get(UserType.none.name)).thenReturn(getUserByType(UserType.none));
      when(hive.box(UserType.caregiver.name)).thenReturn(box);
      when(hive.box(UserType.user.name)).thenReturn(box);
      when(hive.box(UserType.none.name)).thenReturn(box);

      final user = await hiveDatabase.getUser();

      expect(user!.type, UserType.none);
    });
  });

  test("should init hive", () async {
    when(box.get(any)).thenReturn(box);
    when(hive.box(any)).thenReturn(box);
    when(hive.openBox(any)).thenAnswer((realInvocation) async => box);

    when(box.get(UserType.user.name)).thenReturn(getUserByType(UserType.user));
    when(box.get(UserType.caregiver.name)).thenReturn(getUserByType(UserType.caregiver));
    when(box.get(UserType.none.name)).thenReturn(getUserByType(UserType.none));

    await hiveDatabase.init();

    verify(hive.init(any));
    verify(hive.registerAdapter(any)).called(29);
    verify(hive.openBox(any)).called(6);
  });

  group("set user", () {
    test("should set user", () async {
      when(hive.box(any)).thenReturn(box);

      when(hive.isBoxOpen(any)).thenAnswer((realInvocation) {
        return true;
      });

      when(hive.openBox(any)).thenAnswer((realInvocation) async {
        return box;
      });

      when(box.put(any, any)).thenAnswer((realInvocation) async => 0);

      when(box.get(any)).thenAnswer(
        (realInvocation) => getUserByType(UserType.values.firstWhere((element) => element.name == realInvocation.positionalArguments[0])),
      );

      final user = getUserByType(UserType.user);

      await hiveDatabase.setUser(user);

      verify(box.put(any, any));
    });
  });

  group("secure box", () {
    test("should return secure box", () async {
      when(hive.box(any)).thenReturn(box);

      when(hive.isBoxOpen(any)).thenAnswer((realInvocation) {
        return true;
      });

      Box secureBox = await hiveDatabase.secureBox("user");

      expect(secureBox, box);
      verify(hive.box(any));
      verify(hive.isBoxOpen(any));
    });

    test("should open secure box and then return it", () async {
      when(hive.openBox(any)).thenAnswer((_) async => box);

      when(hive.isBoxOpen(any)).thenAnswer((realInvocation) {
        return false;
      });

      Box secureBox = await hiveDatabase.secureBox("user");

      expect(secureBox, box);
      verify(hive.openBox(any));
      verify(hive.isBoxOpen(any));
    });
  });

  test("set intro should update box", () async {
    bool intro = false;

    when(hive.box(any)).thenReturn(box);

    when(box.put(any, any)).thenAnswer((realInvocation) async {
      intro = realInvocation.positionalArguments[1];
    });

    await hiveDatabase.setIntro(true);

    verify(box.put(any, any));
    expect(intro, true);
  });

  test("get intro should return intro", () async {
    when(hive.box(any)).thenReturn(box);

    when(box.get(any)).thenReturn(true);

    bool intro = await hiveDatabase.getIntro();

    verify(box.get(any));
    expect(intro, true);
  });

  test("get voice should return name", () async {
    when(hive.box(any)).thenReturn(box);

    when(box.get(any)).thenReturn("name");

    String name = await hiveDatabase.getVoice();

    verify(box.get(any));
    expect(name, "name");
  });

  test("set voice should update box", () async {
    String name = "";

    when(hive.box(any)).thenReturn(box);

    when(box.put(any, any)).thenAnswer((realInvocation) async {
      name = realInvocation.positionalArguments[1];
    });

    await hiveDatabase.setVoice(name: "name");

    verify(box.put(any, any));
    expect(name, "name");
  });

  test("get long click should return true", () async {
    when(hive.box(any)).thenReturn(box);

    when(box.get(any)).thenReturn(true);

    bool getLongClick = await hiveDatabase.getLongClick();

    verify(box.get(any));
    expect(getLongClick, true);
  });

  test("set long click should update box", () async {
    bool longClick = false;

    when(hive.box(any)).thenReturn(box);

    when(box.put(any, any)).thenAnswer((realInvocation) async {
      longClick = realInvocation.positionalArguments[1];
    });

    await hiveDatabase.setLongClick(isLongClick: true);

    verify(box.put(any, any));
    expect(longClick, true);
  });

  /* test("should return the listeneable for a box", () async {
    when(hive.box(any)).thenReturn(box);

    final valuenotifier = hiveDatabase.getListeneableFromName("box");

    verify(hive.box(any));
    expect(valuenotifier, isA<ValueListenable<dynamic>>());
  });*/
}

UserModel getUserByType(UserType type) {
  final Map<String, dynamic> fakeUserInfo = {
    "id": "mu4ZiTMURBeLEV7p3CrFbljBrHF2",
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
      "payment": {
        "payment": false,
        "paymentDate": 0,
        "paymentExpire": 0,
      }
    },
    "type": type.name
  };

  switch (type) {
    case UserType.user:
      return PatientUserModel.fromMap(fakeUserInfo);
    case UserType.caregiver:
      return CaregiverUserModel.fromMap(fakeUserInfo);
    case UserType.none:
      return BaseUserModel.fromMap(fakeUserInfo);
  }
}
