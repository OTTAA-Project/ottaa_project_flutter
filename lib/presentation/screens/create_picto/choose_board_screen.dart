import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ChooseBoardScreen extends ConsumerWidget {
  const ChooseBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(createPictoProvider);
    final isSelected = ref.watch(createPictoProvider).isBoardSelected;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 12,
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              return PictogramCard(
                status: true,
                title: 'title',
                actionText: 'actionText',
                pictogram: AssetImage(
                  AppImages.kAccessibilityIcon2,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SimpleButton(
            onTap: () {
              provider.nextPage();
            },
            width: false,
            text: 'global.next'.trl,
            backgroundColor: isSelected ? colorScheme.primary : colorScheme.background,
            fontColor: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}
