import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

class MemoryGameNotifier extends ChangeNotifier {
  final GamesProvider _gamesProvider;

  List<Picto> pictos = [];

  List<int> openedPictos = [];

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

  void openPicto(int index, AnimationController controller) {
    Picto picto = pictos[index];
    print(openedPictos);

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

    controller.forward(from: 1);

    if (openedPictos.length == 2) {
      //Check for game!
    }

    notifyListeners();
  }
}

final memoryGameProvider = ChangeNotifierProvider<MemoryGameNotifier>((ref) {
  final gameNotifier = ref.watch(gameProvider);
  return MemoryGameNotifier(gameNotifier);
});
