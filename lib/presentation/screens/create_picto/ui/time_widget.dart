import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({
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
        if (provider.timeForPicto.contains(text)) {
          provider.timeForPicto.remove(text);
        } else {
          provider.timeForPicto.add(text);
        }
        provider.notify();
      },
      child: Container(
        decoration: BoxDecoration(
          color: provider.timeForPicto.contains(text) ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: provider.timeForPicto.contains(text) ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
