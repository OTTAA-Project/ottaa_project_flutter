import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

import 'SplashProvider_test.mocks.dart';

@GenerateMocks([
  SplashProvider,
  AboutRepository,
  AuthRepository,
  UserAvatarNotifier,
  UserNotifier,
  LocalDatabaseRepository,
])
void main() {
  late SplashProvider splashProvider;
  late MockAboutRepository mockAboutRepository;
  late MockAuthRepository mockAuthRepository;
  late MockUserAvatarNotifier mockUserAvatarNotifier;
  late UserModel fakeUser;
  late MockUserNotifier mockUserNotifier;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;

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

    mockAboutRepository = MockAboutRepository();
    mockAuthRepository = MockAuthRepository();
    mockUserAvatarNotifier = MockUserAvatarNotifier();
    mockUserNotifier = MockUserNotifier();
    mockLocalDatabaseRepository = MockLocalDatabaseRepository();

    splashProvider = SplashProvider(
      mockAboutRepository,
      mockAuthRepository,
      mockUserAvatarNotifier,
      mockUserNotifier,
      mockLocalDatabaseRepository,
    );
  });
  group('Splash Provider Testing', () {
    test('Check User Avatar true', () async {
      when(mockAboutRepository.isCurrentUserAvatarExist())
          .thenAnswer((realInvocation) async => true);
      expect(await splashProvider.checkUserAvatar(), true);
    });
    test('Check User Avatar false', () async {
      when(mockAboutRepository.isCurrentUserAvatarExist())
          .thenAnswer((realInvocation) async => false);
      expect(await splashProvider.checkUserAvatar(), false);
    });
    test('Fetch user information', () async {
      when(mockAboutRepository.getUserInformation())
          .thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockUserAvatarNotifier.changeAvatar(615))
          .thenAnswer((realInvocation) async => true);
      expect(await splashProvider.fetchUserInformation(), true);
    });
    test('Is First Time', () async {
      when(mockAboutRepository.isFirstTime())
          .thenAnswer((realInvocation) async => true);
      when(mockLocalDatabaseRepository.getIntro())
          .thenAnswer((realInvocation) async => true);
      expect(await splashProvider.isFirstTime(), true);
    });

    test('UnFetch user information id', () async {
      when(mockAboutRepository.getUserInformation())
          .thenAnswer((realInvocation) async => Left(fakeUser.id));
      when(mockUserAvatarNotifier.changeAvatar(615))
          .thenAnswer((realInvocation) async => false);
      expect(await splashProvider.fetchUserInformation(), false);
    });
  });
}
