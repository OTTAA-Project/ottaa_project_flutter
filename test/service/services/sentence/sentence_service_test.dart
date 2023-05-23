
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'sentence_service_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
  AuthRepository,
])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  late MockAuthRepository mockAuthRepository;
  late BaseUserModel fakeUser;

  late SentencesRepository sentencesRepository;
  late List<Phrase> fakePhrases;

  setUp(() {
    mockServerRepository = MockServerRepository();
    mockAuthRepository = MockAuthRepository();
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
    sentencesRepository = SentencesService(mockAuthRepository, mockServerRepository);

    fakePhrases = [
      Phrase(date: DateTime.now(), id: '00', sequence: [const Sequence(id: '22')], tags: {}),
      Phrase(date: DateTime.now(), id: '22', sequence: [const Sequence(id: '22')], tags: {})
    ];
  });

  test('should return the list of phrases from the user', () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

    when(mockServerRepository.getUserSentences(any, language: anyNamed('language'), type: anyNamed('type'))).thenAnswer((realInvocation) async => (fakePhrases));

    final response = await sentencesRepository.fetchSentences(language: 'es_AR', type: 'Test');

    expect(response.right, isA<List<Phrase>>());
  });

  test('should return empty list of phrases if no user found', () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => const Left('no user'));

    when(mockServerRepository.getUserSentences(any, language: anyNamed('language'), type: anyNamed('type'))).thenAnswer((realInvocation) async => ([]));

    final response = await sentencesRepository.fetchSentences(language: 'es_AR', type: 'Test');

    expect(response.left, isA<String>());
  });

  //todo: emir
  group("Check user phrases uploading", () {
    test('should upload sentences to the user database', () async {
      List<Map<String, dynamic>> phrasesDB = [];

      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

      when(mockServerRepository.uploadUserSentences(any, any, any, any)).thenAnswer((realInvocation) async {
        phrasesDB.addAll(realInvocation.positionalArguments.last);
        return const Right(null);
      });

      await sentencesRepository.uploadSentences(language: 'es_AR', data: fakePhrases, type: 'type');

      expect(phrasesDB, fakePhrases.map((e) => e.toMap()));
    });

    test('should return right when user upload senteces', () async {
      List<Map<String, dynamic>> phrasesDB = [];

      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

      when(mockServerRepository.uploadUserSentences(any, any, any, any)).thenAnswer((realInvocation) async {
        phrasesDB.addAll(realInvocation.positionalArguments.last);
        return const Right(null);
      });

      final response = await sentencesRepository.uploadSentences(language: 'es_AR', data: fakePhrases, type: 'type');

      expect(response.isRight, true);
    });
  });

  test('should return a string of error when upload is not successful', () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

    when(mockServerRepository.uploadUserSentences(any, any, any, any)).thenAnswer((realInvocation) async => const Left('failed'));

    final response = await sentencesRepository.uploadSentences(language: 'es_AR', data: fakePhrases, type: 'type');
    if (response.isLeft) {
      expect(response.left, 'failed');
    }
  });
}
