import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/tags_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/text_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';

class EditPictoPage extends GetView<EditPictoController> {
  EditPictoPage({Key? key}) : super(key: key);
  final _ttsController = Get.find<TTSController>();
  final _pictogramController = Get.find<PictogramGroupsController>();

  @override
  Widget build(BuildContext context) {
    final languaje = _ttsController.languaje;
    // final height = Get.height;
    final width = Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kOTTAOrangeNew,
        leading: Container(),
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
              padding: EdgeInsets.all(width * 0.01),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.01),
                      child: CategoryWidget(
                        name: languaje == 'en'
                            ? _pictogramController.picts[1].texto.en
                            : _pictogramController.picts[1].texto.es,
                        imageName: _pictogramController.picts[1].imagen.picto,
                        border: true,
                        color: _pictogramController.picts[1].tipo,
                        bottom: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * 0.01)),
                        child: Center(
                          child: Obx(
                            () => controller.text.value
                                ? TextWidget()
                                : controller.frame.value
                                    ? Container()
                                    : controller.tags.value
                                        ? TagsWidget()
                                        : Container(),
                          ),
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
    );
  }
}
