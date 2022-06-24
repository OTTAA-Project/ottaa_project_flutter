import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/buy_paid_version_page.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_grupo_page/edit_grupo_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../global_controllers/local_file_controller.dart';
import '../../../utils/CustomAnalytics.dart';
import '../../edit_picto/edit_picto_controller.dart';
import 'category_page_widget.dart';
import 'category_widget.dart';

class CategoryViewWidget extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();

  @override
  Widget build(BuildContext context) {
    final languaje = _ttsController.languaje;
    return Obx(
      () => _pictogramController.categoryGridviewOrPageview.value
          ? GridView.builder(
              controller: _pictogramController.categoriesGridController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _homeController.grupos.length,
              itemBuilder: (context, index) => GestureDetector(
                onLongPress: () async {
                  _pictogramController.grupoToEdit =
                      _homeController.grupos[index];
                  showDialog(
                    context: context,
                    builder: (context) => ChoiceDialogue(),
                  );
                },
                onTap: () async {
                  //saying the name after selecting the category and saving the selected grupo
                  _pictogramController.selectedGrupos =
                      _homeController.grupos[index];
                  _pictogramController.selectedIndex = index;
                  print(_pictogramController.selectedIndex);
                  _ttsController.speak(languaje == "en"
                      ? _homeController.grupos[index].texto.en
                      : _homeController.grupos[index].texto.es);
                  await _pictogramController.fetchDesiredPictos();
                  // if (_pictogramController.secondTimeSameGroup ==
                  //     _pictogramController.selectedGroupIndex) {
                  // } else {
                  //   _pictogramController.selectedGrupos.relacion.forEach((e1) {
                  //     _pictogramController.pictsForGroupAdding
                  //         .removeWhere((e2) => e1.id == e2.id);
                  //   });
                  // }
                  // print(_pictogramController.selectedGruposPicts.length);
                  Get.toNamed(AppRoutes.SELECTPICTO);
                },
                child: CategoryWidget(
                  name: languaje == 'en'
                      ? _homeController.grupos[index].texto.en
                      : _homeController.grupos[index].texto.es,
                  imageName: _homeController.grupos[index].imagen.picto,
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
            )
          : PageView.builder(
              // physics: PageScrollPhysics(),
              controller: _pictogramController.categoriesPageController,
              scrollDirection: Axis.horizontal,
              itemCount: _homeController.grupos.length,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 9 / 16,
                child: GestureDetector(
                  onLongPress: () async {
                    _pictogramController.grupoToEdit =
                        _homeController.grupos[index];
                    showDialog(
                      context: context,
                      builder: (context) => ChoiceDialogue(),
                    );
                  },
                  onTap: () async {
                    //saying the name after selecting the category
                    //saying the name after selecting the category and saving the selected grupo
                    _pictogramController.selectedGrupos =
                        _homeController.grupos[index];
                    _ttsController.speak(languaje == "en"
                        ? _homeController.grupos[index].texto.en
                        : _homeController.grupos[index].texto.es);
                    await _pictogramController.fetchDesiredPictos();
                    // if (_pictogramController.secondTimeSameGroup ==
                    //     _pictogramController.selectedGroupIndex) {
                    // } else {
                    //   _pictogramController.selectedGrupos.relacion
                    //       .forEach((e1) {
                    //     _pictogramController.pictsForGroupAdding
                    //         .removeWhere((e2) => e1.id == e2.id);
                    //   });
                    // }
                    print(_pictogramController.selectedGruposPicts.length);
                    Get.toNamed(AppRoutes.SELECTPICTO);
                  },
                  child: CategoryPageWidget(
                    name: languaje == 'en'
                        ? _homeController.grupos[index].texto.en
                        : _homeController.grupos[index].texto.es,
                    imageName: _homeController.grupos[index].imagen.picto,
                  ),
                ),
              ),
            ),
    );
  }
}

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
                _pictogramController.grupoEditNameController.text =
                    'en'.toUpperCase() ==
                            _pictogramController.lang.toUpperCase()
                        ? _pictogramController.grupoToEdit.texto.en
                        : _pictogramController.grupoToEdit.texto.es;
                print(_pictogramController.grupoToEdit.texto.en.toUpperCase());
                print(_pictogramController.lang.toUpperCase());
                Get.to(() => EditGrupoPage());
                CustomAnalyticsEvents.setEventWithParameters("Touch",
                    CustomAnalyticsEvents.createMyMap('name', 'Edit '));
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
                _pictogramController.grupos.removeWhere((element) =>
                    _pictogramController.grupoToEdit.id == element.id);
                _homeController.grupos.removeWhere((element) =>
                    _pictogramController.grupoToEdit.id == element.id);
                _pictogramController.categoryGridviewOrPageview.value =
                    !_pictogramController.categoryGridviewOrPageview.value;
                _pictogramController.categoryGridviewOrPageview.value =
                    !_pictogramController.categoryGridviewOrPageview.value;
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
