import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';

import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

@GenerateMocks([SentencesService, AuthRepository, ServerRepository])
void main() {
  setUp(() {});
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
