import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/chooser_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/divider_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/switch_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class VoiceAndSubtitleScreen extends ConsumerWidget {
  const VoiceAndSubtitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(userSettingsProvider);
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'user.settings.voice_and_subtitles'.trl,
          style: textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'global.voice'.trl,
                style: textTheme.headline2!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'user.voice_and_subtitle.voice_types'.trl,
                style: textTheme.headline3,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  ChooserWidget(
                    selected: provider.voiceRate == 0 ? true : false,
                    onTap: () {
                      provider.voiceRate = 0;
                      provider.notify();
                    },
                    title: 'user.voice_and_subtitle.voz1'.trl,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ChooserWidget(
                      selected: provider.voiceRate == 1 ? true : false,
                      onTap: () {
                        provider.voiceRate = 1;
                        provider.notify();
                      },
                      title: 'user.voice_and_subtitle.voz2'.trl,
                    ),
                  ),
                  ChooserWidget(
                    selected: provider.voiceRate == 2 ? true : false,
                    onTap: () {
                      provider.voiceRate = 2;
                      provider.notify();
                    },
                    title: 'user.voice_and_subtitle.voz3'.trl,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'user.voice_and_subtitle.voice_rate'.trl,
                style: textTheme.headline3,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  ChooserWidget(
                    selected: provider.voiceType == 0 ? true : false,
                    onTap: () {
                      provider.voiceType = 0;
                      provider.notify();
                    },
                    title: 'global.slow'.trl,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ChooserWidget(
                      selected: provider.voiceType == 1 ? true : false,
                      onTap: () {
                        provider.voiceType = 1;
                        provider.notify();
                      },
                      title: 'global.default'.trl,
                    ),
                  ),
                  ChooserWidget(
                    selected: provider.voiceType == 2 ? true : false,
                    onTap: () {
                      provider.voiceType = 2;
                      provider.notify();
                    },
                    title: 'global.fast'.trl,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.mute = value;
                  provider.notify();
                },
                title: 'user.voice_and_subtitle.mute'.trl,
                value: provider.mute,
              ),
              const DividerWidget(),
              //todo: add them into expanded and make the text size according to size
              Text(
                'user.voice_and_subtitle.subtitle'.trl,
                style: textTheme.headline3,
              ),
              const SizedBox(
                height: 8,
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.show = value;
                  provider.notify();
                },
                title: 'user.voice_and_subtitle.show'.trl,
                value: provider.show,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "user.voice_and_subtitle.size".trl,
                style: textTheme.headline3,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChooserWidget(
                    selected: provider.size == 0 ? true : false,
                    onTap: () {
                      provider.size = 0;
                      provider.notify();
                    },
                    title: 'global.boy'.trl,
                  ),
                  ChooserWidget(
                    selected: provider.size == 1 ? true : false,
                    onTap: () {
                      provider.size = 1;
                      provider.notify();
                    },
                    title: 'global.medium'.trl,
                  ),
                  ChooserWidget(
                    selected: provider.size == 2 ? true : false,
                    onTap: () {
                      provider.size = 2;
                      provider.notify();
                    },
                    title: 'global.big'.trl,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.capital = value;
                  provider.notify();
                },
                title: 'user.voice_and_subtitle.capital'.trl,
                value: provider.capital,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
