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
      Phrase(date: DateTime.now(), id: '00', sequence: [Sequence(id: '22')], tags: {}),
      Phrase(date: DateTime.now(), id: '22', sequence: [Sequence(id: '22')], tags: {})
    ];
  });

  test('should return the list of phrases from the user', () async {
    when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

    when(mockServerRepository.getUserSentences(any, language: anyNamed('language'), type: anyNamed('type'))).thenAnswer((realInvocation) async => (fakePhrases));

    final response = await sentencesRepository.fetchSentences(language: 'es_AR', type: 'Test');

    expect(response, isA<List<Phrase>>());
  });
}
