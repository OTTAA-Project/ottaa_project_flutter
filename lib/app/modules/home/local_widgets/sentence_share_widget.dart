import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/share_icon_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SentenceShareWidget extends GetView<HomeController> {
  const SentenceShareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(verticalSize * 0.04),
      ),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        height: verticalSize * 0.06,
        decoration: BoxDecoration(
          color: kOTTAAOrangeNew,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(verticalSize * 0.04),
            topRight: Radius.circular(verticalSize * 0.04),
          ),
        ),
        child: Center(
          child: Text(
            'Share',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      content: Row(
        children: [
          ShareIconWidget(
            color: kOTTAAOrangeNew,
            verticalSize: verticalSize,
            iconData: Icons.volume_up_sharp,
            text: 'Audio',
            onTap: () async {
              if (kIsWeb) {
              } else {
                controller.generateStringToShare();
                controller.createAudioScript(
                  name: 'Audio Message',
                  script: controller.textToShare,
                );
                Share.shareFiles([controller.audioFilePath],
                    text: 'Audio File');
              }
            },
          ),
          ShareIconWidget(
            color: kOTTAAOrangeNew,
            verticalSize: verticalSize,
            iconData: Icons.image,
            text: 'Image',
            onTap: () async {
              if (kIsWeb) {
                /// here is method for having image and uploading it to the firebase for sharing
                final image = await controller.screenshotController
                    .capture(pixelRatio: 3);
                final value =
                    await controller.dataController.uploadImageToStorageForWeb(
                  storageName: 'testingUpload',
                  imageInBytes: image!,
                );
                final Uri _url = Uri.parse('https://wa.me/?text=$value');
                print(value);
                await launchUrl(_url);
              } else {
                final externalDirectory = await getExternalStorageDirectory();
                String fileName = 'image_to_share.png';
                String path = externalDirectory!.path;
                final audioFilePath = '${externalDirectory.path}/$fileName';
                controller.screenshotController.captureAndSave(
                  path, //set path where screenshot will be saved
                  fileName: fileName,
                  pixelRatio: 3,
                );
                Share.shareFiles([audioFilePath], text: 'Image File');
              }
            },
          ),
          ShareIconWidget(
            color: kOTTAAOrangeNew,
            verticalSize: verticalSize,
            iconData: Icons.text_format,
            text: 'Texto',
            onTap: () async {
              controller.generateStringToShare();
              if (kIsWeb) {
                final Uri _url =
                    Uri.parse('https://wa.me/?text=${controller.textToShare}');
                await launchUrl(_url);
              } else {
                Share.share(controller.textToShare);
              }
            },
          ),
        ],
      ),
    );
  }
}
