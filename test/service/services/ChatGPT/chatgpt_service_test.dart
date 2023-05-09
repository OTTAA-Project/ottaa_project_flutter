import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/chatgpt_service.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_config_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

import 'chatgpt_service_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
  RemoteConfigRepository,
])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  late MockRemoteConfigRepository mockRemoteConfigRepository;

  late ChatGPTRepository chatGPTRepository;

  setUp(() {
    mockServerRepository = MockServerRepository();
    mockRemoteConfigRepository = MockRemoteConfigRepository();

    chatGPTRepository = ChatGPTService(
      mockServerRepository,
      mockRemoteConfigRepository,
    );
  });

  test("should return completion Hello World", () async {
    when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async => "Prompt");

    String? rPrompt = await mockRemoteConfigRepository.getString('Prompt');

    when(mockServerRepository.generatePhraseGPT(prompt: rPrompt, maxTokens: anyNamed('maxTokens'))).thenAnswer((_) async => const Right('Hello World'));

    final prompt = await mockServerRepository.generatePhraseGPT(prompt: rPrompt, maxTokens: 1000);

    expect(prompt.right, 'Hello World');
  });
}
