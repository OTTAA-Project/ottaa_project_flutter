import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

class ChatGptGameProvider extends ChangeNotifier {
  final GamesProvider _gameProvider;
  final ChatGPTRepository _chatGPTServices;
  String generatedStory = '';
  int sentencePhase = 0;
  List<Picto> gptPictos = [];

  Future<void> createStory() async {
    final String prompt = 'game.prompt'.trl;
    final finalPrompt = '$prompt ${gptPictos[0].text}, ${gptPictos[1].text}, ${gptPictos[2].text}, ${gptPictos[3].text}.';
    final res = await _chatGPTServices.getGPTStory(prompt: prompt);
    if (res.isRight) {
      generatedStory = res.right;
    }
  }

  Future<void> speakStory() async {
    // _tts.speak(generatedStory);
  }

  Future<void> resetStoryGame() async {
    gptPictos.clear();
    sentencePhase = 0;
  }

  ChatGptGameProvider(this._gameProvider,this._chatGPTServices);
}

final chatGptGameProvider = ChangeNotifierProvider.autoDispose((ref) {
  final gamesProvider = ref.watch(gameProvider);
  final chatGpt = GetIt.I<ChatGPTRepository>();
  return ChatGptGameProvider(gamesProvider, chatGpt);
});
