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

class ChatGPTNotifier extends ChangeNotifier {
  final UserNotifier _userNotifier;
  final PatientNotifier _patientNotifier;
  final ChatGPTRepository _chatGPTRepository;
  final GamesProvider _gamesProvider;
  final TTSProvider _tts;

  List<String> gptBoards = [];
  bool boardOrPicto = true;
  ScrollController boardScrollController = ScrollController();
  ScrollController pictoScrollController = ScrollController();
  List<Picto> gptPictos = [];
  List<Picto> chatGptPictos = [];
  String generatedStory = '';
  bool btnText = false;
  final List<String> nounBoards = ['APLbz00sRZDNGyGzioXMz', 'DDrKGBCRqNeAy4LgKfN4J', 'alr_Y_ZidZDqQJQCRiqoE', 'lyr-m9k0Q6-rffFFBwPEk'];
  final List<String> modifierBoards = ['--PHmDIFeKHvulVxNtBgk', '5kfboTpsoH8RSFvA9ruE1', 'TMO8t_1hMaHiyh1SUwaFH'];
  final List<String> actionBoards = ['L6pHIipM3ocu3wYlMuo2y'];
  final List<String> placeBoards = ['H6zmHfH-5XVtpy1RJ1ci7', 'kBVGvu0NygXFUWTFxcQJe'];
  int sentencePhase = 0;

  ChatGPTNotifier(this._userNotifier, this._patientNotifier, this._chatGPTRepository, this._gamesProvider, this._tts);

  Future<void> createStory() async {
    final String prompt = 'game.prompt'.trl;
    final finalPrompt = '$prompt ${gptPictos[0].text}, ${gptPictos[1].text}, ${gptPictos[2].text}, ${gptPictos[3].text}.';
    final res = await _chatGPTRepository.getStory(prompt: finalPrompt);
    if (res.isRight) {
      generatedStory = res.right;
    }
    notifyListeners();
  }

  Future<void> fetchGptPictos({required String id}) async {
    List<Picto> picts = [];
    final gro = _gamesProvider.groups[id];
    for (var e in gro!.relations) {
      picts.add(
        _gamesProvider.pictograms[e.id]!,
      );
    }
    chatGptPictos.clear();
    chatGptPictos.addAll(picts);
    // print(picts.toString());
    notifyListeners();
  }

  Future<void> speakStory() async {
    if (_gamesProvider.backgroundMusicPlayer.playing) {
      _gamesProvider.backgroundMusicPlayer.pause();
    }
    _tts.speak(generatedStory);
  }

  Future<void> resetStoryGame() async {
    gptPictos.clear();
    gptBoards = [];
    sentencePhase = 0;
    notifyListeners();
  }

  Future<void> stopTTS() async {
    await _tts.ttsStop();
  }

  Future<String?> generatePhrase(List<Picto> pictograms) async {
    final user = _patientNotifier.state ?? _userNotifier.user;

    int age = (user.settings.data.birthDate.difference(DateTime.now()).inDays / 365).round().abs();

    String gender = user.settings.data.genderPref;

    String pictogramsString = pictograms.map((e) => e.text).join(", ");

    int maxTokens = (pictograms.length * 10).round().clamp(300, 500);

    final String lang = user.settings.language.language;

    final response = await _chatGPTRepository.getCompletion(
      age: age,
      gender: gender,
      pictograms: pictogramsString,
      maxTokens: maxTokens,
      language: lang.split('_')[0],
    );

    return response.fold(
      (l) => null,
      (r) => r,
    );
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

    if (currentPosition >= pictoScrollController.position.maxScrollExtent) return;

    pictoScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

final chatGPTProvider = ChangeNotifierProvider<ChatGPTNotifier>((ref) {
  final userState = ref.watch(userNotifier.notifier);
  final patientState = ref.watch(patientNotifier.notifier);
  final chatGPTRepository = GetIt.I<ChatGPTRepository>();
  final gamesProvider = ref.watch(gameProvider);
  final tts = ref.watch(ttsProvider);
  return ChatGPTNotifier(userState, patientState, chatGPTRepository, gamesProvider, tts);
});
