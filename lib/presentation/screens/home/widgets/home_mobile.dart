import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
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
        if (provider.show) ...[
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
      ],
    );
  }
}
