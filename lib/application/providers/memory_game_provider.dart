import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/memory_picto_widget.dart';

class MemoryGameNotifier extends ChangeNotifier {
  final GamesProvider _gamesProvider;

  List<Picto> pictos = [];

  List<int> openedPictos = [];
  List<int> matchedPictos = [];
  List<int> rightPictos = [];

  List<AnimationController> controllers = [];

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

    openedPictos.clear();
    matchedPictos.clear();
    rightPictos.clear();
    notifyListeners();
  }

  void addAnimationController(AnimationController controller, int index) {
    controllers.add(controller);
  }

  void openPicto(int index) async {
    if (matchedPictos.contains(index) || openedPictos.length == 2 || openedPictos.contains(index)) return;

    if (openedPictos.length > 2) {
      notifyListeners();
      return;
    }


    openedPictos.add(index);
    controllers[index].reverse();

    if (openedPictos.length == 2) {
      bool isRightPictos = pictos[openedPictos[0]].id == pictos[openedPictos[1]].id;

      await _gamesProvider.playClickSounds(assetName: isRightPictos ? "yay" : "ohoh");

      if (isRightPictos) {
        rightPictos.addAll(openedPictos);
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
          controllers[openedPictos[0]].reverse();
          controllers[openedPictos[1]].reverse();
        }

        rightPictos.clear();
        openedPictos.clear();

        if (matchedPictos.length == pictos.length) {
          createRandomPictos();
        }
        notifyListeners();
      });
    }

    notifyListeners();
  }

  void clear() {
    pictos.clear();
    openedPictos.clear();
    rightPictos.clear();
    matchedPictos.clear();
    controllers.clear();
  }
}

final memoryGameProvider = ChangeNotifierProvider<MemoryGameNotifier>((ref) {
  final gameNotifier = ref.watch(gameProvider);
  return MemoryGameNotifier(gameNotifier);
});
