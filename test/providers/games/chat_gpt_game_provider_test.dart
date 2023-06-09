import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import '../../service/services/chatGPT/chatgpt_service_test.mocks.dart';
import 'chat_gpt_game_provider_test.mocks.dart';

@GenerateMocks([GamesProvider, ChatGPTRepository, TTSProvider])
Future<void> main() async {
  late MockGamesProvider mockGamesProvider;
  late MockChatGPTRepository mockChatGPTRepository;
  late MockTTSProvider mockTTSProvider;

  late ChatGptGameProvider chatGptGameProvider;

  late List<Picto> fakePictos;

  MockI18N mockI18N = MockI18N();

  GetIt.I.registerSingleton<I18N>(mockI18N);

  setUp(() {
    mockChatGPTRepository = MockChatGPTRepository();
    mockGamesProvider = MockGamesProvider();
    mockTTSProvider = MockTTSProvider();

    fakePictos = fakePictos = [
      Picto(id: '0', type: 0, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'one'),
      Picto(id: '1', type: 1, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: false, text: 'two'),
      Picto(id: '2', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'three'),
      Picto(id: '3', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'four'),
    ];

    when(mockI18N.currentLanguage).thenReturn(TranslationTree(const Locale("es_AR")));
    chatGptGameProvider = ChatGptGameProvider(mockChatGPTRepository, mockGamesProvider, mockTTSProvider);
  });

  group('create the story for the chat gpt game', () {
    test('should create the story if the resource is given by the chatGptServices', () async {
      chatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Right('fake'));
      await chatGptGameProvider.createStory();
      expect(chatGptGameProvider.generatedStory, 'fake');
    });

    test('should not create the story if the resource is not given by the chatGptServices', () async {
      chatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Left('fake'));
      await chatGptGameProvider.createStory();
      expect(chatGptGameProvider.generatedStory, '');
    });
  });

  test('should reset the game variables being used', () async {
    expect(chatGptGameProvider.gptPictos.length, 0);
    expect(chatGptGameProvider.sentencePhase, 0);
  });

  test('should speak the generated story for the game', () async {
    expect(() async => await chatGptGameProvider.speakStory(), isA<void>());
  });
}
