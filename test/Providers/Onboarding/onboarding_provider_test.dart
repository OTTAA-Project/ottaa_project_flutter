import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

import 'onboarding_provider_test.mocks.dart';


@GenerateMocks([OnBoardingNotifier,AuthRepository,LoadingNotifier, AboutRepository, UserAvatarNotifier, LocalDatabaseRepository])
void main(){
  late OnBoardingNotifier onBoardingNotifier;
  late MockAuthRepository mockAuthRepository;
  late MockLoadingNotifier mockLoadingNotifier;
  late MockAboutRepository mockAboutRepository;
  late MockUserAvatarNotifier mockUserAvatarNotifier;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;
  late MockOnBoardingNotifier mockOnBoardingNotifier;
  late UserModel fakeUser;

  setUp((){
      fakeUser = const UserModel(
        id: "0",
        name: "fake user",
        email: "fake@mail.com",
        photoUrl: "https://test.com",
        avatar: "0",
        birthdate: 0,
        gender: "male",
        isFirstTime: true,
        language: "es-ar",
      );
      mockAuthRepository = MockAuthRepository();
      mockLoadingNotifier = MockLoadingNotifier();
      mockAboutRepository = MockAboutRepository();
      mockUserAvatarNotifier = MockUserAvatarNotifier();
      mockLocalDatabaseRepository = MockLocalDatabaseRepository();
      mockLoadingNotifier = MockLoadingNotifier();
      mockOnBoardingNotifier = MockOnBoardingNotifier();
      onBoardingNotifier = OnBoardingNotifier(mockAuthRepository, mockAboutRepository, mockLocalDatabaseRepository, mockLoadingNotifier, mockUserAvatarNotifier);
  });
  group ('Onboarding Notifier',(){
      test('Sign out', () async {
        await onBoardingNotifier.signOut();
      });
      test('Update User Avatar', () async {
        when(mockAuthRepository.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
        when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));
        when(mockUserAvatarNotifier.getAvatar()).thenAnswer((realInvocation) => '730.png');
        await onBoardingNotifier.updateUserAvatar();

      });
      test('Update User Avatar fail user', () async {
        when(mockAuthRepository.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
        when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Left(fakeUser.name));
        when(mockUserAvatarNotifier.getAvatar()).thenAnswer((realInvocation) => '730.png');
        await onBoardingNotifier.updateUserAvatar();
      });
      test('Change User Avatar ', () async {
       // when(mockAuthRepository.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
        //when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Left(fakeUser.name));
        when(mockUserAvatarNotifier.changeAvatar(2)).thenAnswer((realInvocation) => {});
        when(mockUserAvatarNotifier.getAvatar()).thenAnswer((realInvocation) => '730.png');
         onBoardingNotifier.changeAvatar(2);
         expect(mockUserAvatarNotifier.getAvatar(), '730.png');
      });


  });

}