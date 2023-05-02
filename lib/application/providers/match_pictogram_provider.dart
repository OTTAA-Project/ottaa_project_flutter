import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

class MatchPictogramProvider extends ChangeNotifier {
  final UserNotifier _userNotifier;
  final PatientNotifier _patientNotifier;
  final ChatGPTRepository _chatGPTRepository;
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
      return;
    } else {
      pick2 = index;
      if()
    }
  }

  MatchPictogramProvider(this._userNotifier, this._patientNotifier, this._chatGPTRepository, this._gamesProvider, this._tts);
}

final matchPictogramProvider = ChangeNotifierProvider.autoDispose((ref) {
  final userState = ref.watch(userNotifier.notifier);
  final patientState = ref.watch(patientNotifier.notifier);
  final chatGPTRepository = GetIt.I<ChatGPTRepository>();
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return MatchPictogramProvider(userState, patientState, chatGPTRepository, gamesProvider, tts);
});
