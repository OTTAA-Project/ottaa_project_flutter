import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';

class PictoFinalScreen extends ConsumerWidget {
  const PictoFinalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Expanded(
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: TimeWidget(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SimpleButton(
            width: false,
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              await provider.saveAndUploadPictogram();
              provider.notify();
              context.pop();
              context.pop();
            },
            text: 'create.save'.trl,
          ),
        ),
      ],
    );
  }
}

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(provider.daysString),
          const SizedBox(
            height: 4,
          ),
          Text(
            provider.timeString,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
