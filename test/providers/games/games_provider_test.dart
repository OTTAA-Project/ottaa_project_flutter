import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'chat_gpt_game_provider_test.mocks.dart';
import 'games_provider_test.mocks.dart';

@GenerateMocks([PictogramsRepository, GroupsRepository, PatientNotifier])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPictogramsRepository mockPictogramsRepository;
  late MockGroupsRepository mockGroupsRepository;
  late MockPatientNotifier mockPatientNotifier;
  late MockAudioPlayer backgroundAudioPlayer;
  late MockAudioPlayer clicksAudioPlayer;
  late GamesProvider gamesProvider;
  WidgetsFlutterBinding.ensureInitialized();

  final fakePictos = [
    Picto(id: '0', type: 0, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'one'),
    Picto(id: '1', type: 1, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: false, text: 'two'),
    Picto(id: '2', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: false, text: 'three'),
    Picto(id: '3', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true, text: 'four'),
  ];

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
    "2": Group(
      id: "2",
      relations: [
        GroupRelation(id: "1", value: 1),
      ],
      text: "1",
      resource: AssetsImage(asset: "asset", network: "network"),
      freq: 1,
    ),
    "3": Group(
      id: "3",
      relations: [
        GroupRelation(id: "2", value: 1),
        GroupRelation(id: "3", value: 1),
      ],
      text: "1",
      resource: AssetsImage(asset: "asset", network: "network"),
      freq: 1,
    ),
  };

  setUp(() {
    mockPictogramsRepository = MockPictogramsRepository();
    mockGroupsRepository = MockGroupsRepository();
    mockPatientNotifier = MockPatientNotifier();

    backgroundAudioPlayer = MockAudioPlayer();
    clicksAudioPlayer = MockAudioPlayer();

    gamesProvider = GamesProvider(mockGroupsRepository, mockPictogramsRepository, mockPatientNotifier, backgroundMusicPlayer: backgroundAudioPlayer, clicksPlayer: clicksAudioPlayer);
  });

  test('should cancel hints for the game', () async {
    gamesProvider.hintTimer1 = Timer(const Duration(milliseconds: 1000), () {});
    gamesProvider.hintTimer2 = Timer(const Duration(milliseconds: 1000), () {});
    gamesProvider.hintsEnabled = true;
    await gamesProvider.cancelHints();
    expect(gamesProvider.hintsEnabled, false);
  });

  test("should generate pictograms", () async {
    gamesProvider.selectedPicts = fakePictos;

    int count = 0;

    gamesProvider.addListener(() {
      count++;
    });

    await gamesProvider.createRandomForGameWTP();

    expect(gamesProvider.gamePictsWTP.length, 2);
    expect(count, 1);
  });

  test("should rest game score", () {
    gamesProvider.incorrectScore = 2;
    gamesProvider.correctScore = 2;
    gamesProvider.useTime = 2;
    gamesProvider.streak = 2;
    gamesProvider.difficultyLevel = 2;

    gamesProvider.gameTimer = Timer(const Duration(milliseconds: 1000), () {});

    gamesProvider.resetScore();

    expect(gamesProvider.incorrectScore, 0);
    expect(gamesProvider.correctScore, 0);
    expect(gamesProvider.useTime, 0);
    expect(gamesProvider.streak, 0);
    expect(gamesProvider.difficultyLevel, 0);
    expect(gamesProvider.gameTimer.isActive, false);
  });

  test("should generate random for game mp", () async {
    gamesProvider.selectedPicts = fakePictos;

    int count = 0;

    gamesProvider.addListener(() {
      count++;
    });

    await gamesProvider.createRandomForGameMP();

    expect(count, 1);
  });

  test("should fetch selected pictos", () {
    gamesProvider.groups = fakeGroups;
    gamesProvider.pictograms = fakePictos.asMap().map(
          (key, value) => MapEntry(value.id, value),
        );

    gamesProvider.fetchSelectedPictos();

    expect(gamesProvider.selectedPicts.length, 1);
  });

  testWidgets("should move forward and backward", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageView(
            controller: gamesProvider.mainPageController,
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

    final lView = tester.widget<PageView>(find.byType(PageView));
    final controller = lView.controller;
    await tester.pump(Duration(seconds: 1));
    gamesProvider.moveForward();

    await tester.pumpAndSettle(Duration(seconds: 20));
    expect(controller.page, 1);

    gamesProvider.moveBackward();
    await tester.pumpAndSettle(Duration(seconds: 20));
    expect(controller.page, 0);
  });

  testWidgets("should scroll down and up", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: gamesProvider.gridScrollController,
            children: [
              Container(height: 200),
              Container(height: 200),
              Container(height: 200),
              Container(height: 200),
              Container(height: 200),
            ],
          ),
        ),
      ),
    );

    final lView = tester.widget<ListView>(find.byType(ListView));
    final controller = lView.controller;
    await tester.pump(Duration(seconds: 1));
    gamesProvider.scrollDown();

    await tester.pumpAndSettle(Duration(seconds: 20));
    expect(controller!.position.pixels, greaterThan(0));

    gamesProvider.scrollUp();
    await tester.pumpAndSettle(Duration(seconds: 20));
    expect(controller.position.pixels, lessThan(10));
  });

  group("fetch pictograms", () {
    test("Should fetch pictograms without patiend", () async {
      when(mockPictogramsRepository.getAllPictograms()).thenAnswer((realInvocation) async {
        return fakePictos;
      });

      when(mockPatientNotifier.state).thenReturn(null);

      when(mockGroupsRepository.getAllGroups()).thenAnswer((realInvocation) async {
        return fakeGroups.values.toList();
      });

      await gamesProvider.fetchPictograms();

      expect(gamesProvider.pictograms.length, 2);
      expect(gamesProvider.groups.length, fakeGroups.length);
      verify(mockPictogramsRepository.getAllPictograms()).called(1);
      verify(mockGroupsRepository.getAllGroups()).called(1);
    });
  });

  test("should init provider", () async {
    when(backgroundAudioPlayer.setAsset('assets/audios/funckygroove.mp3')).thenAnswer((_) async => Duration(days: 1));
    when(backgroundAudioPlayer.setLoopMode(LoopMode.one)).thenAnswer((_) async => Duration(days: 1));
    when(backgroundAudioPlayer.setVolume(0.2)).thenAnswer((_) async => ({}));
    when(backgroundAudioPlayer.play()).thenAnswer((_) async => {});

    gamesProvider.isMute = false;
    gamesProvider.hintsBtn = true;
    await gamesProvider.init();

    verify(backgroundAudioPlayer.setAsset('assets/audios/funckygroove.mp3')).called(1);
    verify(backgroundAudioPlayer.setLoopMode(LoopMode.one)).called(1);
    verify(backgroundAudioPlayer.setVolume(0.2)).called(1);
    verify(backgroundAudioPlayer.play()).called(1);
  });

  test("should notify", () async {
    int count = 0;
    gamesProvider.addListener(() {
      count++;
    });

    gamesProvider.notify();

    expect(count, 1);
  });

  test("play click sounds", () async {
    when(clicksAudioPlayer.setAsset(any)).thenAnswer((realInvocation) async => const Duration());
    when(clicksAudioPlayer.play()).thenAnswer((realInvocation) async => ({}));

    await gamesProvider.playClickSounds(assetName: "click");

    verify(clicksAudioPlayer.setAsset(any)).called(1);
    verify(clicksAudioPlayer.play()).called(1);
  });

  group("change music", () {
    test("should mute", () async {
      when(backgroundAudioPlayer.pause()).thenAnswer((realInvocation) async {});

      await gamesProvider.changeMusic(mute: true);

      verify(backgroundAudioPlayer.pause()).called(1);
    });

    test("should unmute", () async {
      when(backgroundAudioPlayer.play()).thenAnswer((realInvocation) async {});

      await gamesProvider.changeMusic(mute: false);

      verify(backgroundAudioPlayer.play()).called(1);
    });
  });

  test("should dispose", () {
    gamesProvider.hintTimer1 = Timer(const Duration(milliseconds: 1000), () {});
    gamesProvider.hintTimer2 = Timer(const Duration(milliseconds: 1000), () {});

    gamesProvider.dispose();

    expect(gamesProvider.hintTimer1.isActive, false);
    expect(gamesProvider.hintTimer2.isActive, false);
  });

  test("should return instance", () async {
    GetIt.I.registerSingleton<PictogramsRepository>(mockPictogramsRepository);
    GetIt.I.registerSingleton<GroupsRepository>(mockGroupsRepository);
    final container = ProviderContainer();

    final provider = container.read(gameProvider);

    expect(provider, isA<GamesProvider>());
  });
}
