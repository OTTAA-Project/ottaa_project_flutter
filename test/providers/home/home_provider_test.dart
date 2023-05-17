import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([TTSProvider, UserNotifier, PatientNotifier, SentencesRepository, GroupsRepository, PictogramsRepository, PredictPictogram, LearnPictogram, ChatGPTNotifier])
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

  late HomeProvider homeProvider;

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

    homeProvider = HomeProvider(mockPictogramsRepository, mockGroupsRepository, mockSentencesRepository, mockTTSProvider, mockPatientNotifier, mockPredictPictogram, mockLearnPictogram, mockUserNotifier, mockChatGPTNotifier);
  });

  testWidgets('should update currentTabGroup and trigger notifyListeners', (WidgetTester tester) async {
    const expectedGroup = 'group';

    await tester.pumpWidget(
      MaterialApp(
        home: ListView(
          controller: homeProvider.pictoTabsScrollController,
          children: const <Widget>[],
        ),
      ),
    );

    homeProvider.setCurrentGroup(expectedGroup);

    await tester.pump();

    expect(homeProvider.currentTabGroup, expectedGroup);
    expect(() => homeProvider.notify(), isA<void>());
  });

  test('should call notifyListeners', () {
    homeProvider.notify();

    expect(() => homeProvider.notify(), isA<void>());
  });

  group('fetchMostUsedSentences', () async {
    test('should update mostUsedSentences and trigger notifyListeners', () async {
      // Arrange
      final myClass = MyClass();
      final mockSentencesService = MockSentencesService();
      final mockResponse = Right<List<Sentence>>([Sentence()]); // Mock response

      when(mockSentencesService.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      await myClass.fetchMostUsedSentences();

      // Assert
      expect(myClass.mostUsedSentences, mockResponse.right);
      verify(myClass.notifyListeners()).called(1);
      // Add more assertions as needed to test the behavior or state changes
    });

    test('should update mostUsedSentences to empty list when fetchSentences returns an error', () async {
      // Arrange
      final myClass = MyClass();
      final mockSentencesService = MockSentencesService();
      final mockResponse = Left<SentenceError>(SentenceError()); // Mock error response

      when(mockSentencesService.fetchSentences(
        language: anyNamed('language'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      await myClass.fetchMostUsedSentences();

      // Assert
      expect(myClass.mostUsedSentences, isEmpty);
      verify(myClass.notifyListeners()).called(1);
      // Add more assertions as needed to test the behavior or state changes
    });
  });
}
