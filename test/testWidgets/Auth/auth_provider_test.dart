import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/service/about_service.dart';
import 'package:ottaa_project_flutter/application/service/auth_service.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';


import 'auth_provider_test.mocks.dart';

@GenerateMocks([AuthProvider,LoadingNotifier,AuthService,AboutService,LocalDatabaseRepository,AuthNotifier])
void main(){
  late AuthProvider authProvider;
  late MockAuthProvider mockAuthProvider;
  late MockLoadingNotifier mockLoadingNotifier;
  late MockAuthService mockAuthService;
  late MockAboutService mockAboutService;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;
  late MockAuthNotifier mockAuthNotifier;
  late UserModel fakeUser;

  setUp(() {
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
    mockAuthProvider = MockAuthProvider();
    mockLoadingNotifier = MockLoadingNotifier();
    mockAuthService = MockAuthService();
    mockAboutService = MockAboutService();
    mockLocalDatabaseRepository =MockLocalDatabaseRepository();
    mockAuthNotifier = MockAuthNotifier();
    authProvider = AuthProvider(mockLoadingNotifier, mockAuthService, mockAboutService, mockLocalDatabaseRepository, mockAuthNotifier);
  });
  group('auth Provider testing', () {
    test('sign in', () async {
      when(mockAuthService.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockLocalDatabaseRepository.setUser(fakeUser)).thenAnswer((realInvocation) async => {});
      when(mockAboutService.getUserInformation()).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockAuthNotifier.setSignedIn()).thenAnswer((realInvocation) {
        mockAuthNotifier.state = true;
      });
      when(mockLoadingNotifier.showLoading()).thenAnswer((realInvocation) {
        mockLoadingNotifier.state = true;
      });

      when(mockLoadingNotifier.hideLoading()).thenAnswer((realInvocation) {
        mockLoadingNotifier.state = false;
      });

      final result = await authProvider.signIn(SignInType.email);

      expect(result.right, isA<UserModel>());

      verify(mockAuthService.signIn(SignInType.email)).called(1);
      verify(mockLocalDatabaseRepository.setUser(fakeUser)).called(1);
      verify(mockAboutService.getUserInformation()).called(1);
      verify(mockAuthNotifier.setSignedIn()).called(1);
      verify(mockLoadingNotifier.showLoading()).called(1);
      verify(mockLoadingNotifier.hideLoading()).called(1);
    });

    test('log out',() async {
      var result = true;
      when(mockAuthService.signIn(SignInType.email)).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockLocalDatabaseRepository.setUser(fakeUser)).thenAnswer((realInvocation) async => {});
      when(mockAboutService.getUserInformation()).thenAnswer((realInvocation) async => Right(fakeUser));
      when(mockAuthNotifier.setSignedIn()).thenAnswer((realInvocation) {
        mockAuthNotifier.state = true;
      });
      when(mockLoadingNotifier.showLoading()).thenAnswer((realInvocation) {
        mockLoadingNotifier.state = true;
      });

      when(mockLoadingNotifier.hideLoading()).thenAnswer((realInvocation) {
        mockLoadingNotifier.state = false;
      });
      when(mockAuthProvider.logout()).thenAnswer((realInvocation) async{
        result = false;
      });

      await mockAuthProvider.logout();
      verify(mockAuthProvider.logout()).called(1);
    });

  });


}