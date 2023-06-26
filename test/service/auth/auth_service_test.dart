import 'dart:ui';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/service/auth_service.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import '../notifications/firebase_messaging_mock.dart' as fmc;
import 'auth_service_test.mocks.dart';

@GenerateMocks([
  LocalDatabaseRepository,
  ServerRepository,
  I18N,
  FirebaseMessaging,
])
void main() async {
  late MockGoogleSignIn googleSignIn;

  late MockFirebaseAuth firebaseAuth;

  late MockLocalDatabaseRepository localDatabaseRepository;
  late MockServerRepository serverRepository;
  late MockI18N i18n;
  late MockFirebaseMessaging firebaseMessaging;
  late AuthService authService;

  fmc.setupFirebaseMessagingMocks();

  setUp(() async {
    await Firebase.initializeApp();
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();
    localDatabaseRepository = MockLocalDatabaseRepository();
    serverRepository = MockServerRepository();
    i18n = MockI18N();
    firebaseMessaging = MockFirebaseMessaging();
    authService = AuthService(
      localDatabaseRepository,
      serverRepository,
      i18n,
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
      firebaseMessaging: firebaseMessaging,
    );
  });

  group("get current user", () {
    test("should return the current user", () async {
      when(localDatabaseRepository.getUser()).thenAnswer((realInvocation) async {
        return getUserByType(UserType.user);
      });

      final result = await authService.getCurrentUser();

      expect(result.right, isA<PatientUserModel>());
    });

    test("should return the current user", () async {
      when(localDatabaseRepository.getUser()).thenAnswer((realInvocation) async {
        return null;
      });

      final result = await authService.getCurrentUser();

      expect(result.left, isA<String>());
    });
  });

  group("is logged in", () {
    test("should return true", () async {
      when(localDatabaseRepository.user).thenReturn(getUserByType(UserType.user));

      final result = await authService.isLoggedIn();

      expect(result, true);
    });

    test("should return false without user and userModel", () async {
      when(localDatabaseRepository.user).thenReturn(null);

      final result = await authService.isLoggedIn();

      expect(result, false);
    });

    test("should return false without user model", () async {
      final user = MockUser(isAnonymous: false, uid: 'someuid', email: 'bob@somedomain.com', displayName: 'Bob', providerData: [
        UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
      ]);
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      firebaseAuth.mockUser = user;

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });
      when(localDatabaseRepository.user).thenReturn(null);
      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return Right(getUserInfo(UserType.user));
      });
      when(localDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async {
        return;
      });

      final result = await authService.isLoggedIn();

      expect(result, true);
    });
  });

  group("logout", () {
    test("should logout", () async {
      final user = MockUser(isAnonymous: false, uid: 'someuid', email: 'bob@somedomain.com', displayName: 'Bob', providerData: [
        UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
      ]);
      final signinAccount = await googleSignIn.signIn();

      final googleAuth = await signinAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      firebaseAuth.mockUser = user;

      when(localDatabaseRepository.deleteUser()).thenAnswer((realInvocation) async {});

      await authService.logout();
      verify(localDatabaseRepository.deleteUser());
    });
  });

  group("build user model", () {
    test("for patient", () async {
      final user = MockUser(isAnonymous: false, uid: 'someuid', email: 'bob@somedomain.com', displayName: 'Bob', providerData: [
        UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
      ]);

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return Right(getUserInfo(UserType.user));
      });

      when(localDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async {
        return;
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });
      final result = await authService.buildUserModel(user);

      expect(result, isA<PatientUserModel>());
    });
    test("for caregiver", () async {
      final user = MockUser(isAnonymous: false, uid: 'someuid', email: 'bob@somedomain.com', displayName: 'Bob', providerData: [
        UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
      ]);

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return Right(getUserInfo(UserType.caregiver));
      });

      when(localDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async {
        return;
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });
      final result = await authService.buildUserModel(user);

      expect(result, isA<CaregiverUserModel>());
    });

    test("for none", () async {
      final user = MockUser(isAnonymous: false, uid: 'someuid', email: 'bob@somedomain.com', displayName: 'Bob', providerData: [
        UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
      ]);

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return Right(getUserInfo(UserType.none));
      });

      when(localDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async {
        return;
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });
      final result = await authService.buildUserModel(user);

      expect(result, isA<BaseUserModel>());
    });
  });

  group("sign in", () {
    test("should return user", () async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'bob@somedomain.com',
        displayName: 'Bob',
        providerData: [
          UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
        ],
      );

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return Right(getUserInfo(UserType.user));
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });

      firebaseAuth.mockUser = user;

      final result = await authService.signIn(SignInType.google);

      expect(result, isA<Right>());
    });

    test("should signup user", () async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'bob@somedomain.com',
        displayName: 'Bob',
        providerData: [
          UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
        ],
      );
      when(i18n.currentLocale).thenReturn(const Locale("es_AR"));

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return const Left("No user");
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });

      when(serverRepository.uploadUserInformation(any, any)).thenAnswer((realInvocation) async {
        return const Right(null);
      });

      firebaseAuth.mockUser = user;

      final result = await authService.signIn(SignInType.google);

      expect(result, isA<Right>());
      verify(serverRepository.uploadUserInformation(any, any));
    });

    test("should return cancelled", () async {
      googleSignIn.setIsCancelled(true);
      final result = await authService.signIn(SignInType.google);

      expect(result, isA<Left>());
    });

    test("should throw an error", () async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'bob@somedomain.com',
        displayName: 'Bob',
        providerData: [
          UserInfo({'providerId': 'google.com', 'uid': 'someuid', 'displayName': 'Bob', 'email': 'bob@somedomain.com'})
        ],
      );
      when(i18n.currentLocale).thenReturn(const Locale("es_AR"));

      when(serverRepository.getUserInformation(any)).thenAnswer((realInvocation) async {
        return const Left("No user");
      });

      when(firebaseMessaging.getToken(vapidKey: anyNamed("vapidKey"))).thenAnswer((_) async {
        return "";
      });

      when(serverRepository.uploadUserInformation(any, any)).thenThrow(Exception());

      firebaseAuth.mockUser = user;

      final result = await authService.signIn(SignInType.google);

      expect(result, isA<Left>());
      verify(serverRepository.uploadUserInformation(any, any));
    });
  });
}

UserModel getUserByType(UserType type) {
  final fakeUserInfo = getUserInfo(type);

  switch (type) {
    case UserType.user:
      return PatientUserModel.fromMap(fakeUserInfo);
    case UserType.caregiver:
      return CaregiverUserModel.fromMap(fakeUserInfo);
    case UserType.none:
      return BaseUserModel.fromMap(fakeUserInfo);
  }
}

Map<String, dynamic> getUserInfo(UserType type) {
  return {
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
}
