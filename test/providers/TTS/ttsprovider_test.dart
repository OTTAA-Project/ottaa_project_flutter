import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/voices_model.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

import 'ttsprovider_test.mocks.dart';

@GenerateMocks([TTSRepository])
void main() {
  late MockTTSRepository mockTTSRepository;
  late TTSProvider ttsProvider;
  late List<Voices> fakeVoices;

  setUp(() {
    mockTTSRepository = MockTTSRepository();
    fakeVoices = [
      Voices(name: 'Test1', locale: 'es_AR'),
      Voices(name: 'Test2', locale: 'es_AR'),
      Voices(name: 'Test2', locale: 'es_AR'),
    ];
    ttsProvider = TTSProvider(mockTTSRepository);
  });

  group('TTS Provider', () {
    test('Speak tts provider', () async {
      await ttsProvider.speak('Hello');
      verify(ttsProvider.speak('Hello')).called(1);
    });

    test('fetch the available voices from the tts', () async {
      when(mockTTSRepository.fetchVoices()).thenAnswer((realInvocation) async => fakeVoices);

      final response = await ttsProvider.fetchVoices('es_AR');

      expect(response, isA<List<Voices>>());
    });

    test('should change the tts speed', () async {
      await ttsProvider.changeVoiceSpeed(00);
      verify(ttsProvider.changeVoiceSpeed(00)).called(1);
    });

    test('should change custom tts status', () async {
      await ttsProvider.changeCustomTTs(false);
      verify(ttsProvider.changeCustomTTs(false)).called(1);
    });

    test('should change tts voice', () async {
      await ttsProvider.changeTTSVoice('test');
      verify(ttsProvider.changeTTSVoice('test')).called(1);
    });

    test('should stop tts while speaking', () async {
      await ttsProvider.ttsStop();
      verify(ttsProvider.ttsStop()).called(1);
    });
  });
}
