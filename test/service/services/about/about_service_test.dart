import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/core/enums/user_payment.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'about_service_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
  LocalDatabaseRepository,
  AuthRepository,
])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;
  late MockAuthRepository mockAuthRepository;

  late AboutRepository aboutRepository;

  late BaseUserModel fakeUser;

  setUp(() {
    mockServerRepository = MockServerRepository();
    mockLocalDatabaseRepository = MockLocalDatabaseRepository();
    mockAuthRepository = MockAuthRepository();
    PackageInfo.setMockInitialValues(
      appName: "ottaa",
      packageName: "com.ottaa",
      version: "1.0.0",
      buildNumber: "1",
      buildSignature: "sig",
      installerStore: "store",
    );

    fakeUser = BaseUserModel(
      id: "0",
      settings: BaseSettingsModel(
        data: UserData(
          avatar: AssetsImage(asset: "test", network: "https://test.com"),
          birthDate: DateTime(0),
          genderPref: "n/a",
          lastConnection: DateTime(0),
          name: "John",
          lastName: "Doe",
        ),
        language: LanguageSetting.empty(),
      ),
      email: "test@mail.com",
      type: UserType.caregiver,
    );

    aboutRepository = AboutService(
      mockAuthRepository,
      mockServerRepository,
      mockLocalDatabaseRepository,
    );
  });

  test("should return the app version", () async {
    String version = await aboutRepository.getAppVersion();

    expect(version, "1.0.0");
  });

  test("should return the available app version", () async {
    when(mockServerRepository.getAvailableAppVersion(any)).thenAnswer((_) async => const Right("1.0.0"));

    String version = await aboutRepository.getAvailableAppVersion();

    expect(version, "1.0.0");
  });

  test("should return the device name (Unknown)", () async {
    String deviceName = await aboutRepository.getDeviceName();

    expect(deviceName, "Unknown");
  });

  group("should return the user email", () {
    test("with right response", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));

      String email = await aboutRepository.getEmail();

      expect(email, fakeUser.email);
    });

    test("with left response", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Left("No Email"));

      String email = await aboutRepository.getEmail();

      expect(email, "No Email");
    });
  });

  test("should return the user payment type", () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));

    UserPayment userType = await aboutRepository.getUserType();

    expect(userType, UserPayment.free);
  });

  //TODO: Send email test u.u

  test("should return the current profile picture", () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));
    when(mockServerRepository.getUserProfilePicture(fakeUser.id)).thenAnswer((realInvocation) async => const Right("671"));

    String profilePicture = await aboutRepository.getProfilePicture();

    expect(profilePicture, "671");
  });

  test("should upload profile picture", () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));

    when(mockServerRepository.uploadUserPicture(fakeUser.id, AssetsImage(asset: "9", network: ""))).thenAnswer((realInvocation) async {
      fakeUser.settings.data = fakeUser.settings.data.copyWith(
        avatar: realInvocation.positionalArguments[1] as AssetsImage,
      );
      return const Right("9");
    });

    await aboutRepository.uploadProfilePicture(AssetsImage(asset: "9", network: ""));

    expect(fakeUser.settings.data.avatar, AssetsImage(asset: "9", network: ""));
  });

  group("hould return the current user information", () {
    test("as a caregiver", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));

      when(mockServerRepository.getUserInformation(any)).thenAnswer((_) async => Right(fakeUser.toMap()));

      when(mockLocalDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async => {});

      final user = await aboutRepository.getUserInformation();

      expect(user.right, isA<CaregiverUserModel>());
    });

    test("as a user", () async {
      final userInfo = fakeUser.copyWith(type: UserType.user);
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(userInfo));

      when(mockServerRepository.getUserInformation(any)).thenAnswer((_) async => Right(userInfo.toMap()));

      when(mockLocalDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async => {});

      final user = await aboutRepository.getUserInformation();

      expect(user.right, isA<PatientUserModel>());
    });

    test("as a none", () async {
      final userInfo = fakeUser.copyWith(type: UserType.none);
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(userInfo));

      when(mockServerRepository.getUserInformation(any)).thenAnswer((_) async => Right(userInfo.toMap()));

      when(mockLocalDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async => {});

      final user = await aboutRepository.getUserInformation();

      expect(user.right, isA<BaseUserModel>());
    });
  });

  test("should upload user information", () async {
    CaregiverUserModel? userInformation;

    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));

    when(mockServerRepository.uploadUserInformation(any, any)).thenAnswer((realInvocation) async {
      userInformation = CaregiverUserModel.fromMap(realInvocation.positionalArguments[1] as dynamic);
      return const Right("9");
    });

    await aboutRepository.uploadUserInformation();

    expect(userInformation, isA<CaregiverUserModel>());
  });

  test("should return if current user has avatar", () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));
    bool exists = await aboutRepository.isCurrentUserAvatarExist();
    expect(exists, true);
  });

  test("should return if user is first time", () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUser));
    bool exists = await aboutRepository.isFirstTime();
    expect(exists, true);
  });

  test("should update the user type", () async {
    UserType oldUserType = UserType.caregiver;
    when(mockServerRepository.updateUserType(id: "", userType: UserType.user)).thenAnswer((realInvocation) async {
      oldUserType = realInvocation.namedArguments[#userType];
    });

    await aboutRepository.updateUserType(id: "", userType: UserType.user);

    expect(oldUserType, UserType.user);
  });

  test("sould update the last user connection time", () async {
    DateTime? lastConnection;
    when(mockServerRepository.updateUserLastConnectionTime(userId: "", time: 0)).thenAnswer((realInvocation) async {
      lastConnection = DateTime(realInvocation.namedArguments[#time]);

      return const Right("");
    });

    await aboutRepository.updateUserLastConnectionTime(userId: "", time: 0);

    expect(lastConnection, DateTime(0));
  });
}
