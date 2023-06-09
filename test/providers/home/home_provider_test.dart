import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([TTSProvider, SentencesRepository, GroupsRepository, PictogramsRepository, PredictPictogram, LearnPictogram, ChatGPTNotifier, LocalDatabaseRepository])
@GenerateNiceMocks([MockSpec<PatientNotifier>(), MockSpec<UserNotifier>()])
Future<void> main() async {
  late MockTTSProvider mockTTSProvider;
  late MockUserNotifier mockUserNotifier;
  late MockPatientNotifier mockPatientNotifier;
  late MockSentencesRepository mockSentencesRepository;
  late MockGroupsRepository mockGroupsRepository;
  late MockPictogramsRepository mockPictogramsRepository;
  late MockChatGPTNotifier mockChatGPTNotifier;
  late MockLearnPictogram mockLearnPictogram;
  late MockPredictPictogram mockPredictPictogram;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;

  late HomeProvider homeProvider;

  late List<Phrase> fakePhrases;

  late List<Picto> fakePictos;
  late Map<String, Picto> fakePictosMap;

  late UserModel fakeUser;

  late List<Group> fakeGroups;

  setUp(() {
    mockTTSProvider = MockTTSProvider();
    mockUserNotifier = MockUserNotifier();
    mockPatientNotifier = MockPatientNotifier();
    mockSentencesRepository = MockSentencesRepository();
    mockGroupsRepository = MockGroupsRepository();
    mockPictogramsRepository = MockPictogramsRepository();
    mockChatGPTNotifier = MockChatGPTNotifier();
    mockLearnPictogram = MockLearnPictogram();
    mockPredictPictogram = MockPredictPictogram();
    mockLocalDatabaseRepository = MockLocalDatabaseRepository();

    fakePhrases = [
      Phrase(date: DateTime.now(), id: '00', sequence: [Sequence(id: '22')], tags: {}),
      Phrase(date: DateTime.now(), id: '22', sequence: [Sequence(id: '22')], tags: {})
    ];
    fakePictos = [
      Picto(id: '0', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }),
      Picto(id: '1', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MEDIODIA', 'TARDE']
      }),
      Picto(id: '2', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {'hour': []}),
      Picto(id: '3', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['NOCHE']
      }),
      Picto(id: '4', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA', 'TARDE', 'NOCHE']
      }),
      Picto(id: '5', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA', 'TARDE', 'NOCHE']
      }),
    ];

    fakePictosMap = {
      '0': Picto(id: '0', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }),
      '1': Picto(id: '1', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MEDIODIA', 'TARDE']
      }),
      '2': Picto(id: '2', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {'hour': []}),
      '3': Picto(id: '3', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['NOCHE']
      }),
      '4': Picto(id: '4', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA', 'TARDE', 'NOCHE']
      }),
    };
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
    fakeGroups = [
      Group(id: '0', relations: [GroupRelation(id: '0', value: 0), GroupRelation(id: '1', value: 0)], text: 'test1', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 00),
      Group(id: '1', relations: [GroupRelation(id: '1', value: 0)], text: 'test2', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 01),
      Group(id: '2', relations: [GroupRelation(id: '2', value: 0)], text: 'test3', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 03),
    ];
    mockPatientNotifier.state = PatientUserModel(id: '00', groups: {}, phrases: {}, pictos: {}, settings: fakeUser.settings, email: 'test@test.com');
    mockUserNotifier.setUser(fakeUser);
    homeProvider = HomeProvider(mockPictogramsRepository, mockGroupsRepository, mockSentencesRepository, mockTTSProvider, mockPatientNotifier, mockPredictPictogram, mockLearnPictogram, mockUserNotifier, mockChatGPTNotifier, mockLocalDatabaseRepository);
  });


  test('should call notifyListeners', () {
    homeProvider.notify();

    expect(() => homeProvider.notify(), isA<void>());
  });

  group('fetchMostUsedSentences', () {
    test('should update mostUsedSentences and trigger notifyListeners', () async {
      final mockResponse = fakePhrases;

      when(mockSentencesRepository.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => Right(mockResponse));

      await homeProvider.fetchMostUsedSentences();

      expect(homeProvider.mostUsedSentences, mockResponse);
      expect(() => homeProvider.notifyListeners(), isA<void>());
    });

    test('should update mostUsedSentences to empty list when fetchSentences returns an error', () async {
      when(mockSentencesRepository.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => const Left(''));

      await homeProvider.fetchMostUsedSentences();

      expect(homeProvider.mostUsedSentences, isEmpty);
      expect(() => homeProvider.notifyListeners(), isA<void>());
    });
  });

  test('should update suggestedQuantity and trigger notifyListeners', () {
    const expectedQuantity = 10;

    homeProvider.setSuggedtedQuantity(expectedQuantity);

    expect(homeProvider.suggestedQuantity, expectedQuantity);
    expect(() => homeProvider.notifyListeners(), isA<void>());
  });

  group('fetchPictograms', () {
    test('should fetch pictograms and groups when user is authenticated', () async {
      when(mockPictogramsRepository.getAllPictograms()).thenAnswer((realInvocation) async => fakePictos);
      when(mockGroupsRepository.getAllGroups()).thenAnswer((realInvocation) async => fakeGroups);

      await homeProvider.fetchPictograms();

      expect(homeProvider.pictograms.length, fakePictos.length);
      expect(homeProvider.groups.length, fakeGroups.length);
      expect(homeProvider.pictograms.values, containsAll(fakePictos));
      expect(homeProvider.groups.values, containsAll(fakeGroups));
    });

    test('should not fetch all pictograms and groups when user is not authenticated', () async {
      homeProvider.patientState.setUser(null);
      when(mockPictogramsRepository.getAllPictograms()).thenAnswer((realInvocation) async => []);
      when(mockGroupsRepository.getAllGroups()).thenAnswer((realInvocation) async => []);

      await homeProvider.fetchPictograms();

      expect(homeProvider.pictograms.length, 0);
      expect(homeProvider.groups.length, 0);
    });
  });

  test('predictiveAlgorithm returns the correct list of Picto objects', () {
    final list = [
      const PictoRelation(id: '0', value: 0.8),
      const PictoRelation(id: '1', value: 0.5),
      const PictoRelation(id: '2', value: 0.3),
      const PictoRelation(id: '3', value: 0.2),
    ];
    homeProvider.pictograms = fakePictosMap;
    final result = homeProvider.predictiveAlgorithm(list: list);

    expect(result, hasLength(4));
    expect(result[0].id, equals('3'));
    expect(result[1].id, equals('0'));
    expect(result[2].id, equals('1'));
    expect(result[3].id, equals('2'));
  });

  test('refreshPictograms updates the indexPage and notifies listeners', () {
    homeProvider.suggestedPicts = fakePictos;
    homeProvider.suggestedQuantity = 2;

    homeProvider.refreshPictograms();

    expect(homeProvider.indexPage, equals(1));

    homeProvider.refreshPictograms();

    expect(homeProvider.indexPage, equals(2));

    homeProvider.indexPage = -1;
    homeProvider.refreshPictograms();

    expect(homeProvider.indexPage, equals(0));

    expect(() => homeProvider.notify(), isA<void>());
  });

  group('test scroll up function of the provider', () {
    testWidgets('scrollUp scrolls the controller up by the specified amount', (WidgetTester tester) async {
      final controller = ScrollController(initialScrollOffset: 100.0);
      const amount = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      expect(controller.position.pixels, equals(100.0));

      homeProvider.scrollUp(controller, amount);

      await tester.pumpAndSettle();

      expect(controller.position.pixels, equals(0));
    });

    testWidgets('scrollUp does not scroll the controller when currentPosition is 0', (WidgetTester tester) async {
      final controller = ScrollController(initialScrollOffset: 0.0);
      const amount = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      expect(controller.position.pixels, equals(0.0));

      homeProvider.scrollUp(controller, amount);

      await tester.pumpAndSettle();

      expect(controller.position.pixels, equals(0.0));
    });
  });

  group('test scroll down function of the provider', () {
    testWidgets('scrollDown scrolls the controller up by the specified amount', (WidgetTester tester) async {
      final controller = ScrollController(initialScrollOffset: 100.0);
      const amount = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      expect(controller.position.pixels, equals(100.0));

      homeProvider.scrollUp(controller, amount);

      await tester.pumpAndSettle();

      expect(controller.position.pixels, equals(0));
    });

    testWidgets('scrollDown does not scroll the controller when currentPosition is 0', (WidgetTester tester) async {
      final controller = ScrollController(initialScrollOffset: 0.0);
      const amount = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      expect(controller.position.pixels, equals(0.0));

      homeProvider.scrollDown(controller, amount);

      await tester.pumpAndSettle();

      expect(controller.position.pixels, equals(0.0));
    });
  });

  test('getPictograms returns the correct list of pictograms', () {
    // Set up initial state
    homeProvider.suggestedPicts = [
      Picto(id: "1", text: "Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "2", text: "Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "3", text: "Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
    ];

    basicPictograms = [
      Picto(id: "101", text: "Basic Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "102", text: "Basic Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "103", text: "Basic Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "104", text: "Basic Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "105", text: "Basic Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
    ];

    homeProvider.suggestedQuantity = 3;
    homeProvider.indexPage = 1;

    // Call the method
    final result = homeProvider.getPictograms();

    // Check the expected list of pictograms
    expect(result, [
      Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      Picto(id: "777", text: "", type: 0, resource: AssetsImage(asset: "", network: null)),
    ]);
  });

  //todo: emir these are left init, switchToPictograms, addPictogram, removeLastPictogram, buildSuggestion,
}
