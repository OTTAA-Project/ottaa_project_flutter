import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/core/enums/size_types.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/drop_down_widget.dart';
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
    return WillPopScope(
      onWillPop: () async {
        provider.updateVoiceAndSubtitleSettings();
        return true;
      },
      child: Scaffold(
        appBar: OTTAAAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              provider.updateVoiceAndSubtitleSettings();
              context.pop();
            },
            splashRadius: 24,
          ),
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
                      selected: provider.ttsSetting.voiceSetting
                              .voicesNames[provider.language] ==
                          'default1',
                      onTap: () {
                        provider.changeVoiceType(type: 'default1');
                      },
                      title: 'user.voice_and_subtitle.voz1'.trl,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChooserWidget(
                        selected: provider.ttsSetting.voiceSetting
                                .voicesNames[provider.language] ==
                            'default2',
                        onTap: () {
                          provider.changeVoiceType(type: 'default2');
                        },
                        title: 'user.voice_and_subtitle.voz2'.trl,
                      ),
                    ),
                    ChooserWidget(
                      selected: provider.ttsSetting.voiceSetting
                              .voicesNames[provider.language] ==
                          'default3',
                      onTap: () {
                        provider.changeVoiceType(type: 'default3');
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
                      selected: provider.voiceRate == VelocityTypes.slow.name
                          ? true
                          : false,
                      onTap: () {
                        print(provider.ttsSetting.voiceSetting
                            .voicesSpeed[provider.language]!.name);
                        provider.changeVoiceSpeed(type: VelocityTypes.slow);
                        provider.notify();
                      },
                      title: 'global.slow'.trl,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChooserWidget(
                        selected: provider.voiceRate == VelocityTypes.mid.name
                            ? true
                            : false,
                        onTap: () {
                          provider.changeVoiceSpeed(type: VelocityTypes.mid);
                        },
                        title: 'global.default'.trl,
                      ),
                    ),
                    ChooserWidget(
                      selected: provider.voiceRate == VelocityTypes.fast.name
                          ? true
                          : false,
                      onTap: () {
                        provider.changeVoiceSpeed(type: VelocityTypes.fast);
                      },
                      title: 'global.fast'.trl,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                DropdownButtonFormField(
                  value: provider.voiceName,
                  items: provider.voices
                      .map(
                        (value) => DropdownMenuItem(
                          value: value.name,
                          child: Text(value.locale),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    provider.changeTTSVoice(value: value!);
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                SwitchWidget(
                  onChanged: (value) {
                    provider.changeMute(value: value);
                  },
                  title: 'user.voice_and_subtitle.mute'.trl,
                  value: provider.ttsSetting.voiceSetting.mutePict,
                ),
                const DividerWidget(),
                Text(
                  'user.voice_and_subtitle.subtitle'.trl,
                  style: textTheme.headline2!.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SwitchWidget(
                  onChanged: (value) {
                    provider.changeSubtitle(value: value);
                  },
                  title: 'user.voice_and_subtitle.show'.trl,
                  value: provider.ttsSetting.subtitlesSetting.show,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChooserWidget(
                      selected: provider.ttsSetting.subtitlesSetting.size ==
                              SizeTypes.small
                          ? true
                          : false,
                      onTap: () {
                        provider.changeTextType(type: SizeTypes.small);
                      },
                      title: 'global.boy'.trl,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ChooserWidget(
                      selected: provider.ttsSetting.subtitlesSetting.size ==
                              SizeTypes.mid
                          ? true
                          : false,
                      onTap: () {
                        provider.changeTextType(type: SizeTypes.mid);
                      },
                      title: 'global.medium'.trl,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ChooserWidget(
                      selected: provider.ttsSetting.subtitlesSetting.size ==
                              SizeTypes.big
                          ? true
                          : false,
                      onTap: () {
                        provider.changeTextType(type: SizeTypes.big);
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
                    provider.changeCapital(value: value);
                  },
                  title: 'user.voice_and_subtitle.capital'.trl,
                  value: provider.ttsSetting.subtitlesSetting.caps,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
