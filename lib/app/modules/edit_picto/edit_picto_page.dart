import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/icon_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';

class EditPictoPage extends GetView<EditPictoController> {
  const EditPictoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAOrangeNew,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('edit_pictogram'.tr),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(width * 0.01),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      padding: EdgeInsets.all(width * 0.01),
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(width * 0.01),
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Obx(
                            () => Text(
                              controller.text.value
                                  ? '1'
                                  : controller.frame.value
                                      ? '2'
                                      : controller.tags.value
                                          ? '3'
                                          : '',
                            ),
                          ),
                        ),
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
              padding: EdgeInsets.symmetric(vertical: width * 0.01),
              color: kOTTAOrangeNew,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(
                    onTap: () {
                      controller.text.value = true;
                      controller.frame.value = false;
                      controller.tags.value = false;
                    },
                    iconData: Icons.edit,
                    text: 'text'.tr,
                  ),
                  IconWidget(
                    onTap: () {
                      controller.text.value = false;
                      controller.frame.value = true;
                      controller.tags.value = false;
                    },
                    iconData: Icons.edit,
                    text: 'frame'.tr,
                  ),
                  IconWidget(
                    onTap: () {
                      controller.text.value = false;
                      controller.frame.value = false;
                      controller.tags.value = true;
                    },
                    iconData: Icons.edit,
                    text: 'tags'.tr,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
