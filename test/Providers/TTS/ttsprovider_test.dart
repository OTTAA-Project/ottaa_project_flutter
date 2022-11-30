import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

import 'ttsprovider_test.mocks.dart';


@GenerateMocks([TTSProvider,TTSRepository])
void main(){
  late MockTTSProvider mockTTSProvider;
  late MockTTSRepository mockTTSRepository;
  late TTSProvider ttsProvider;
  setUp((){
    mockTTSRepository = MockTTSRepository();
    mockTTSProvider = MockTTSProvider();
    ttsProvider = TTSProvider(mockTTSRepository);
  });

  group('TTS Provider', () {
    test('Speak tts provider', () async {
      await ttsProvider.speak('Hello');
      verify(ttsProvider.speak('Hello')).called(1);
    });
  });

}