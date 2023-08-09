import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';

class DayWidget extends ConsumerWidget {
  const DayWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (provider.daysToUsePicto.contains(text)) {
          provider.daysToUsePicto.remove(text);
        } else {
          provider.daysToUsePicto.add(text);
        }
        provider.notify();
      },
      child: Container(
        decoration: BoxDecoration(
          color: provider.daysToUsePicto.contains(text) ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: provider.daysToUsePicto.contains(text) ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
