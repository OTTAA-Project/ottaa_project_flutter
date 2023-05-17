import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/providers/about_provider.dart';
import 'package:ottaa_project_flutter/application/service/about_service.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_payment.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

import 'about_test.mocks.dart';

@GenerateMocks([AboutService])
void main() {
  late AboutProvider aboutProvider;
  late MockAboutService mockAboutService;

  late UserModel fakeUser;

  setUp(() {
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
    );

    mockAboutService = MockAboutService();
    aboutProvider = AboutProvider(mockAboutService);
  });

  test("should return the app version", () async {
    when(mockAboutService.getAppVersion()).thenAnswer((_) async => "1.0.0");

    expect(await aboutProvider.getAppVersion(), "1.0.0");
    verify(mockAboutService.getAppVersion()).called(1);
  });

  test("should return the available app version", () async {
    when(mockAboutService.getAvailableAppVersion())
        .thenAnswer((_) async => "1.0.0");

    expect(await aboutProvider.getAvailableAppVersion(), "1.0.0");
    verify(mockAboutService.getAvailableAppVersion()).called(1);
  });

  test("should return the device name", () async {
    when(mockAboutService.getDeviceName()).thenAnswer((_) async => "iPhone 12");

    expect(await aboutProvider.getDeviceName(), "iPhone 12");
    verify(mockAboutService.getDeviceName()).called(1);
  });

  test("should return the user email", () async {
    when(mockAboutService.getEmail()).thenAnswer((_) async => "test@mail.com");

    expect(await aboutProvider.getEmail(), "test@mail.com");

    verify(mockAboutService.getEmail()).called(1);
  });

  test("should return the user profile picture", () async {
    when(mockAboutService.getProfilePicture())
        .thenAnswer((_) async => "https://test.com");

    expect(await aboutProvider.getProfilePicture(), "https://test.com");

    verify(mockAboutService.getProfilePicture()).called(1);
  });

  test("should return the user information", () async {
    when(mockAboutService.getUserInformation())
        .thenAnswer((_) async => Right(fakeUser));
    expect((await mockAboutService.getUserInformation()).isRight, true);

    expect(
        (await mockAboutService.getUserInformation()).right, isA<UserModel>());
  });

  test("should return free user type", () async {
    when(mockAboutService.getUserType())
        .thenAnswer((_) async => UserPayment.free);

    expect(await aboutProvider.getUserType(), UserPayment.free);

    verify(mockAboutService.getUserType()).called(1);
  });

  test("should return premium user type", () async {
    when(mockAboutService.getUserType())
        .thenAnswer((_) async => UserPayment.premium);

    expect(await aboutProvider.getUserType(), UserPayment.premium);

    verify(mockAboutService.getUserType()).called(1);
  });

  test("should return if the user avatar exist", () async {
    when(mockAboutService.getProfilePicture())
        .thenAnswer((_) async => fakeUser.settings.data.avatar.network!);

    expect(await aboutProvider.getProfilePicture(), "https://test.com");

    verify(mockAboutService.getProfilePicture()).called(1);
  });

  // test("should return if the user is first time", () async {
  //   when(mockAboutService.isFirstTime()).thenAnswer((_) async => fakeUser);

  //   expect(await mockAboutService.isFirstTime(), true);

  //   verify(mockAboutService.isFirstTime()).called(1);
  // });

  test("should upload the user information", () async {
    UserModel fakeUser2 = BaseUserModel(
      id: "2",
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
    );
    when(mockAboutService.uploadUserInformation()).thenAnswer((_) async {
      fakeUser = fakeUser2;
    });
    await aboutProvider.uploadUserInformation();

    verify(mockAboutService.uploadUserInformation()).called(1);

    expect(fakeUser.toJson(), fakeUser2.toJson());
  });

  test("should upload the user profile picture", () async {
    // when(mockAboutService.uploadProfilePicture("https://test3.com")).thenAnswer((_) async => fakeUser = fakeUser.copyWith(photoUrl: "https://test3.com"));
    // await aboutProvider.uploadProfilePicture("https://test3.com");
    // expect(fakeUser.photoUrl, "https://test3.com");
  });

  test("should send a support email", () async {
    when(mockAboutService.sendSupportEmail()).thenAnswer((_) async => true);
    await aboutProvider.sendSupportEmail();
    verify(mockAboutService.sendSupportEmail()).called(1);
  });
}
