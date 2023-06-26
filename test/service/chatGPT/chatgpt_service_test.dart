import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/service/chatgpt_service.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'chatgpt_service_test.mocks.dart';

@GenerateMocks([ServerRepository, RemoteConfigRepository, I18N])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  late MockRemoteConfigRepository mockRemoteConfigRepository;

  late ChatGPTRepository chatGPTRepository;

  MockI18N mockI18N = MockI18N();

  GetIt.I.registerSingleton<I18N>(mockI18N);
  setUp(() async {
    mockServerRepository = MockServerRepository();
    mockRemoteConfigRepository = MockRemoteConfigRepository();

    chatGPTRepository = ChatGPTService(mockServerRepository, mockRemoteConfigRepository);

    when(mockI18N.currentLanguage).thenReturn(TranslationTree(const Locale("es_AR")));
  });

  group("get completion", () {
    test("should return hello world for lte 13yo", () async {
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return "hello world";
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right("hello world"));

      final result = await chatGPTRepository.getCompletion(age: 0, gender: "F", pictograms: "hello world", language: "es_AR");

      expect(result, const Right("hello world"));
    });

    test("should return hello world for gt 13yo and less than 18yo", () async {
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return "hello world";
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right("hello world"));

      final result = await chatGPTRepository.getCompletion(age: 15, gender: "F", pictograms: "hello world", language: "es_AR");

      expect(result, const Right("hello world"));
    });
    test("should return hello world gte 18", () async {
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return "hello world";
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right("hello world"));

      final result = await chatGPTRepository.getCompletion(age: 24, gender: "F", pictograms: "hello world", language: "es_AR");

      expect(result, const Right("hello world"));
    });

    test("should return hello when remotePrompt equals null", () async {
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return null;
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right("hello world"));

      final result = await chatGPTRepository.getCompletion(age: 24, gender: "F", pictograms: "hello world", language: "es_AR");

      expect(result, const Right("hello world"));
    });

    test("should return left error", () async {
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return null;
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Left("no_completion"));

      final result = await chatGPTRepository.getCompletion(age: 24, gender: "F", pictograms: "hello world", language: "es_AR");

      expect(result, isA<Left>());
      expect(result.left, "no_completion");
    });
  });

  group("get gpt story", () {
    test("should return an story", () async {
      const String story = "Hello, this is a story about tests";
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return story;
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Right(story));

      final result = await chatGPTRepository.getGPTStory(prompt: "", maxTokens: 100);

      expect(result.right, story);
    });

    test("should return left", () async {
      const String story = "Hello, this is a story about tests";
      when(mockRemoteConfigRepository.getString(any)).thenAnswer((_) async {
        return story;
      });

      when(mockServerRepository.generatePhraseGPT(prompt: anyNamed("prompt"), maxTokens: anyNamed("maxTokens"), temperature: anyNamed("temperature"))).thenAnswer((realInvocation) async => const Left("no_completion"));

      final result = await chatGPTRepository.getGPTStory(prompt: "", maxTokens: 100);

      expect(result, isA<Left>());
      expect(result.left, "no_completion");
    });
  });
}
