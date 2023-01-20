import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picto_widget/picto_widget.dart';

class WordBarUI extends ConsumerStatefulWidget {
  const WordBarUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WordBarUIState();
}

class _WordBarUIState extends ConsumerState<WordBarUI> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Flex(
      direction: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () {},
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
        ),
        const SizedBox(width: 36),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              PictoWidget(
                width: 64,
                height: 140,
                onTap: () {},
                imageUrl: "https://static.arasaac.org/pictograms/2282/2282_300.png",
                text: "HOLA",
              ),
            ],
          ),
        )
      ],
    );
  }
}
