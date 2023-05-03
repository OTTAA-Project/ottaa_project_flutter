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
  late Picto picto1;
  late Picto picto2;
  int correctCounter = 0;
  bool showResult = false;
  bool trueOrFalse = false;

  Future<void> checkAnswerMatchPicto({required int index, required Picto picto}) async {
    if (pick1 == 99) {
      pick1 = index;
      picto1 = picto;
      show[pick1] = true;
      notifyListeners();
    } else {
      pick2 = index;
      picto2 = picto;
      show[pick2] = true;

      ///check if both matches or not

      if (picto1.text == picto2.text) {
        showResult = true;
        notifyListeners();
        trueOrFalse = true;
        await _gamesProvider.playClickSounds(assetName: 'yay');
        _gamesProvider.correctScore++;
        _gamesProvider.streak++;
        correctCounter++;
        pick1 = 99;
        pick2 = 99;
        showResult = false;
        await Future.delayed(const Duration(seconds: 1));
        notifyListeners();
        if (_gamesProvider.correctScore == 10) {
          _gamesProvider.difficultyLevel++;
        }
        if (_gamesProvider.correctScore == 20) {
          _gamesProvider.difficultyLevel++;
        }
        if (correctCounter == _gamesProvider.difficultyLevel + 2) {
          correctCounter = 0;
          pick1 = 99;
          pick2 = 99;
          await Future.delayed(const Duration(seconds: 1));
          await _gamesProvider.createRandomForGameMP();
        }
      } else {
        showResult = true;
        notifyListeners();
        trueOrFalse = false;
        _gamesProvider.incorrectScore++;
        await _gamesProvider.playClickSounds(assetName: 'ohoh');
        await Future.delayed(const Duration(seconds: 1));
        if (_gamesProvider.correctScore == 9) {
          _gamesProvider.difficultyLevel--;
        }
        if (_gamesProvider.correctScore == 19) {
          _gamesProvider.difficultyLevel--;
        }
        _gamesProvider.streak = 0;
        showResult = false;

        ///kind of act as a reset for whole thing
        show[pick1] = false;
        show[pick2] = false;
        pick1 = 99;
        pick2 = 99;
        notifyListeners();
      }
    }
  }

  MatchPictogramProvider(this._gamesProvider, this._tts);
}

final matchPictogramProvider = ChangeNotifierProvider<MatchPictogramProvider>((ref) {
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return MatchPictogramProvider(gamesProvider, tts);
});
