import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.toNamed(AppRoutes.kHome),
          ),
          title: Text(
            'settings'.tr,
            style: const TextStyle(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey[700],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: kOTTAAOrangeNew,
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "we_are_working_on_this_feature".tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: verticalSize * 0.03,
                    );
                  },
                  title: Text('pictograms'.tr),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.try_sms_star,
                    color: kOTTAAOrangeNew,
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "we_are_working_on_this_feature".tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: verticalSize * 0.03,
                    );
                  },
                  title: Text('prediction'.tr),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.accessibility,
                    color: kOTTAAOrangeNew,
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "we_are_working_on_this_feature".tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: verticalSize * 0.03,
                    );
                  },
                  title: Text('accessibility'.tr),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.record_voice_over,
                    color: kOTTAAOrangeNew,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.kSettingsVoice),
                  title: Text('voice_and_subtitles'.tr),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: kOTTAAOrangeNew,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.kSettingsLang),
                  title: Text('language'.tr),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
