import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/day_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/time_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';

class ChoosePictoDayScreen extends ConsumerWidget {
  const ChoosePictoDayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SimpleButton(
              width: false,
              onTap: () {
                provider.daysString = '';
                provider.timeString = '';
                provider.isFinalPage = true;
                for (var element in provider.daysToUsePicto) {
                  if (provider.daysString.isEmpty) {
                    provider.daysString = '$element ';
                  } else {
                    provider.daysString = '${provider.daysString}, $element ';
                  }
                }
                for (var element in provider.timeForPicto) {
                  if (provider.timeString.isEmpty) {
                    provider.timeString = '$element ';
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
