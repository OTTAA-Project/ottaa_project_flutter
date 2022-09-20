import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/frame_color_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_page.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/icon_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/add_group_text_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/add_group_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/search_photo_picto.dart';

class AddPictoPage extends GetView<PictogramGroupsController> {
  const AddPictoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => _willPop(context: context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kOTTAAOrangeNew,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text('add_pict'.tr),
        ),
        body: Container(
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.all(verticalSize * 0.03),
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // padding: EdgeInsets.all(horizontalSize * 0.01),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) => PictureDialogWidget(
                                  cameraOnTap: controller.cameraFunctionPicto,
                                  galleryOnTap: controller.galleryFunctionPicto,
                                  arsaacOnTap: () async {
                                    await showSearch<SearchModel?>(
                                      context: context,
                                      delegate: SearchPhotoPicto(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Obx(
                              () => AddGroupWidget(
                                name: controller.pictoNameController.text,
                                isImageProvided:
                                    controller.isImageProvidedPicto.value,
                                fileImage: controller.fileImagePicto.value,
                                selectedImageUrl:
                                    controller.selectedPhotoUrlPicto.value,
                                imageWidget: controller.imageWidgetPicto.value,
                                color: controller.tipoValue.value,
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
                          padding: EdgeInsets.all(horizontalSize * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(verticalSize * 0.03),
                            color: Colors.white,
                          ),
                          child: GetBuilder<PictogramGroupsController>(
                            id: 'second',
                            builder: (controller) {
                              if (controller.textOrBorder) {
                                return AddGroupTextWidget(
                                  controllerTxt: controller.pictoNameController,
                                );
                              } else {
                                return FrameColorWidget(onTap: ({int? tipo}) {
                                  controller.updateTipo(tipo: tipo!);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: horizontalSize * 0.01),
                  color: kOTTAAOrangeNew,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconWidget(
                        onTap: () => controller.changeToText(),
                        iconData: Icons.edit,
                        text: 'text'.tr,
                      ),
                      IconWidget(
                        onTap: () => controller.changeToBorderColor(),
                        iconData: Icons.border_outer,
                        text: 'frame'.tr,
                      ),
                      IconWidget(
                        onTap: () {
                          controller.changeToTags(
                              context: context, verticalSize: verticalSize);
                        },
                        iconData: Icons.assistant,
                        text: 'tags'.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _willPop({required BuildContext context}) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('important'.tr),
            content: Text('do_you_want_to_save_changes'.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('no'.tr),
              ),
              TextButton(
                onPressed: () async =>
                    controller.uploadChangesPicto(context: context),
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
}
