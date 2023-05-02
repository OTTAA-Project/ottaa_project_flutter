import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

class WhatsThePictoProvider extends ChangeNotifier {
  final UserNotifier _userNotifier;
  final PatientNotifier _patientNotifier;
  final ChatGPTRepository _chatGPTRepository;
  final GamesProvider _gamesProvider;
  final TTSProvider _tts;

  List<bool> pictoShowWhatsThePict = [false, false, false, false];
  int selectedPicto = 0;

  ScrollController boardScrollController = ScrollController();
  bool showText = false;

  Future<void> checkAnswerWhatThePicto({required int index}) async {
    //todo: show the text that it is correct
    selectedPicto = index;
    pictoShowWhatsThePict[index] = !pictoShowWhatsThePict[index];
    showText = !showText;
    notifyListeners();

    if (_gamesProvider.correctPictoWTP == index) {
      await _gamesProvider.playClickSounds(assetName: 'yay');
    } else {
      await _gamesProvider.playClickSounds(assetName: 'ohoh');
    }
    await Future.delayed(
      const Duration(seconds: 1),
    );
    //todo: remove the text around
    pictoShowWhatsThePict[index] = !pictoShowWhatsThePict[index];
    showText = !showText;
    // notifyListeners();
    //todo: create the new question
    if (_gamesProvider.correctPictoWTP == index) {
      _gamesProvider.correctScore++;
      if (_gamesProvider.correctScore == 10) {
        _gamesProvider.difficultyLevel++;
        notifyListeners();
      }
      if (_gamesProvider.correctScore == 20) {
        _gamesProvider.difficultyLevel++;
        notifyListeners();
      }
      _gamesProvider.streak++;
      await _gamesProvider.createRandomForGameWTP();
      speakNameWhatsThePicto();
    } else {
      if (_gamesProvider.correctScore == 0) {
        _gamesProvider.correctScore = 0;
      } else {
        _gamesProvider.incorrectScore++;
      }
      if (_gamesProvider.correctScore == 9) {
        _gamesProvider.difficultyLevel--;
      }
      if (_gamesProvider.correctScore == 19) {
        _gamesProvider.difficultyLevel--;
      }
      _gamesProvider.streak = 0;
    }
    _gamesProvider.clicksPlayer.stop();

    // notifyListeners();
  }

  WhatsThePictoProvider(this._userNotifier, this._patientNotifier, this._chatGPTRepository, this._gamesProvider, this._tts);

  void speakNameWhatsThePicto() async {
    await _tts.speak('game.speak_what'.trlf({'name': _gamesProvider.gamePictsWTP[_gamesProvider.correctPictoWTP].text}));
  }

  void notify() {
    notifyListeners();
  }

  void scrollUpBoards() {
    int currentPosition = boardScrollController.position.pixels.toInt();

    if (currentPosition == 0) return;

    boardScrollController.animateTo(
      currentPosition - 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollDownBoards() {
    int currentPosition = boardScrollController.position.pixels.toInt();

    if (currentPosition >= boardScrollController.position.maxScrollExtent) return;

    boardScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

final whatsThePictoProvider = ChangeNotifierProvider<WhatsThePictoProvider>((ref) {
  final userState = ref.watch(userNotifier.notifier);
  final patientState = ref.watch(patientNotifier.notifier);
  final chatGPTRepository = GetIt.I<ChatGPTRepository>();
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return WhatsThePictoProvider(userState, patientState, chatGPTRepository, gamesProvider, tts);
});
