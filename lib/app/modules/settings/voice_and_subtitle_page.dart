import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/build_app_bar.dart';
import 'settings_controller.dart';

class VoiceAndSubtitlesPage extends StatelessWidget {
  VoiceAndSubtitlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        builder: (_) => Scaffold(
              appBar: buildAppBar('voice_and_subtitles'.tr),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'text_to_speche_engine'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey[700],
                      ),
                      SwitchListTile(
                        activeColor: kOTTAAOrange,
                        value: _.ttsController.isCustomTTSEnable,
                        onChanged: (bool value) {
                          _.toggleIsCustomTTSEnable(value);
                        },
                        title: Text('enable_custom_tts'.tr),
                        subtitle: _.ttsController.isCustomTTSEnable
                            ? Text('ON')
                            : Text('OFF'),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {},
                        title: Text('speech_rate'.tr),
                        subtitle: Text(_.ttsController.rate.toString()),
                        enabled: false,
                      ),
                      Slider(
                        activeColor: _.ttsController.isCustomTTSEnable
                            ? kOTTAAOrange
                            : kQuantumGrey,
                        inactiveColor: kQuantumGrey,
                        value: _.ttsController.rate,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        label: _.ttsController.rate.toString(),
                        onChanged: (double value) {
                          if (_.ttsController.isCustomTTSEnable)
                            _.setRate(value);
                        },
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {},
                        title: Text('speech_pitch'.tr),
                        subtitle: Text(_.ttsController.pitch.toString()),
                        enabled: false,
                      ),
                      Slider(
                        activeColor: _.ttsController.isCustomTTSEnable
                            ? kOTTAAOrange
                            : kQuantumGrey,
                        inactiveColor: kQuantumGrey,
                        value: _.ttsController.pitch,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        label: _.ttsController.pitch.toString(),
                        onChanged: (double value) {
                          if (_.ttsController.isCustomTTSEnable)
                            _.setPitch(value);
                        },
                      ),
                      Text(
                        'SUBTITLE'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey[700],
                      ),
                      SwitchListTile(
                        activeColor: kOTTAAOrange,
                        title: Text('customized_subtitle'.tr),
                        subtitle: _.ttsController.isCustomSubtitle
                            ? Text('ON')
                            : Text('OFF'),
                        onChanged: (bool value) {
                          _.toggleIsCustomSubtitle(value);
                        },
                        value: _.ttsController.isCustomSubtitle,
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {},
                        title: Text('size'.tr),
                        subtitle: Text(_.ttsController.subtitleSize.toString()),
                        enabled: false,
                      ),
                      Slider(
                        activeColor: _.ttsController.isCustomSubtitle
                            ? kOTTAAOrange
                            : kQuantumGrey,
                        inactiveColor: kQuantumGrey,
                        value: _.ttsController.subtitleSize.toDouble(),
                        min: 1.0,
                        max: 4.0,
                        divisions: 3,
                        label: _.ttsController.subtitleSize.toString(),
                        onChanged: (double value) {
                          if (_.ttsController.isCustomSubtitle)
                            _.setSubtitleSize(value.toInt());
                        },
                      ),
                      Divider(),
                      SwitchListTile(
                        activeColor: _.ttsController.isCustomSubtitle
                            ? kOTTAAOrange
                            : kQuantumGrey,
                        title: Text('upperCase'.tr),
                        subtitle: Text('it_allows_uppercase_subtitles'.tr),
                        onChanged: (bool value) {
                          if (_.ttsController.isCustomSubtitle)
                            _.toggleIsSubtitleUppercase(value);
                        },
                        value: _.ttsController.isSubtitleUppercase,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
