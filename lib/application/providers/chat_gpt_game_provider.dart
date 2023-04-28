import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';

class ChatGptGameProvider extends ChangeNotifier {
  final GamesProvider _gameProvider;

  ChatGptGameProvider(this._gameProvider);
}

final chatGptGameProvider = ChangeNotifierProvider.autoDispose((ref) {
  final gamesProvider = ref.watch(gameProvider);
  return ChatGptGameProvider(gamesProvider);
});
