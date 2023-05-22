import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/service/tts_service.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'tts_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<I18N>(), MockSpec<FlutterTts>()])
void main() {
  late MockI18N mockI18N;
  late MockFlutterTts mockFlutterTts;
  late TTSRepository ttsRepository;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    MethodChannel methodChannel = const MethodChannel('flutter_tts');
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMethodCallHandler(
      methodChannel,
      (message) {
        switch (message.method) {
          case "getVoices":
            return Future.value([]);
          case "getLanguages":
            return Future.value([]);
          case "speak.onStart":
            return Future.value("Speaking!");

          /// ***Android supported only***
          case "tts.init":
            return Future.value("Initialized!");
          case "synth.onStart":
            return Future.value("Synth on start!");
          case "speak.onComplete":
            return Future.value("speak on complete!");
          case "synth.onComplete":
            return Future.value("synth on complete!");
          case "speak.onPause":
            return Future.value("speak on pause!");
          case "speak.onContinue":
            return Future.value("speak on continue!");
          case "speak.onCancel":
            return Future.value("speak on cancel!");
          case "speak.onError":
            return Future.value("speak on error!");
          case 'speak.onProgress':
            return Future.value("speak on progress!");
          case "synth.onError":
            return Future.value("synth on error!");
          default:
            return Future.value("wrong method channel!");
        }
      },
    );
    WidgetsFlutterBinding.ensureInitialized();
    mockI18N = MockI18N();
    mockFlutterTts = MockFlutterTts();
    when(mockFlutterTts.getVoices).thenAnswer(
      (_) async => ([
        {"name": "en_US", "locale": "en_US"}
      ]),
    );
    when(mockFlutterTts.getLanguages).thenAnswer(
      (_) async => (["en_US"]),
    );
    when(mockFlutterTts.setPitch(any)).thenAnswer((realInvocation) async => {});

    when(mockFlutterTts.setSpeechRate(any)).thenAnswer((realInvocation) async => {});

    when(mockFlutterTts.setVolume(any)).thenAnswer((realInvocation) async => {});

    when(mockFlutterTts.setLanguage(any)).thenAnswer((realInvocation) async => {});

    when(mockFlutterTts.awaitSpeakCompletion(any)).thenAnswer((realInvocation) async => {});

    when(mockI18N.currentLocale).thenReturn(const Locale("en_US"));
    ttsRepository = TTSService(mockI18N, tts: mockFlutterTts);
  });

  group('TTS Service', () {
    test('Speak tts service', () async {
      await ttsRepository.speak('Hello');
      verify(mockFlutterTts.speak('Hello')).called(1);
    });

    test('Fetch voices tts service', () async {
      when(mockI18N.currentLocale).thenReturn(const Locale("en_US"));
      await ttsRepository.fetchVoices();
      verify(mockFlutterTts.getVoices).called(2);
    });

    test('Change voice speed tts service', () async {
      await ttsRepository.changeVoiceSpeed(0.5);
      expect(ttsRepository.speechRate, 0.5);
    });

    test('Change custom tts tts service', () async {
      await ttsRepository.changeCustomTTs(true);
      expect(ttsRepository.customTTSEnable, true);
    });

    test('Change tts voice tts service', () async {
      await ttsRepository.changeTTSVoice('en_US');
      expect(ttsRepository.locale, "en_US");
      expect(ttsRepository.name, "en_US");
    });

    test('Stop tts service', () async {
      await ttsRepository.ttsStop();
      verify(mockFlutterTts.stop()).called(1);
    });

    test('Speak with custom ts', () async {
      await ttsRepository.changeCustomTTs(true);
      await ttsRepository.speak('Hello');
      verify(mockFlutterTts.setVoice({"name": ttsRepository.name, "locale": ttsRepository.locale})).called(1);
      verify(mockFlutterTts.setLanguage(ttsRepository.language)).called(2);
      verify(mockFlutterTts.setVolume(1.0)).called(2);
      verify(mockFlutterTts.setSpeechRate(ttsRepository.speechRate)).called(2);
      verify(mockFlutterTts.setPitch(ttsRepository.pitch)).called(2);

      verify(mockFlutterTts.speak('Hello')).called(1);

      expect(ttsRepository.language, mockI18N.currentLocale.toString());
    });
  });
}
