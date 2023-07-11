import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/enums/size_types.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/exit_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/talk_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/word_bar.dart';

class HomeMobileLayout extends ConsumerStatefulWidget {
  final Widget child;

  const HomeMobileLayout({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<HomeMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(homeProvider);
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox.fromSize(
          size: size,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: 111,
              ),
              widget.child,
            ],
          ),
        ),
        const Positioned(
          top: 10,
          child: WordBarUI(),
        ),
        if (provider.isSpeakWidget) ...[
          Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
          ),
          const Positioned(
            top: 10,
            child: TalkWidget(),
          ),
          provider.patientState.user.patientSettings.tts.subtitlesSetting.show
              ? Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        provider.patientState.user.patientSettings.tts.subtitlesSetting.caps ? provider.subtitleText.toUpperCase() : provider.subtitleText,
                        style: provider.patientState.user.patientSettings.tts.subtitlesSetting.size == SizeTypes.small
                            ? textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700, color: Colors.white)
                            : provider.patientState.user.patientSettings.tts.subtitlesSetting.size == SizeTypes.mid
                                ? textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, color: Colors.white)
                                : textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
        if (provider.isExit) ...[
          Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
          ),
          Center(
            child: ExitWidget(isLongClick: provider.isLongClick),
          ),
          provider.isLongClick
              ? Positioned(
                  top: 10,
                  child: Container(
                    width: 20,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ],
    );
  }
}
