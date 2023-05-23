import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/service/tts_service.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'tts_service_test.mocks.dart';

// @GenerateMocks([I18N])
@GenerateNiceMocks([MockSpec<I18N>()])
void main() {
  late MockI18N mockI18N;
  late TTSRepository ttsRepository;
  setUp(() {
    // MethodChannel methodChannel = const MethodChannel('flutter_tts');
    // TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMethodCallHandler(
    //   methodChannel,
    //   (message) {
    //     switch (message.method) {
    //       case "speak.onStart":
    //         return Future.value("Speaking!");

    //       /// ***Android supported only***
    //       case "tts.init":
    //         return Future.value("Initialized!");
    //       case "synth.onStart":
    //         return Future.value("Synth on start!");
    //       case "speak.onComplete":
    //         return Future.value("speak on complete!");
    //       case "synth.onComplete":
    //         return Future.value("synth on complete!");
    //       case "speak.onPause":
    //         return Future.value("speak on pause!");
    //       case "speak.onContinue":
    //         return Future.value("speak on continue!");
    //       case "speak.onCancel":
    //         return Future.value("speak on cancel!");
    //       case "speak.onError":
    //         return Future.value("speak on error!");
    //       case 'speak.onProgress':
    //         return Future.value("speak on progress!");
    //       case "synth.onError":
    //         return Future.value("synth on error!");
    //       default:
    //         return Future.value("wrong method channel!");
    //     }
    //   },
    // );
    WidgetsFlutterBinding.ensureInitialized();
    mockI18N = MockI18N();
    mockI18N.currentLanguage = (TranslationTree(const Locale("en_US")));

    ttsRepository = TTSService(mockI18N);
  });

  group('TTS Service', () {
    test('Speak tts service', () async {
      await ttsRepository.speak('Hello');
      verify(ttsRepository.speak('Hello')).called(1);
    });
  });
}
