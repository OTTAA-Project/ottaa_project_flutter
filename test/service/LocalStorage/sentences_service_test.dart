import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

import 'sentences_service_test.mocks.dart';

@GenerateMocks([SentencesService, AuthRepository, ServerRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockServerRepository mockServerRepository;
  late SentencesService sentencesService;
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
    mockServerRepository = MockServerRepository();
    sentencesService = SentencesService(mockAuthRepository, mockServerRepository);
  });
  /*
  group('Sentences Service Testing', () {
    test('description', () async {
      when(MockAuthRepository().getCurrentUser())
          .thenAnswer((realInvocation) async => Right(fakeUser));
      when(MockServerRepository().getUserSentences('0',
              language: 'es_AR', type: Constants.kMostUsedSentences))
          .thenAnswer((realInvocation) async=> Right([fakeSentenceModel1,fakeSentenceModel2]););
      sentencesService.fetchSentences(
          language: 'es', type: Constants.kMostUsedSentences);
    });
  });*/
}
