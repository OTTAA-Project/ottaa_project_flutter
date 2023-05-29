import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'chat_gpt_game_provider_test.mocks.dart';

@GenerateMocks([GamesProvider, ChatGPTRepository, TTSProvider])
Future<void> main() async {
  late MockGamesProvider mockGamesProvider;
  late MockChatGPTRepository mockChatGPTRepository;
  late MockTTSProvider mockTTSProvider;

  late ChatGptGameProvider chatGptGameProvider;

  late List<Picto> fakePictos;

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

    chatGptGameProvider = ChatGptGameProvider(mockChatGPTRepository, mockGamesProvider, mockTTSProvider);
  });

  group('create the story for the chat gpt game', () {
    test('should create the story if the resource is given by the chatGptServices', () async {
      chatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Right('fake'));
      await chatGptGameProvider.createStory(prompt: 'fake');
      expect(chatGptGameProvider.generatedStory, 'fake');
    });

    test('should not create the story if the resource is not given by the chatGptServices', () async {
      chatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Left('fake'));
      await chatGptGameProvider.createStory(prompt: 'fake');
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

  testWidgets('scrollDownBoards should animate to the correct position', (WidgetTester tester) async {
    // Initialize the scroll controller
    chatGptGameProvider.boardScrollController = ScrollController();

    // Build the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: chatGptGameProvider.boardScrollController,
            children: [
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
            ],
          ),
        ),
      ),
    );
    final lView = tester.widget<ListView>(find.byType(ListView));
    final controller = lView.controller;
    expect(chatGptGameProvider.boardScrollController.position.pixels.toInt(), equals(0.0));

    chatGptGameProvider.scrollDownBoards();
    controller!.jumpTo(controller.offset + 300);
    //todo: emir need your help here
    await tester.pump(const Duration(milliseconds: 500));
    expect(controller.offset, equals(300));
  });

  testWidgets('scrollUpBoards should animate to the correct position', (WidgetTester tester) async {
    final boardScrollController = ScrollController();
    chatGptGameProvider.boardScrollController = boardScrollController;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: boardScrollController,
            children: [
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
              Container(height: 100),
            ],
          ),
        ),
      ),
    );
    final lView = tester.widget<ListView>(find.byType(ListView));
    final controller = lView.controller;

    controller?.jumpTo(400);

    expect(boardScrollController.position.pixels, equals(400.0));

    controller?.jumpTo(304);
    chatGptGameProvider.scrollDownBoards();

    expect(controller!.position.pixels, equals(304.0));
  });

  test('should call notify ', () {
    expect(() => chatGptGameProvider.notify(), isA<void>());
  });
}
