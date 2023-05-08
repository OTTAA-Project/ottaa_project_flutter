import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

class MemoryGameNotifier extends ChangeNotifier {
  final GamesProvider _gamesProvider;

  List<Picto> pictos = [];

  List<int> openedPictos = [];

  List<int> matchedPictos = [];

  bool? isRight;

  MemoryGameNotifier(this._gamesProvider);

  void createRandomPictos() {
    pictos.clear();
    List<int> numbers = [];
    Random random = Random();
    while (numbers.length < _gamesProvider.difficultyLevel + 2) {
      int num = random.nextInt(_gamesProvider.selectedPicts.length - 1);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }

    for (var element in numbers) {
      pictos.add(_gamesProvider.selectedPicts[element]);
      pictos.add(_gamesProvider.selectedPicts[element]);
    }

    pictos.shuffle(random);

    notifyListeners();
  }

  void openPicto(int index) {
    Picto picto = pictos[index];
    print(index);

    if (openedPictos.length >= 2) {
      //TODO: There should not happen
      print("XDD");
      openedPictos.clear();
      notifyListeners();
      return;
    }

    if (openedPictos.contains(index)) {
      return;
    }

    openedPictos.add(index);

    if (openedPictos.length == 2) {
      //Check for game!
      bool isRightPictos = pictos[openedPictos[0]].id == pictos[openedPictos[1]].id;

      isRight = isRightPictos;

      _gamesProvider.playClickSounds(assetName: isRightPictos ? "yay" : "ohoh");
      if (isRightPictos) {
        matchedPictos.addAll(openedPictos);
      }
      Future.delayed(const Duration(seconds: 2), () {
        if (isRightPictos) {
          _gamesProvider.correctScore++;
          _gamesProvider.streak++;

          if (_gamesProvider.correctScore >= 10 && _gamesProvider.difficultyLevel < 1) {
            _gamesProvider.difficultyLevel++;
          } else if (_gamesProvider.correctScore >= 20 && _gamesProvider.difficultyLevel < 2) {
            _gamesProvider.difficultyLevel++;
          }
        } else {
          if (_gamesProvider.streak == 0) {
            _gamesProvider.incorrectScore++;
          } else {
            _gamesProvider.streak = 0;
          }
        }
        isRight = null;
        openedPictos.clear();
        notifyListeners();
      });
    }

    notifyListeners();
  }

  void clear() {
    pictos.clear();
    openedPictos.clear();
    isRight = null;
  }
}

final memoryGameProvider = ChangeNotifierProvider<MemoryGameNotifier>((ref) {
  final gameNotifier = ref.watch(gameProvider);
  return MemoryGameNotifier(gameNotifier);
});
