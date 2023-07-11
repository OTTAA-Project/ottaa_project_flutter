import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/exit_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/talk_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/word_bar.dart';

class HomeTabletLayout extends ConsumerStatefulWidget {
  final Widget child;

  const HomeTabletLayout({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabletState();
}

class _HomeTabletState extends ConsumerState<HomeTabletLayout> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = ref.watch(homeProvider);
    final colorScheme = Theme.of(context).colorScheme;
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
                height: 170,
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
