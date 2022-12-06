import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

import 'sentences_service_test.mocks.dart';

@GenerateMocks([SentencesService, AuthRepository, ServerRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockServerRepository mockServerRepository;
  late SentencesService sentencesService;
  late UserModel fakeUser;
  late SentenceModel fakeSentenceModel,fakeSentenceModel1;

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
    fakeSentenceModel = SentenceModel(
      frase: "Fake",
      frecuencia: 1,
      fecha: [0],
      locale: "es",
      id: 0,
      complejidad: Complex(
        valor: 0,
        pictosComponentes: [
          PictosComponente(id: 0, esSugerencia: false, edad: ["0"], sexo: ["0"])
        ],
      ),
    );
    fakeSentenceModel1 = SentenceModel(
      frase: "Sentence",
      frecuencia: 1,
      fecha: [0],
      locale: "es",
      id: 0,
      complejidad: Complex(
        valor: 0,
        pictosComponentes: [
          PictosComponente(id: 0, esSugerencia: false, edad: ["0"], sexo: ["0"])
        ],
      ),
    );

    mockAuthRepository = MockAuthRepository();
    mockServerRepository = MockServerRepository();
    sentencesService =
        SentencesService(mockAuthRepository, mockServerRepository);
  });
  /*
  group('Sentences Service Testing', () {
    test('description', () async {
      when(MockAuthRepository().getCurrentUser())
          .thenAnswer((realInvocation) async => Right(fakeUser));
      when(MockServerRepository().getUserSentences('0',
              language: 'es-ar', type: Constants.kMostUsedSentences))
          .thenAnswer((realInvocation) async=> Right([fakeSentenceModel1,fakeSentenceModel2]););
      sentencesService.fetchSentences(
          language: 'es', type: Constants.kMostUsedSentences);
    });
  });*/

}
