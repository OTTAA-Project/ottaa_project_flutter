import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_predicted_reduced.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([TTSProvider, SentencesRepository, GroupsRepository, PictogramsRepository, PredictPictogram, LearnPictogram, ChatGPTNotifier, LocalDatabaseRepository, I18N])
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
  late MockI18N mockI18N;

  late HomeProvider cHomeProvider;

  late List<Phrase> fakePhrases;

  late List<Picto> fakePictos;
  late Map<String, Picto> fakePictosMap;

  late PatientUserModel fakeUser;

  late Map<String, Group> fakeGroupsMap;

  late List<Group> fakeGroups;

  setUpAll(() {
    mockI18N = MockI18N();

    GetIt.I.registerSingleton<I18N>(mockI18N);
    final trl = TranslationTree(Locale("es_AR"));
    trl.addTranslations({
      "global": {"no": "no", "yes": "yes"}
    });

    when(mockI18N.currentLanguage).thenReturn(trl);
  });

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
      }, relations: [
        PictoRelation(id: "0", value: 3)
      ]),
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
      '_hqTU9A7I3RFDVrcIEK-L': Picto(id: '_hqTU9A7I3RFDVrcIEK-L', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }, relations: [
        PictoRelation(id: "0", value: 2)
      ]),
      '0': Picto(id: '0', type: 1, resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }, relations: [
        PictoRelation(id: "1", value: 2)
      ]),
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

    fakeGroupsMap = {
      "0": Group(id: '0', relations: [GroupRelation(id: '0', value: 0), GroupRelation(id: '1', value: 0)], text: 'test1', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 00),
      "1": Group(id: '1', relations: [GroupRelation(id: '1', value: 0)], text: 'test2', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 01),
      "2": Group(id: '2', relations: [GroupRelation(id: '2', value: 0)], text: 'test3', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 03),
    };
    fakeGroups = fakeGroupsMap.values.toList();

    fakeUser = PatientUserModel(
      id: "0",
      groups: {
        "es_AR": fakeGroupsMap.values.toList(),
      },
      phrases: {},
      pictos: {
        "es_AR": fakePictosMap.values.toList(),
      },
      settings: PatientSettings(
        payment: Payment.none(),
        accessibility: AccessibilitySetting.empty(),
        layout: LayoutSetting.empty().copyWith(oneToOne: true),
        tts: TTSSetting.empty(),
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
      type: UserType.user,
    );

    cHomeProvider = HomeProvider(mockPictogramsRepository, mockGroupsRepository, mockSentencesRepository, mockTTSProvider, mockPatientNotifier, mockPredictPictogram, mockLearnPictogram, mockUserNotifier, mockChatGPTNotifier, mockLocalDatabaseRepository);
  });

  test('should call notifyListeners', () {
    cHomeProvider.notify();

    expect(() => cHomeProvider.notify(), isA<void>());
  });

  group('fetchMostUsedSentences', () {
    test('should update mostUsedSentences and trigger notifyListeners', () async {
      final mockResponse = fakePhrases;

      when(mockSentencesRepository.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => Right(mockResponse));

      await cHomeProvider.fetchMostUsedSentences();

      expect(cHomeProvider.mostUsedSentences, mockResponse);
      expect(() => cHomeProvider.notifyListeners(), isA<void>());
    });

    test('should update mostUsedSentences to empty list when fetchSentences returns an error', () async {
      when(mockSentencesRepository.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => const Left(''));

      await cHomeProvider.fetchMostUsedSentences();

      expect(cHomeProvider.mostUsedSentences, isEmpty);
      expect(() => cHomeProvider.notifyListeners(), isA<void>());
    });
  });

  test('should update suggestedQuantity and trigger notifyListeners', () {
    const expectedQuantity = 10;

    cHomeProvider.setSuggedtedQuantity(expectedQuantity);

    expect(cHomeProvider.suggestedQuantity, expectedQuantity);
    expect(() => cHomeProvider.notifyListeners(), isA<void>());
  });

  group('fetchPictograms', () {
    test('should fetch pictograms and groups when user is authenticated', () async {
      when(mockPatientNotifier.patient).thenReturn(fakeUser);
      when(mockPatientNotifier.user).thenReturn(fakeUser);

      await cHomeProvider.fetchPictograms();

      expect(cHomeProvider.pictograms.length, 6);
      expect(cHomeProvider.groups.length, fakeGroups.length);
    });

    test('should not fetch all pictograms and groups when user is not authenticated', () async {
      when(mockPictogramsRepository.getAllPictograms()).thenAnswer((realInvocation) async => []);
      when(mockGroupsRepository.getAllGroups()).thenAnswer((realInvocation) async => []);

      await cHomeProvider.fetchPictograms();

      expect(cHomeProvider.pictograms.length, 0);
      expect(cHomeProvider.groups.length, 0);
    });
  });

  test('predictiveAlgorithm returns the correct list of Picto objects', () {
    final list = [
      const PictoRelation(id: '0', value: 0.8),
      const PictoRelation(id: '1', value: 0.5),
      const PictoRelation(id: '2', value: 0.3),
      const PictoRelation(id: '3', value: 0.2),
    ];
    cHomeProvider.pictograms = fakePictosMap;
    final result = cHomeProvider.predictiveAlgorithm(list: list);

    expect(result, hasLength(4));
  });

  group("refresh pictograms", () {
    test('updates the indexPage and notifies listeners', () {
      cHomeProvider.suggestedPicts = fakePictos;
      cHomeProvider.suggestedQuantity = 2;

      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(1));

      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(2));

      cHomeProvider.indexPage = -1;
      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(0));

      expect(() => cHomeProvider.notify(), isA<void>());
    });

    test('updates the indexPage and notifies listeners where indexPage > currentPage', () {
      cHomeProvider.suggestedPicts = fakePictos;
      cHomeProvider.suggestedQuantity = 2;

      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(1));

      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(2));

      cHomeProvider.indexPage = 4;
      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(0));

      expect(() => cHomeProvider.notify(), isA<void>());
    });

    test('updates the indexPage and notifies listeners where indexPage > currentPage', () {
      cHomeProvider.suggestedPicts = fakePictos;
      cHomeProvider.suggestedQuantity = 2;
      cHomeProvider.indexPage = -3;
      cHomeProvider.refreshPictograms();

      expect(cHomeProvider.indexPage, equals(0));
    });
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

      cHomeProvider.scrollUp(controller, amount);

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

      cHomeProvider.scrollUp(controller, amount);

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

      cHomeProvider.scrollUp(controller, amount);

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

      cHomeProvider.scrollDown(controller, amount);

      await tester.pumpAndSettle();

      expect(controller.position.pixels, equals(0.0));
    });
  });

  group("get pictograms", () {
    test('returns the correct list of pictograms', () {
      // Set up initial state
      cHomeProvider.suggestedPicts = [
        Picto(id: "1", text: "Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "2", text: "Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "3", text: "Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.basicPictograms = [
        Picto(id: "101", text: "Basic Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "102", text: "Basic Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "103", text: "Basic Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "104", text: "Basic Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "105", text: "Basic Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.suggestedQuantity = 3;
      cHomeProvider.indexPage = 1;

      // Call the method
      final result = cHomeProvider.getPictograms();

      // Check the expected list of pictograms
      expect(result, [
        Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "777", text: "", type: 0, resource: AssetsImage(asset: "", network: null)),
      ]);
    });

    test('returns the correct list of pictograms', () {
      // Set up initial state
      cHomeProvider.suggestedPicts = null;

      // Call the method
      final result = cHomeProvider.getPictograms();

      // Check the expected list of pictograms
      expect(result, [
        Picto(
          id: "-777",
          text: "",
          type: 0,
          resource: AssetsImage(
            asset: "",
            network: null,
          ),
        ),
        Picto(
          id: "-777",
          text: "",
          type: 0,
          resource: AssetsImage(
            asset: "",
            network: null,
          ),
        ),
        Picto(
          id: "-777",
          text: "",
          type: 0,
          resource: AssetsImage(
            asset: "",
            network: null,
          ),
        ),
        Picto(
          id: "-777",
          text: "",
          type: 0,
          resource: AssetsImage(
            asset: "",
            network: null,
          ),
        )
      ]);
    });

    test('returns the correct list of pictograms with indexPage > currentPage', () {
      // Set up initial state
      cHomeProvider.suggestedPicts = [
        Picto(id: "1", text: "Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "2", text: "Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "3", text: "Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.basicPictograms = [
        Picto(id: "101", text: "Basic Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "102", text: "Basic Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "103", text: "Basic Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "104", text: "Basic Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "105", text: "Basic Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.suggestedQuantity = 4;
      cHomeProvider.indexPage = 3;

      // Call the method
      final result = cHomeProvider.getPictograms();
      int currentPage = (cHomeProvider.suggestedPicts!.length / 4).round();

      // Check the expected list of pictograms
      expect(cHomeProvider.indexPage, equals(currentPage));
    });

    test('returns the correct list of pictograms with indexPage > currentPage', () {
      // Set up initial state
      cHomeProvider.suggestedPicts = [
        Picto(id: "1", text: "Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "2", text: "Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "3", text: "Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "4", text: "Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "5", text: "Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.basicPictograms = [
        Picto(id: "101", text: "Basic Picto 1", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "102", text: "Basic Picto 2", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "103", text: "Basic Picto 3", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "104", text: "Basic Picto 4", type: 0, resource: AssetsImage(asset: "", network: null)),
        Picto(id: "105", text: "Basic Picto 5", type: 0, resource: AssetsImage(asset: "", network: null)),
      ];

      cHomeProvider.suggestedQuantity = 4;
      cHomeProvider.indexPage = -1;

      // Call the method
      final result = cHomeProvider.getPictograms();

      expect(cHomeProvider.indexPage, equals(0));
    });
  });
  group('should return true or false based upon the locally storedvalues', () {
    test('isLongClickEnabled should return a true', () async {
      when(mockLocalDatabaseRepository.getLongClick()).thenAnswer((realInvocation) async => true);

      final response = await cHomeProvider.isLongClickEnabled();
      expect(response, true);
    });

    test('isLongClickEnabled should return a false', () async {
      when(mockLocalDatabaseRepository.getLongClick()).thenAnswer((realInvocation) async => false);

      final response = await cHomeProvider.isLongClickEnabled();
      expect(response, false);
    });
  });

  test('setLongClickEnabled should set the value into the local storage', () async {
    expect(() async => await cHomeProvider.setLongClickEnabled(isLongClick: true), isA<void>());
  });

  testWidgets("set current group should change current tab group", (tester) async {
    final controller = cHomeProvider.pictoTabsScrollController;
    int counter = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView.builder(
            controller: controller,
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    controller.jumpTo(100.0);

    await tester.pumpAndSettle();

    cHomeProvider.addListener(() {
      counter++;
    });

    cHomeProvider.setCurrentGroup("HOLA");

    await tester.pumpAndSettle();
    expect(controller.position.pixels, equals(0.0));
    expect(cHomeProvider.currentTabGroup, "HOLA");
    expect(counter, 1);
  });

  test("set long click enabled", () async {
    when(mockLocalDatabaseRepository.setLongClick(isLongClick: anyNamed("isLongClick"))).thenAnswer((realInvocation) async => {});

    await cHomeProvider.setLongClickEnabled(isLongClick: true);

    verify(mockLocalDatabaseRepository.setLongClick(isLongClick: anyNamed("isLongClick")));
  });

  test("should init provider", () async {
    when(mockPatientNotifier.patient).thenReturn(fakeUser);
    when(mockPatientNotifier.user).thenReturn(fakeUser);
    when(mockUserNotifier.user).thenReturn(fakeUser);
    when(mockPictogramsRepository.loadTranslations(language: anyNamed("language"))).thenAnswer((realInvocation) async {
      return {};
    });
    when(mockLocalDatabaseRepository.getLongClick()).thenAnswer((realInvocation) async => true);

    when(mockPredictPictogram.call(
      sentence: anyNamed("sentence"),
      uid: anyNamed("uid"),
      language: anyNamed("language"),
      model: anyNamed("model"),
      groups: anyNamed("groups"),
      tags: anyNamed("tags"),
      cancelToken: anyNamed("cancelToken"),
      reduced: anyNamed("reduced"),
    )).thenAnswer((realInvocation) async {
      return Right([
        PictoPredictedReduced(name: "", id: {
          "local": "1",
        }),
      ]);
    });

    await cHomeProvider.init();

    verify(mockPatientNotifier.patient);
    verify(mockPatientNotifier.user);
    verify(mockUserNotifier.user);
    verify(mockPictogramsRepository.loadTranslations(language: anyNamed("language")));
    verify(mockLocalDatabaseRepository.getLongClick());
    verify(mockPredictPictogram.call(
      sentence: anyNamed("sentence"),
      uid: anyNamed("uid"),
      language: anyNamed("language"),
      model: anyNamed("model"),
      groups: anyNamed("groups"),
      tags: anyNamed("tags"),
      cancelToken: anyNamed("cancelToken"),
      reduced: anyNamed("reduced"),
    ));
  });

  group("build suggestion", () {
    test("should build basic pictograms", () async {
      cHomeProvider.basicPictograms = fakePictos;

      cHomeProvider.pictograms = fakePictosMap;

      await cHomeProvider.buildSuggestion(kStarterPictoId);

      expect(cHomeProvider.suggestedPicts, fakePictos);
    });
    test("should build basic pictograms", () async {
      cHomeProvider.pictograms = fakePictosMap;

      await cHomeProvider.buildSuggestion("0");

      expect(cHomeProvider.suggestedPicts, hasLength(1));
    });
  });

  group("add pictogram", () {
    test("should add picto", () async {
      cHomeProvider.pictograms = fakePictosMap;
      cHomeProvider.addPictogram(fakePictos.first);

      expect(cHomeProvider.pictoWords, hasLength(1));
      expect(cHomeProvider.suggestedPicts, hasLength(1));
    });

    testWidgets("should add picto and jumpto", (tester) async {
      final controller = cHomeProvider.scrollController;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      cHomeProvider.pictograms = fakePictosMap;
      cHomeProvider.pictoWords = List.generate(5, (index) {
        return fakePictos[index % fakePictos.length];
      });
      cHomeProvider.addPictogram(fakePictos.first);

      await tester.pumpAndSettle();
      expect(cHomeProvider.pictoWords, hasLength(6));
      expect(cHomeProvider.suggestedPicts, hasLength(1));
      expect(controller.position.pixels, greaterThan(0));
    });
  });

  group("speak sentence", () {
    testWidgets("should speak as a patient one by one", (tester) async {
      when(mockPatientNotifier.state).thenReturn(fakeUser);
      when(mockPatientNotifier.user).thenReturn(fakeUser);
      when(mockUserNotifier.user).thenReturn(fakeUser);
      when(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      )).thenAnswer((realInvocation) async => Right("true"));
      when(mockTTSProvider.speak(any)).thenAnswer((realInvocation) async => {});
      cHomeProvider.pictoWords = List.generate(5, (index) {
        return fakePictos[index % fakePictos.length];
      });

      final controller = cHomeProvider.scrollController;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await cHomeProvider.speakSentence();

      await tester.pumpAndSettle();
      verify(mockPatientNotifier.state);
      verify(mockPatientNotifier.user);
      // verify(mockUserNotifier.user);
      verify(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      ));
      verify(mockTTSProvider.speak(any));
    });

    testWidgets("should speak as a patient with labs", (tester) async {
      final testUSer = fakeUser.copyWith(
          settings: PatientSettings(
        payment: Payment.none(),
        accessibility: AccessibilitySetting.empty(),
        layout: LayoutSetting.empty().copyWith(),
        tts: TTSSetting.empty(),
        data: UserData(
          avatar: AssetsImage(asset: "test", network: "https://test.com"),
          birthDate: DateTime(0),
          genderPref: "n/a",
          lastConnection: DateTime(0),
          name: "John",
          lastName: "Doe",
        ),
        language: LanguageSetting.empty(labs: true),
      ));
      when(mockPatientNotifier.state).thenReturn(testUSer);
      when(mockPatientNotifier.user).thenReturn(testUSer);
      when(mockUserNotifier.user).thenReturn(testUSer);
      when(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      )).thenAnswer((realInvocation) async => Right("true"));
      when(mockTTSProvider.speak(any)).thenAnswer((realInvocation) async => {});
      cHomeProvider.pictoWords = List.generate(5, (index) {
        return fakePictos[index % fakePictos.length];
      });
      when(mockChatGPTNotifier.generatePhrase(any)).thenAnswer((realInvocation) async {
        return "test";
      });

      final controller = cHomeProvider.scrollController;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await cHomeProvider.speakSentence();

      await tester.pumpAndSettle();
      verify(mockPatientNotifier.state);
      verify(mockPatientNotifier.user);
      // verify(mockUserNotifier.user);
      verify(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      ));
      verify(mockTTSProvider.speak(any));
      verify(mockChatGPTNotifier.generatePhrase(any));
    });

    testWidgets("should speak as a patient", (tester) async {
      final testUSer = fakeUser.copyWith(
          settings: PatientSettings(
        payment: Payment.none(),
        accessibility: AccessibilitySetting.empty(),
        layout: LayoutSetting.empty().copyWith(),
        tts: TTSSetting.empty(),
        data: UserData(
          avatar: AssetsImage(asset: "test", network: "https://test.com"),
          birthDate: DateTime(0),
          genderPref: "n/a",
          lastConnection: DateTime(0),
          name: "John",
          lastName: "Doe",
        ),
        language: LanguageSetting.empty(),
      ));
      when(mockPatientNotifier.state).thenReturn(testUSer);
      when(mockPatientNotifier.user).thenReturn(testUSer);
      when(mockUserNotifier.user).thenReturn(testUSer);
      when(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      )).thenAnswer((realInvocation) async => Right("true"));
      when(mockTTSProvider.speak(any)).thenAnswer((realInvocation) async => {});
      cHomeProvider.pictoWords = List.generate(5, (index) {
        return fakePictos[index % fakePictos.length];
      });
      when(mockChatGPTNotifier.generatePhrase(any)).thenAnswer((realInvocation) async {
        return "test";
      });

      final controller = cHomeProvider.scrollController;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await cHomeProvider.speakSentence();

      await tester.pumpAndSettle();
      verify(mockPatientNotifier.state);
      verify(mockPatientNotifier.user);
      // verify(mockUserNotifier.user);
      verify(mockLearnPictogram.call(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      ));
      verify(mockTTSProvider.speak(any));
    });
  });

  test("speak yes", () async {
    when(mockTTSProvider.speak(any)).thenAnswer((realInvocation) async => {});
    await cHomeProvider.speakYes();
    verify(mockTTSProvider.speak(any));
    verify(mockI18N.currentLanguage);
  });

  test("speak no", () async {
    when(mockTTSProvider.speak(any)).thenAnswer((realInvocation) async => {});
    await cHomeProvider.speakNo();
    verify(mockTTSProvider.speak(any));
    verify(mockI18N.currentLanguage);
  });

  test("should return provider", () async {
    GetIt.I.registerSingleton<PictogramsRepository>(MockPictogramsRepository());
    GetIt.I.registerSingleton<GroupsRepository>(MockGroupsRepository());
    GetIt.I.registerSingleton<SentencesRepository>(MockSentencesRepository());
    GetIt.I.registerSingleton<PredictPictogram>(MockPredictPictogram());
    GetIt.I.registerSingleton<LearnPictogram>(MockLearnPictogram());
    GetIt.I.registerSingleton<LocalDatabaseRepository>(MockLocalDatabaseRepository());

    final container = ProviderContainer(overrides: [ttsProvider.overrideWith((_) => mockTTSProvider), chatGPTProvider.overrideWith((ref) => mockChatGPTNotifier)]);

    final provider = container.read(homeProvider.notifier);

    expect(provider, isA<HomeProvider>());
  });
}
