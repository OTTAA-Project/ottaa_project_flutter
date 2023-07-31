import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

class ChatGptGameProvider extends ChangeNotifier {
  final ChatGPTRepository _chatGPTServices;
  String generatedStory = '';
  int sentencePhase = 0;
  List<Picto> gptPictos = [];
  final GamesProvider _gamesProvider;
  final PictogramsRepository _pictogramsService;
  final UserNotifier userState;
  final TTSProvider _tts;
  List<String> gptBoards = [];
  bool isBoard = true;
  ScrollController boardScrollController = ScrollController();
  ScrollController pictoScrollController = ScrollController();
  List<Picto> chatGptPictos = [];
  bool btnText = false;
  bool isStoryFetched = false;
  final Map<String, String> pictosTranslations = {};
  final List<String> nounBoards = ['0geft4arn_A8kL-rfUPYc', 'WZYuZd331Hm5gHXJtUmBN', 'puda9fUGjqvm9oSM6CpTk', 'xjfPlDs-AcFV9LCyY-v9j'];
  final List<String> modifierBoards = ['7ngCuvmAnM_7ygpFQgLpk', '7w5ACMFdOCTkBrS911MA1', 'berI6X2_pAVCNOrcHAL6y'];
  final List<String> actionBoards = ['PYTnUqCLwAbngR2Ozroc2'];
  final List<String> placeBoards = ['y545pM8pvB3WgukIac6NT'];

  ChatGptGameProvider(this._chatGPTServices, this._gamesProvider, this._tts, this._pictogramsService, this.userState);

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

    if (currentPosition >= boardScrollController.position.maxScrollExtent + 96) return;

    boardScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollUpPictos() {
    int currentPosition = pictoScrollController.position.pixels.toInt();

    if (currentPosition == 0) return;

    pictoScrollController.animateTo(
      currentPosition - 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollDownPictos() {
    int currentPosition = pictoScrollController.position.pixels.toInt();

    if (currentPosition >= (pictoScrollController.position.maxScrollExtent + 96)) return;

    pictoScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void notify() {
    notifyListeners();
  }

  Future<void> createStory() async {
    final String prompt = 'game.prompt'.trl;
    final finalPrompt = '$prompt ${gptPictos[0].text}, ${gptPictos[1].text}, ${gptPictos[2].text}, ${gptPictos[3].text}.';
    final res = await _chatGPTServices.getGPTStory(prompt: finalPrompt);
    if (res.isRight) {
      isStoryFetched = true;
      generatedStory = res.right;
    } else {
      isStoryFetched = false;
    }
    notifyListeners();
  }

  Future<void> fetchGptPictos({required String id}) async {
    List<Picto> picts = [];
    final gro = _gamesProvider.groups[id];
    int i = 0;
    for (var e in gro!.relations) {
      picts.add(
        _gamesProvider.pictograms[e.id]!,
      );
      picts[i].text = pictosTranslations[e.id] ?? picts[i].text;
      i++;
    }
    chatGptPictos.clear();
    chatGptPictos.addAll(picts);
  }

  Future<void> loadTranslations() async {
    pictosTranslations.clear();
    final translations = await _pictogramsService.loadTranslations(language: userState.user!.settings.language.language);
    pictosTranslations.addAll(translations);
  }

  Future<void> speakStory() async {
    if (_gamesProvider.backgroundMusicPlayer.playing) {
      _gamesProvider.backgroundMusicPlayer.pause();
    }
    _tts.speak(generatedStory);
  }

  void resetStoryGame() {
    gptPictos.clear();
    gptBoards = [];
    sentencePhase = 0;
    notifyListeners();
  }

  Future<void> stopTTS() async {
    await _tts.ttsStop();
  }
}

final chatGptGameProvider = ChangeNotifierProvider.autoDispose((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final userState = ref.watch(userProvider);
  final chatGpt = GetIt.I<ChatGPTRepository>();
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return ChatGptGameProvider(chatGpt, gamesProvider, tts, pictogramService, userState);
});
