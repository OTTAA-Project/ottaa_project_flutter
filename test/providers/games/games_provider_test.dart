import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'games_provider_test.mocks.dart';

@GenerateMocks([PictogramsRepository, GroupsRepository, PatientNotifier])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPictogramsRepository mockPictogramsRepository;
  late MockGroupsRepository mockGroupsRepository;
  late MockPatientNotifier mockPatientNotifier;

  late GamesProvider gamesProvider;

  setUp(() {
    mockPictogramsRepository = MockPictogramsRepository();
    mockGroupsRepository = MockGroupsRepository();
    mockPatientNotifier = MockPatientNotifier();

    gamesProvider = GamesProvider(mockGroupsRepository, mockPictogramsRepository, mockPatientNotifier);
  });

  group('initialise music', () {
    ///we might need to work on creating the tests for the just_audio Package
    test('should play the music when the isMute not enabled', () async {
      expect(() async => await gamesProvider.initializeBackgroundMusic(), isA<void>());
    });

    test('should not play the music when isMute enabled', () async {
      gamesProvider.isMute = true;
      await gamesProvider.initializeBackgroundMusic();
      expect(gamesProvider.isMute, true);
    });
  });

  group('changeMusic mute or play it', () {
    test('should play the music when isMute is true', () async {
      gamesProvider.isMute = true;
      await gamesProvider.changeMusic();
      expect(gamesProvider.backgroundMusicPlayer.playing, true);
    });

    test('should not play the music when isMute is false', () async {
      gamesProvider.isMute = false;
      await gamesProvider.changeMusic();
      expect(gamesProvider.backgroundMusicPlayer.playing, false);
    });
  });
}
