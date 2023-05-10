import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/chatgpt_service.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'chatgpt_service_test.mocks.dart';

@GenerateMocks([ServerRepository, RemoteConfigRepository])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  late MockRemoteConfigRepository mockRemoteConfigRepository;

  late ChatGPTRepository chatGPTRepository;

  setUp(() {
    mockServerRepository = MockServerRepository();
    mockRemoteConfigRepository = MockRemoteConfigRepository();

    chatGPTRepository = ChatGPTService(mockServerRepository, mockRemoteConfigRepository);
  });

  test("Should return hello world", () async {
    when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
      return "hello world";
    });

    when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right("hello world"));

    final result = await chatGPTRepository.getCompletion(age: 0, gender: "F", pictograms: "hello world", language: "es_AR");

    expect(result, const Right("hello world"));
  });
}
