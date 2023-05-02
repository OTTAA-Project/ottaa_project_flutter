import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

class MatchPictogramProvider extends ChangeNotifier {
  final GamesProvider _gamesProvider;
  final TTSProvider _tts;
  List<Picto> upperPictos = [];
  List<Picto> lowerPictos = [];
  List<bool> show = List.filled(8, false, growable: true);
  int pick1 = 99;
  int pick2 = 99;

  Future<void> checkAnswerMatchPicto({required int index}) async {
    if (pick1 == 99) {
      pick1 = index;
      show[pick1] = true;
    } else {
      show[pick2] = true;
      pick2 = index;
      bool match = false;

      ///check if both matches or not

      if (match) {
        _gamesProvider.playClickSounds(assetName: 'yay');
      } else {
        show[pick1] = false;
        show[pick2] = false;
        _gamesProvider.playClickSounds(assetName: 'ohoh');
      }

      ///kind of act as a reset for whole thing
      pick1 = 99;
      pick2 = 99;
    }
    notifyListeners();
  }

  void getValuesFromPosition({required int pos}) async {
    switch (pos) {
      case 0:

      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
    }
  }

  MatchPictogramProvider(this._gamesProvider, this._tts);
}

final matchPictogramProvider = ChangeNotifierProvider<MatchPictogramProvider>((ref) {
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return MatchPictogramProvider(gamesProvider, tts);
});
