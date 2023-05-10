import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/score_dialouge.dart';

class LeftSideIcons extends ConsumerStatefulWidget {
  const LeftSideIcons({
    Key? key,
    this.hints = false,
  }) : super(key: key);
  final bool hints;

  @override
  ConsumerState<LeftSideIcons> createState() => _LeftSideIconsState();
}

class _LeftSideIconsState extends ConsumerState<LeftSideIcons> {
  bool mute = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = ref.read(gameProvider);
      mute = provider.isMute;
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = ref.read(gameProvider);
    bool hints = ref.watch(gameProvider).hintsBtn;
    print(mute);
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      bottom: 24,
      left: 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ScoreDialouge();
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                AppImages.kGamesTrophy,
                height: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                mute = !mute;
                provider.isMute = mute;
                provider.changeMusic(mute: mute);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(
                  mute ? Icons.volume_mute_outlined : Icons.volume_up_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          widget.hints
              ? GestureDetector(
                  onTap: () async{
                    if (hints) {
                      provider.hintsBtn = !provider.hintsBtn;
                      await provider.cancelHints();
                    } else {
                      provider.hintsBtn = !provider.hintsBtn;
                      await provider.showHints();
                    }
                    provider.notify();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: hints ? colorScheme.primary : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: hints
                        ? const Icon(
                            Icons.help,
                            color: Colors.white,
                            size: 24,
                          )
                        : Image.asset(
                            AppImages.kGamesMark,
                            height: 24,
                          ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
