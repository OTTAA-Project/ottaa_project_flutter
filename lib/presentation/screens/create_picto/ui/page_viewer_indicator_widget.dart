import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';

class PageViewerIndicatorWidget extends ConsumerWidget {
  const PageViewerIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(createPictoProvider).currentIndex;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Indicator(
          isOn: index == 0 ? true : false,
        ),
        Indicator(
          isOn: index == 1 ? true : false,
        ),
        Indicator(
          isOn: index == 2 ? true : false,
        ),
        Indicator(
          isOn: index == 3 ? true : false,
        ),
        Indicator(
          isOn: index == 4 ? true : false,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '${'global.step'.trl} ${index + 1} / 5',
          style: textTheme.bodySmall!.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    this.isOn = false,
  });

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 4,
        width: isOn ? 16 : 8,
        decoration: BoxDecoration(
          color: isOn ? colorScheme.primary : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
