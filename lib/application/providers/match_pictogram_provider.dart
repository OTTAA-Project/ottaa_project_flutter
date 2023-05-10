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
  List<bool> hideFlags = List.filled(8, true, growable: true);
  List<bool> rightOrWrong = List.filled(8, true, growable: true);

  int pick1 = 99;
  int pick2 = 99;
  late Picto picto1;
  late Picto picto2;
  int correctCounter = 0;
  bool showResult = false;
  bool trueOrFalse = false;

  Future<void> checkAnswerMatchPicto({required int index, required Picto picto}) async {
    _tts.speak(picto.text);
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
        hideFlags[pick1] = false;
        hideFlags[pick2] = false;
        trueOrFalse = true;
        rightOrWrong[pick1] = true;
        rightOrWrong[pick2] = true;
        notifyListeners();
        await _gamesProvider.playClickSounds(assetName: 'yay');
        _gamesProvider.correctScore++;
        _gamesProvider.streak++;
        correctCounter++;
        pick1 = 99;
        pick2 = 99;
        showResult = false;
        notifyListeners();
        if (correctCounter == _gamesProvider.difficultyLevel + 2) {
          if (_gamesProvider.correctScore >= 10 && _gamesProvider.difficultyLevel < 1) {
            _gamesProvider.difficultyLevel++;
          }
          if (_gamesProvider.correctScore >= 20 && _gamesProvider.difficultyLevel < 2) {
            _gamesProvider.difficultyLevel++;
          }
          await Future.delayed(const Duration(milliseconds: 1500));
          correctCounter = 0;
          hideFlags = List.filled(8, true, growable: true);
          rightOrWrong = List.filled(8, true, growable: true);
          show = List.filled(8, false, growable: true);
          pick1 = 99;
          pick2 = 99;
          await _gamesProvider.createRandomForGameMP();
        }
      } else {
        showResult = true;
        trueOrFalse = false;
        hideFlags[pick1] = false;
        hideFlags[pick2] = false;
        rightOrWrong[pick1] = false;
        rightOrWrong[pick2] = false;
        notifyListeners();
        _gamesProvider.incorrectScore++;
        await _gamesProvider.playClickSounds(assetName: 'ohoh');
        if (_gamesProvider.correctScore == 9) {
          _gamesProvider.difficultyLevel--;
        }
        if (_gamesProvider.correctScore == 19) {
          _gamesProvider.difficultyLevel--;
        }
        _gamesProvider.streak = 0;
        showResult = false;

        ///kind of act as a reset for whole thing
        hideFlags[pick1] = true;
        hideFlags[pick2] = true;
        show[pick1] = false;
        show[pick2] = false;
        pick1 = 99;
        pick2 = 99;
        notifyListeners();
      }
    }
  }

  Future<int> check({required String text, bool top = true}) async {
    int i = 0;
    if (top) {
      _gamesProvider.topPositionsMP.forEach((key, value) {
        if (value.text == text) {
          return;
        }
        i++;
      });
      return i;
    } else {
      _gamesProvider.bottomPositionsMP.forEach((key, value) {
        if (value.text == text) {
          return;
        }
        i++;
      });
      return i;
    }
  }

  MatchPictogramProvider(this._gamesProvider, this._tts);
}

final matchPictogramProvider = ChangeNotifierProvider<MatchPictogramProvider>((ref) {
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return MatchPictogramProvider(gamesProvider, tts);
});
