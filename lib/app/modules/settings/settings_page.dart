import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.toNamed(AppRoutes.HOME),
          ),
          title: Text(
            'settings'.tr,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          // leading: Placeholder(),
          centerTitle: false,
          backgroundColor: Colors.grey[350],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 40,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SETTINGS'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey[700],
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: kOTTAOrangeNew,
                  ),
                  onTap: () {},
                  title: Text('pictograms'.tr),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.try_sms_star,
                    color: kOTTAOrangeNew,
                  ),
                  onTap: () {},
                  title: Text('prediction'.tr),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.accessibility,
                    color: kOTTAOrangeNew,
                  ),
                  onTap: () {},
                  title: Text('accessibility'.tr),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.record_voice_over,
                    color: kOTTAOrangeNew,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.SETTINGS_VOICE),
                  title: Text('voice_and_subtitles'.tr),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: kOTTAOrangeNew,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.SETTINGS_LANG),
                  title: Text('language'.tr),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
