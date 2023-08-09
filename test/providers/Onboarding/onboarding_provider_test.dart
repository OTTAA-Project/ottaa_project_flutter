import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

import 'onboarding_provider_test.mocks.dart';

@GenerateMocks([OnBoardingNotifier, AuthRepository, LoadingNotifier, AboutRepository, LocalDatabaseRepository])
void main() {
  late OnBoardingNotifier onBoardingNotifier;
  late MockAuthRepository mockAuthRepository;
  late MockLoadingNotifier mockLoadingNotifier;
  late MockAboutRepository mockAboutRepository;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;
  late MockOnBoardingNotifier mockOnBoardingNotifier;
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
    mockAuthRepository = MockAuthRepository();
    mockLoadingNotifier = MockLoadingNotifier();
    mockAboutRepository = MockAboutRepository();
    mockLocalDatabaseRepository = MockLocalDatabaseRepository();
    mockLoadingNotifier = MockLoadingNotifier();
    mockOnBoardingNotifier = MockOnBoardingNotifier();
    onBoardingNotifier = OnBoardingNotifier();
  });
  group('Onboarding Notifier', () {
    test('Update User Avatar', () async {
      when(mockAuthRepository.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));
      // await onBoardingNotifier.updateUserAvatar();
    });
    test('Update User Avatar fail user', () async {
      when(mockAuthRepository.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Left("ERROR"));
      // await onBoardingNotifier.updateUserAvatar();
    });
  });
}
