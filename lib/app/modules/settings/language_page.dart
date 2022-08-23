import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_widgets/build_app_bar.dart';
import 'settings_controller.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        appBar: buildAppBar('language'.tr),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey[700],
              ),
              // SwitchListTile(
              //   activeColor: kOTTAAOrange,
              //   value: _.ttsController.isEnglish,
              //   onChanged: (bool value) {
              //     _.toggleLanguaje(value);
              //   },
              //   title: Text('language'.tr),
              //   subtitle: _.ttsController.isEnglish
              //       ? Text('English')
              //       : Text('Spanish'),
              // ),
              DropdownButton<String>(
                isExpanded: true,
                // value: _.isEnglish.value ? 'English' : 'Spanish',
                value: _.ttsController.isEnglish ? 'English' : 'Spanish',
                iconSize: 20,
                elevation: 16,
                underline: Container(),
                onChanged: (newValue) {
                  _.toggleLanguaje(newValue!);
                },
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
                  ),
                ],
              ),
              const Divider(),
              SwitchListTile(
                value: false,
                onChanged: (value) {},
                title: Text('ottaa_labs'.tr),
                subtitle: Text('language_page_long_1'.tr),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
