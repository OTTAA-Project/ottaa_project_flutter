import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';

class TextWidget extends ConsumerWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'global.text'.trl,
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: provider.nameController,
                onChanged: (text) {
                  provider.notify();
                },
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 50,
              width: 58,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorScheme.primary),
                  overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () async {
                  await provider.speakWord();
                },
                child: Center(
                  child: Image.asset(
                    AppImages.kOttaaMinimalist,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
