import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/global_controllers.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/buy_paid_version_page.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_grupo_page/edit_grupo_page.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/utils/custom_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceDialogue extends GetView<EditPictoController> {
  ChoiceDialogue({Key? key}) : super(key: key);
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
              // Get.toNamed(AppRoutes.EDITPICTO);
              if (_homeController.userSubscription == 1) {
                _pictogramController.grupoEditNameController.text = 'en'.toUpperCase() == _pictogramController.lang.toUpperCase() ? _pictogramController.grupoToEdit.texto.en : _pictogramController.grupoToEdit.texto.es;
                print(_pictogramController.grupoToEdit.texto.en.toUpperCase());
                print(_pictogramController.lang.toUpperCase());
                Get.to(() => const EditGrupoPage());
                CustomAnalyticsEvents.setEventWithParameters("Touch", CustomAnalyticsEvents.createMyMap('name', 'Edit '));
                CustomAnalyticsEvents.setEventWithParameters("Touch", CustomAnalyticsEvents.createMyMap('name', 'Edit '));
              } else {
                _homeController.initializePageViewer();
                Get.to(() => const BuyPaidVersionPage());
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
                _pictogramController.grupos.removeWhere((element) => _pictogramController.grupoToEdit.id == element.id);
                _homeController.grupos.removeWhere((element) => _pictogramController.grupoToEdit.id == element.id);
                _pictogramController.categoryGridviewOrPageview.value = !_pictogramController.categoryGridviewOrPageview.value;
                _pictogramController.categoryGridviewOrPageview.value = !_pictogramController.categoryGridviewOrPageview.value;
                final dataGrupos = _homeController.grupos;
                List<String> fileDataGrupo = [];
                for (var dataGrupo in dataGrupos) {
                  final dataGrupoObj = jsonEncode(dataGrupo);
                  fileDataGrupo.add(dataGrupoObj);
                }

                /// saving changes to file
                if (!kIsWeb) {
                  final localFile = LocalFileController();
                  await localFile.writeGruposToFile(
                    data: fileDataGrupo.toString(),
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
                Get.back();
              } else {
                _homeController.initializePageViewer();
                Get.to(() => const BuyPaidVersionPage());
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
