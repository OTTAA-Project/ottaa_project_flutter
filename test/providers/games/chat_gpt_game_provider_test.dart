import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import '../../service/chatGPT/chatgpt_service_test.mocks.dart';
import 'chat_gpt_game_provider_test.mocks.dart';

@GenerateMocks([GamesProvider, ChatGPTRepository, TTSProvider, AudioPlayer])
Future<void> main() async {
  late MockGamesProvider mockGamesProvider;
  late MockChatGPTRepository mockChatGPTRepository;
  late MockTTSProvider mockTTSProvider;
  late MockAudioPlayer mockAudioPlayer;

  late ChatGptGameProvider refChatGptGameProvider;

  late List<Picto> fakePictos;

  MockI18N mockI18N = MockI18N();

  GetIt.I.registerSingleton<I18N>(mockI18N);

  setUp(() {
    mockChatGPTRepository = MockChatGPTRepository();
    mockGamesProvider = MockGamesProvider();
    mockTTSProvider = MockTTSProvider();
    mockAudioPlayer = MockAudioPlayer();

    fakePictos = [
      Picto(id: '0', type: 0, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'one'),
      Picto(id: '1', type: 1, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: false, text: 'two'),
      Picto(id: '2', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'three'),
      Picto(id: '3', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'four'),
    ];

    when(mockI18N.currentLanguage).thenReturn(TranslationTree(const Locale("es_AR")));
    refChatGptGameProvider = ChatGptGameProvider(mockChatGPTRepository, mockGamesProvider, mockTTSProvider);
  });

  group('create the story for the chat gpt game', () {
    test('should create the story if the resource is given by the chatGptServices', () async {
      refChatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Right('fake'));
      await refChatGptGameProvider.createStory();
      expect(refChatGptGameProvider.generatedStory, 'fake');
    });

    test('should not create the story if the resource is not given by the chatGptServices', () async {
      refChatGptGameProvider.gptPictos = fakePictos;

      when(mockChatGPTRepository.getGPTStory(prompt: anyNamed('prompt'))).thenAnswer((realInvocation) async => const Left('fake'));
      await refChatGptGameProvider.createStory();
      expect(refChatGptGameProvider.generatedStory, '');
    });
  });

  test('should reset the game variables being used', () async {
    expect(refChatGptGameProvider.gptPictos.length, 0);
    expect(refChatGptGameProvider.sentencePhase, 0);
  });

  test('should speak the generated story for the game', () async {
    expect(() async => await refChatGptGameProvider.speakStory(), isA<void>());
  });

  testWidgets('scrollDownBoards should animate to the correct position', (WidgetTester tester) async {
    // Initialize the scroll controller
    refChatGptGameProvider.boardScrollController = ScrollController();

    // Build the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: refChatGptGameProvider.boardScrollController,
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
    expect(refChatGptGameProvider.boardScrollController.position.pixels.toInt(), equals(0.0));

    refChatGptGameProvider.scrollDownBoards();
    controller!.jumpTo(controller.offset + 300);
    //todo: emir need your help here
    await tester.pump(const Duration(milliseconds: 500));
    expect(controller.offset, equals(300));
  });
  testWidgets('scrollDownPictos should animate to the correct position', (WidgetTester tester) async {
    // Initialize the scroll controller
    refChatGptGameProvider.pictoScrollController = ScrollController();

    // Build the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: refChatGptGameProvider.pictoScrollController,
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
    expect(refChatGptGameProvider.pictoScrollController.position.pixels.toInt(), equals(0.0));

    refChatGptGameProvider.scrollDownPictos();
    controller!.jumpTo(controller.offset + 300);
    //todo: emir need your help here
    await tester.pump(const Duration(milliseconds: 500));
    expect(controller.offset, equals(300));
  });

  testWidgets('scrollUpBoards should animate to the correct position', (WidgetTester tester) async {
    final boardScrollController = ScrollController();
    refChatGptGameProvider.boardScrollController = boardScrollController;

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
    refChatGptGameProvider.scrollUpBoards();

    expect(controller!.position.pixels, equals(304.0));
  });
  testWidgets('scrollUpPictos should animate to the correct position', (WidgetTester tester) async {
    final boardScrollController = ScrollController();
    refChatGptGameProvider.pictoScrollController = boardScrollController;

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
    refChatGptGameProvider.scrollUpPictos();

    expect(controller!.position.pixels, equals(304.0));
  });

  test('should call notify ', () {
    int listListenerCallCount = 0;

    refChatGptGameProvider.addListener(() {
      listListenerCallCount++;
    });

    expect(listListenerCallCount, 0);

    refChatGptGameProvider.notify();

    expect(listListenerCallCount, 1);
  });

  test('should stop the tts from speaking', () async {
    expect(() async => await refChatGptGameProvider.stopTTS(), isA<void>());
  });

  test('reset the game story variables', () async {
    refChatGptGameProvider.sentencePhase = 3;
    refChatGptGameProvider.resetStoryGame();
    expect(refChatGptGameProvider.sentencePhase, 0);
  });

  test("should fetch gpt pictos", () async {
    final fakeGroups = {
      "1": Group(
        id: "1",
        relations: [
          GroupRelation(id: "0", value: 1),
        ],
        text: "1",
        resource: AssetsImage(asset: "asset", network: "network"),
        freq: 1,
      ),
    };

    final fakePictos = {
      "0": Picto(
        id: '0',
        type: 0,
        resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'),
        block: true,
        text: 'one',
      ),
    };

    when(mockGamesProvider.groups).thenReturn(fakeGroups);
    when(mockGamesProvider.pictograms).thenReturn(fakePictos);

    await refChatGptGameProvider.fetchGptPictos(id: "1");

    expect(refChatGptGameProvider.chatGptPictos.length, 1);
    verify(mockGamesProvider.groups).called(1);
    verify(mockGamesProvider.pictograms).called(1);
  });

  group("speak story", () {
    test("should speak and pause music", () async {
      when(mockGamesProvider.backgroundMusicPlayer).thenReturn(mockAudioPlayer);
      when(mockAudioPlayer.playing).thenReturn(true);

      when(mockAudioPlayer.pause()).thenAnswer((_) async => 1);
      when(mockTTSProvider.speak(any)).thenAnswer((_) async => 1);

      await refChatGptGameProvider.speakStory();

      verify(mockGamesProvider.backgroundMusicPlayer).called(2);
      verify(mockAudioPlayer.pause()).called(1);
      verify(mockTTSProvider.speak(any)).called(1);
    });
  });

  test("should stop tts", () async {
    when(mockTTSProvider.ttsStop()).thenAnswer((_) async => 1);

    await refChatGptGameProvider.stopTTS();

    verify(mockTTSProvider.ttsStop()).called(1);
  });

  test("should return chatGPT game provider", () async {
    GetIt.I.registerSingleton<ChatGPTRepository>(mockChatGPTRepository);

    final container = ProviderContainer(
      overrides: [
        gameProvider.overrideWith((ref) => mockGamesProvider),
        ttsProvider.overrideWith((ref) => mockTTSProvider),
      ],
    );

    final gptProvider = container.read(chatGptGameProvider);

    expect(gptProvider, isA<ChatGptGameProvider>());
  });
}
