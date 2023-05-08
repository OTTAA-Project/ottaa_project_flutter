import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/match_pictogram_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/memory_game_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/whats_the_picto_screen.dart';

class GamePlayScreen extends ConsumerStatefulWidget {
  const GamePlayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends ConsumerState<GamePlayScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final provider = ref.read(gameProvider);
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        if (provider.isMute) {
        } else {
          provider.backgroundMusicPlayer.play();
        }
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        if (!provider.isMute) {
          provider.backgroundMusicPlayer.pause();
        }
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(gameProvider);
    return Scaffold(
      body: provider.selectedGame == 0
          ? const WhatsThePictoScreen()
          : provider.selectedGame == 1
              ? const MatchPictogramScreen()
              : const MemoryGameScreen(),
    );
  }
}
