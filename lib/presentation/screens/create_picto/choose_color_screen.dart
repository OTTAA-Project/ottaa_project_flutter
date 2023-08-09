import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';

class ChooseColorScreen extends ConsumerWidget {
  const ChooseColorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.read(createPictoProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'create.choose_color'.trl,
                style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: ImageWidget(
                  onTap: () {},
                ),
              ),
              Text(
                'global.color'.trl,
                style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ColorWidget(
                    color: Colors.green,
                    text: 'global.actions'.trl,
                    number: 3,
                  ),
                  ColorWidget(
                    color: Colors.yellow,
                    text: 'global.people'.trl,
                    number: 1,
                  ),
                  ColorWidget(
                    color: Colors.black,
                    text: 'global.miscellaneous'.trl,
                    number: 6,
                  ),
                  ColorWidget(
                    color: Colors.purple,
                    text: 'user.main_setting.interaction'.trl,
                    number: 5,
                  ),
                  ColorWidget(
                    color: colorScheme.primary,
                    text: 'global.noun'.trl,
                    number: 2,
                  ),
                  ColorWidget(
                    color: Colors.blue,
                    text: 'global.adjective'.trl,
                    number: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
        SimpleButton(
          width: false,
          onTap: () {
            provider.nextPage();
          },
          text: 'global.continue'.trl,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class ColorWidget extends ConsumerWidget {
  const ColorWidget({
    super.key,
    required this.color,
    required this.text,
    required this.number,
  });

  final Color color;
  final String text;
  final int number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        provider.borderColor = number;
        provider.notify();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: provider.borderColor == number ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: provider.borderColor == number ? Border.all(color: Colors.transparent) : Border.all(color: color, width: 2),
        ),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: provider.borderColor == number ? Colors.white : color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
