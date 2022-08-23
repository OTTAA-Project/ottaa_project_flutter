import 'package:cached_network_image/cached_network_image.dart';
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
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        height: verticalSize * 0.06,
        decoration: BoxDecoration(
          color: kOTTAAOrangeNew,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(verticalSize * 0.04),
            topRight: Radius.circular(verticalSize * 0.04),
          ),
        ),
        child: const Center(
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
          !kIsWeb
              ? ShareIconWidget(
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
                      Share.shareFiles([controller.audioFilePath], text: 'Audio File');
                    }
                  },
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          ShareIconWidget(
            color: kOTTAAOrangeNew,
            verticalSize: verticalSize,
            iconData: Icons.image,
            text: 'image'.tr,
            onTap: () async {
              if (kIsWeb) {
                /// here is method for having image and uploading it to the firebase for sharing
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                print('started');
                final image = await controller.screenshotController.captureFromWidget(
                  Container(
                    height: verticalSize * 0.25,
                    // width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: Container(
                      color: Colors.blueGrey,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GetBuilder<HomeController>(
                            id: 'screenshot',
                            builder: (controller) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: controller.sentencePicts
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: kIsWeb
                                          ? Image.network(
                                              e.imagen.pictoEditado == null ? e.imagen.picto : e.imagen.pictoEditado!,
                                              width: verticalSize * 0.14,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    color: kOTTAAOrangeNew,
                                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                  ),
                                                );
                                              },
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: e.imagen.pictoEditado == null ? e.imagen.picto : e.imagen.pictoEditado!,
                                              placeholder: (context, url) => const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              // height: verticalSize * 0.04,
                                              width: verticalSize * 0.14,
                                            ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Image.asset(
                              'assets/otta_drawer_logo.png',
                              height: verticalSize * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  delay: const Duration(seconds: 2),
                  context: context,
                );
                // final image = await controller.screenshotController.capture(
                //   pixelRatio: 1,
                //   delay: const Duration(milliseconds: 200),
                // );
                print('image taken');
                final value = await controller.dataController.uploadImageToStorageForWeb(
                  storageName: 'testingUpload',
                  imageInBytes: image,
                );
                print('image uploaded');
                final Uri url = Uri.parse('https://wa.me/?text=$value');
                print(value);
                await launchUrl(url);
                Get.back();
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
            text: 'text'.tr,
            onTap: () async {
              controller.generateStringToShare();
              if (kIsWeb) {
                final Uri url = Uri.parse('https://wa.me/?text=${controller.textToShare}');
                await launchUrl(url);
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
