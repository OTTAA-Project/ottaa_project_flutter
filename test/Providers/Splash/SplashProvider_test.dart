import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

import 'SplashProvider_test.mocks.dart';

@GenerateMocks([SplashProvider,AboutRepository,AuthRepository,UserAvatarNotifier])
void main(){
  late SplashProvider splashProvider;
  late MockAboutRepository mockAboutRepository;
  late MockAuthRepository mockAuthRepository;
  late MockUserAvatarNotifier mockUserAvatarNotifier;
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

      mockAboutRepository = MockAboutRepository();
      mockAuthRepository = MockAuthRepository();
      mockUserAvatarNotifier = MockUserAvatarNotifier();
      splashProvider = SplashProvider(mockAboutRepository, mockAuthRepository, mockUserAvatarNotifier);
  });
  group('Splash Provider Testing', () {
      test('Check User Avatar true', () async {
        when(mockAboutRepository.isCurrentUserAvatarExist()).thenAnswer((realInvocation) async => true);
         expect(await splashProvider.checkUserAvatar(),true);
      });
      test('Check User Avatar false', () async {
        when(mockAboutRepository.isCurrentUserAvatarExist()).thenAnswer((realInvocation) async => false);
         expect(await splashProvider.checkUserAvatar(),false);
      });
      test('Fetch user information', () async {
        when(mockAboutRepository.getUserInformation()).thenAnswer((realInvocation) async => Right(fakeUser));
        when(mockUserAvatarNotifier.changeAvatar(615)).thenAnswer((realInvocation) async => true);
        expect(await splashProvider.fetchUserInformation(), true);
      });
      test('Is First Time', () async {
        when(mockAboutRepository.isFirstTime()).thenAnswer((realInvocation) async => true);
        expect( await splashProvider.isFirstTime(), true);
      });

      test('UnFetch user information id', () async {
        when(mockAboutRepository.getUserInformation()).thenAnswer((realInvocation) async => Left(fakeUser.id));
        when(mockUserAvatarNotifier.changeAvatar(615)).thenAnswer((realInvocation) async => false);
        expect(await splashProvider.fetchUserInformation(), false);
      });

  });


}
