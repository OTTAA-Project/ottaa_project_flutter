import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/match_pictogram_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

import 'chat_gpt_game_provider_test.mocks.dart';

@GenerateMocks([TTSProvider])
@GenerateNiceMocks([MockSpec<GamesProvider>()])
Future<void> main() async {
  late MockGamesProvider mockGamesProvider;
  late MockTTSProvider mockTTSProvider;
  late MatchPictogramProvider matchPictogramProvider;

  late Map<int, Picto> topPictos;
  late Map<int, Picto> bottomPictos;

  setUp(() {
    mockGamesProvider = MockGamesProvider();
    mockTTSProvider = MockTTSProvider();
    matchPictogramProvider = MatchPictogramProvider(mockGamesProvider, mockTTSProvider);
    topPictos = {
      0: Picto(id: '0', type: 1, text: 'example1', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }),
      1: Picto(id: '1', type: 1, text: 'example2', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MEDIODIA', 'TARDE']
      }),
      2: Picto(id: '2', type: 1, text: 'example3', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {'hour': []}),
      3: Picto(id: '3', type: 1, text: 'example4', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['NOCHE']
      }),
    };
    bottomPictos = {
      0: Picto(id: '4', type: 1, text: 'example5', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MANANA']
      }),
      1: Picto(id: '5', type: 1, text: 'example6', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['MEDIODIA', 'TARDE']
      }),
      2: Picto(id: '6', type: 1, text: 'example7', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {'hour': []}),
      3: Picto(id: '7', type: 1, text: 'example8', resource: AssetsImage(asset: 'TestAsset', network: 'TestNetwork'), tags: {
        'hour': ['NOCHE']
      }),
    };
  });

  test('returns the index of the icto from the 2 lists', () async {
    when(mockGamesProvider.topPositionsMP).thenAnswer((realInvocation) => topPictos);
    when(mockGamesProvider.bottomPositionsMP).thenAnswer((realInvocation) => bottomPictos);
    mockGamesProvider.topPositionsMP = topPictos;
    mockGamesProvider.bottomPositionsMP = bottomPictos;
    final result1 = await matchPictogramProvider.check(text: 'example4', top: true);
    expect(result1, 3);
  });
}
