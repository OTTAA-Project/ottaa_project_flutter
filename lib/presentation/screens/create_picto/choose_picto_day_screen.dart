import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';

class ChoosePictoDayScreen extends ConsumerWidget {
  const ChoosePictoDayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'create.time_headline'.trl,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: ImageWidget(
              onTap: () {},
            ),
          ),
          Text(
            'global.predictive'.trl,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'create.time_sub1'.trl,
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            children: [
              DayWidget(text: 'global.sunday'.trl),
              DayWidget(text: 'global.monday'.trl),
              DayWidget(text: 'global.tuesday'.trl),
              DayWidget(text: 'global.wednesday'.trl),
              DayWidget(text: 'global.thursday'.trl),
              DayWidget(text: 'global.friday'.trl),
              DayWidget(text: 'global.saturday'.trl),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'create.schedule'.trl,
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            children: [
              TimeWidget(text: 'global.tomorrow'.trl),
              TimeWidget(text: 'global.noon'.trl),
              TimeWidget(text: 'global.late'.trl),
              TimeWidget(text: 'global.evening'.trl),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SimpleButton(
              width: false,
              onTap: () {
                for (var element in provider.daysToUsePicto) {
                  if (provider.daysString.isEmpty) {
                    provider.daysString = '${provider.daysString} ';
                  } else {
                    provider.daysString = '${provider.daysString}, $element ';
                  }
                }
                for (var element in provider.timeForPicto) {
                  if (provider.timeString.isEmpty) {
                    provider.timeString = '${provider.timeString} ';
                  } else {
                    provider.timeString = '${provider.timeString}, $element ';
                  }
                }
                provider.notify();
                provider.nextPage();
              },
              text: 'global.continue'.trl,
            ),
          ),
        ],
      ),
    );
  }
}

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
