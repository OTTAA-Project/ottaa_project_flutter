import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/frame_color_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/tags_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/text_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';
import '../home/home_controller.dart';
import 'local_widgets/search_photo_page.dart';

class EditPictoPage extends GetView<EditPictoController> {
  EditPictoPage({Key? key}) : super(key: key);
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('important'.tr),
              content: Text('do_you_want_to_save_changes'.tr),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _homeController.editingFromHomeScreen = false;
                    Navigator.of(context).pop(true);
                  },
                  child: Text('no'.tr),
                ),
                TextButton(
                  onPressed: () async =>
                      controller.uploadChanges(context: context),
                  child: Text('yes'.tr),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('go_back'.tr),
                ),
              ],
            ),
          )) ??
          false;
    }

    final languaje = _ttsController.languaje;
    // final height = Get.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kOTTAAOrangeNew,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text('edit_pictogram'.tr),
        ),
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                height: Get.height,
                color: Colors.black,
                padding: EdgeInsets.all(horizontalSize * 0.01),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(horizontalSize * 0.01),
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) => PictureDialogWidget(
                                  cameraOnTap: controller.cameraFunction,
                                  galleryOnTap: controller.galleryFunction,
                                  arsaacOnTap: () async {
                                    final ans = await showSearch<SearchModel?>(
                                      context: context,
                                      delegate: SearchPhotoPage(),
                                    );
                                    print(ans?.text);
                                  },
                                ),
                              );
                            },
                            child: CategoryWidget(
                              name: languaje == 'en'
                                  ? controller.pict.value!.texto.en
                                  : controller.pict.value!.texto.es,
                              imageName: controller
                                          .pict.value!.imagen.pictoEditado ==
                                      null
                                  ? controller.pict.value!.imagen.picto
                                  : controller.pict.value!.imagen.pictoEditado!,
                              border: controller.pictoBorder.value,
                              color: controller.pict.value!.tipo,
                              bottom: false,
                              isEditing: controller.editingPicture.value,
                              fileImage: controller.fileImage.value,
                              imageWidget: controller.imageWidget.value,
                              selectedImageUrl:
                                  controller.selectedPhotoUrl.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: horizontalSize * 0.01,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(horizontalSize * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(horizontalSize * 0.01),
                          ),
                          child: Obx(
                            () => controller.text.value
                                ? TextWidget()
                                : controller.frame.value
                                    ? FrameColorWidget(
                                        onTap: ({int? tipo}) {
                                          controller.pictoBorder.value = false;
                                          controller.pict.value!.tipo = tipo!;
                                          controller.pictoBorder.value = true;
                                        },
                                      )
                                    : controller.tags.value
                                        ? TagsWidget()
                                        : Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RightColumnWidget(),
          ],
        ),
      ),
    );
  }
}

class PictureDialogWidget extends GetView<EditPictoController> {
  const PictureDialogWidget({
    Key? key,
    required this.cameraOnTap,
    required this.galleryOnTap,
    required this.arsaacOnTap,
  }) : super(key: key);
  final void Function()? cameraOnTap;
  final void Function()? galleryOnTap;
  final void Function()? arsaacOnTap;

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        width: horizontalSize * 0.4,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(verticalSize * 0.03),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: verticalSize * 0.01),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kOTTAAOrangeNew,
              ),
              child: Center(
                child: Text(
                  'choose_an_option'.tr,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageWidget(
                    imageLink: 'assets/camera.png',
                    text: 'camera'.tr,
                    onTap: cameraOnTap,
                  ),
                  ImageWidget(
                    imageLink: 'assets/gallery.png',
                    text: 'gallery'.tr,
                    onTap: galleryOnTap,
                  ),
                  ImageWidget(
                    imageLink: 'assets/download_from_arasaac.png',
                    text: 'download_from_arasaac'.tr,
                    onTap: arsaacOnTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imageLink,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String imageLink;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageLink,
            height: verticalSize * 0.15,
          ),
          SizedBox(
            height: verticalSize * 0.01,
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
