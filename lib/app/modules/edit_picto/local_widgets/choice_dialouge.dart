import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/buy_paid_version_page.dart';
import 'package:ottaa_project_flutter/app/utils/CustomAnalytics.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';

class ChoiceDialogue extends GetView<EditPictoController> {
  ChoiceDialogue({Key? key, this.index}) : super(key: key);
  int? index;
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              if (_homeController.userSubscription == 1) {
                Get.toNamed(AppRoutes.EDITPICTO);
                CustomAnalyticsEvents.setEventWithParameters("Touch",
                    CustomAnalyticsEvents.createMyMap('name', 'Edit '));
              } else {
                _homeController.initializePageViewer();
                Get.to(() => BuyPaidVersionPage());
              }
            },
            child: Text('edit'.tr),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () async {
              if (_homeController.userSubscription == 1) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kOTTAAOrangeNew,
                        ),
                      );
                    });
                _pictogramController
                    .grupos[_pictogramController.selectedIndex].relacion
                    .removeWhere((element) =>
                        element.id == _homeController.pictToBeEdited.id);
                _homeController
                    .grupos[_pictogramController.selectedIndex].relacion
                    .removeWhere((element) =>
                        element.id == _homeController.pictToBeEdited.id);
                final dataGrupo = _homeController.grupos;
                List<String> fileDataGrupo = [];
                dataGrupo.forEach((element) {
                  final obj = jsonEncode(element);
                  fileDataGrupo.add(obj);
                });

                /// saving changes to file
                if (!kIsWeb) {
                  final localFile = LocalFileController();
                  await localFile.writeGruposToFile(
                    data: fileDataGrupo.toString(),
                    language: _homeController.language,
                  );
                  // print('writing to file');
                }
                //for the file data
                final instance = await SharedPreferences.getInstance();
                await instance.setBool('Grupos_file', true);
                // print(res1);
                //upload to the firebase
                await _pictogramController.uploadToFirebaseGrupo(
                  data: fileDataGrupo.toString(),
                );
                await _pictogramController.gruposExistsOnFirebase();
                _pictogramController.selectedGruposPicts.removeAt(index!);
                _pictogramController.pictoGridviewOrPageview.value =
                    !_pictogramController.pictoGridviewOrPageview.value;
                Future.delayed(
                  Duration(milliseconds: 300),
                );
                _pictogramController.pictoGridviewOrPageview.value =
                    !_pictogramController.pictoGridviewOrPageview.value;
                Get.back();
                Get.back();
              } else {
                _homeController.initializePageViewer();
                Get.to(() => BuyPaidVersionPage());
              }
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
