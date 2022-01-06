import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/frame_color_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/tags_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/text_widget.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPictoPage extends GetView<EditPictoController> {
  EditPictoPage({Key? key}) : super(key: key);
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();
  final _pictoController = Get.find<PictogramGroupsController>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('Important'),
              content: Text('Do you want to save changes'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    print(controller.pict.value!.id);
                    int index = 0;
                    while (index < _homeController.picts.length) {
                      if (controller.pict.value!.id ==
                          _homeController.picts[index].id) {
                        break;
                      }
                      index++;
                    }
                    print('index is');
                    print(_homeController.picts[index].id);
                    print(controller.pict.value!.id);
                    print(index);
                    _homeController.picts[index] = controller.pict.value!;
                    _pictoController.picts[index] = controller.pict.value!;
                    final data = _homeController.picts;
                    List<String> fileData = [];
                    data.forEach((element) {
                      final obj = jsonEncode(element);
                      fileData.add(obj);
                    });
                    if (!kIsWeb) {
                      final localFile = LocalFileController();
                      await localFile.writePictoToFile(
                          data: fileData.toString());
                      print('writing to file');
                    }
                    //for the file data
                    final instance = await SharedPreferences.getInstance();
                    await instance.setBool('Pictos_file', true);
                    final res1 = await controller.sharedPref.getPictosFile();
                    print(res1);
                    //upload to the firebase
                    await controller.uploadToFirebase(
                        data: fileData.toString());
                    await controller.pictsExistsOnFirebase();
                    Get.back();
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Go Back'),
                ),
              ],
            ),
          )) ??
          false;
    }

    final languaje = _ttsController.languaje;
    // final height = Get.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kOTTAOrangeNew,
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
                        child: Obx(
                          () => CategoryWidget(
                            name: languaje == 'en'
                                ? controller.pict.value!.texto.en
                                : controller.pict.value!.texto.es,
                            imageName: controller.pict.value!.imagen.picto,
                            border: controller.pictoBorder.value,
                            color: controller.pict.value!.tipo,
                            bottom: false,
                          ),
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
                            borderRadius: BorderRadius.circular(width * 0.01),
                          ),
                          child: Obx(
                            () => controller.text.value
                                ? TextWidget()
                                : controller.frame.value
                                    ? FrameColorWidget()
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
