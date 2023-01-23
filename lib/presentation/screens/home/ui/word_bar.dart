import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
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

    int pictoSize = 64;

    int pictoCount = ((size.width - 350) / pictoSize).floor();

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              pictoCount,
              (index) => PictoWidget(
                width: 64,
                height: 140,
                onTap: () {},
                imageUrl: "https://static.arasaac.org/pictograms/2282/2282_300.png",
                text: "HOLA",
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 84,
          height: 80,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Icon(
                Icons.keyboard_return_sharp,
                color: colorScheme.primary,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 84,
          height: 80,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.all(14),
              child: Image.asset(
                AppImages.kIconoOttaa,
                color: Colors.white,
                width: 32,
                height: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
