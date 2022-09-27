import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/choice_dialouge.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category_page_widget.dart';
import 'category_widget.dart';

class PictoPageWidget extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();
  final _dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    final languaje = _ttsController.languaje;
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Obx(
      () => _pictogramController.pictoGridviewOrPageview.value
          ? GridView.builder(
              controller: _pictogramController.pictoGridController,
              padding: EdgeInsets.symmetric(vertical: verticalSize * 0.05),
              itemCount: _pictogramController.selectedGruposPicts.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  await onTap(index, languaje);
                },
                onLongPress: () {
                  _homeController.pictToBeEdited =
                      _pictogramController.selectedGruposPicts[index];
                  print(_homeController.pictToBeEdited.id);
                  showDialog(
                    context: context,
                    builder: (context) => ChoiceDialogue(index: index),
                  );
                  // Get.toNamed(AppRoutes.EDITPICTO);
                },
                child: CategoryWidget(
                  name: _pictogramController.selectedGruposPicts[index].texto,
                  imageName: _pictogramController
                              .selectedGruposPicts[index].imagen.pictoEditado ==
                          null
                      ? _pictogramController
                          .selectedGruposPicts[index].imagen.picto
                      : _pictogramController
                          .selectedGruposPicts[index].imagen.pictoEditado!,
                  border: true,
                  bottom: false,
                  color: _pictogramController.selectedGruposPicts[index].tipo,
                  languaje: _homeController.language,
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
            )
          : PageView.builder(
              physics: PageScrollPhysics(),
              controller: _pictogramController.pictoPageController,
              scrollDirection: Axis.horizontal,
              itemCount: _pictogramController.selectedGruposPicts.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  await onTap(index, languaje);
                },
                onLongPress: () {
                  _homeController.pictToBeEdited =
                      _pictogramController.selectedGruposPicts[index];
                  showDialog(
                    context: context,
                    builder: (context) => ChoiceDialogue(index: index),
                  );
                  // Get.toNamed(AppRoutes.EDITPICTO);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.07),
                  child: CategoryPageWidget(
                    name: _pictogramController.selectedGruposPicts[index].texto,
                    language: _homeController.language,
                    imageName: _pictogramController
                        .selectedGruposPicts[index].imagen.picto,
                    border: true,
                    color: _pictogramController.selectedGruposPicts[index].tipo,
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> onTap(int index, String languaje) async {
    //saying the name after selecting the category
    switch (_homeController.language) {
      case "es-AR":
        _ttsController
            .speak(_pictogramController.selectedGruposPicts[index].texto.es);
        break;
      case "en-US":
        _ttsController
            .speak(_pictogramController.selectedGruposPicts[index].texto.en);
        break;
      case "fr-FR":
        _ttsController
            .speak(_pictogramController.selectedGruposPicts[index].texto.fr);
        break;
      case "pt-BR":
        _ttsController
            .speak(_pictogramController.selectedGruposPicts[index].texto.pt);
        break;
      default:
        _ttsController
            .speak(_pictogramController.selectedGruposPicts[index].texto.es);
    }
    // _ttsController.speak(languaje == "en-US"
    //     ? _pictogramController.selectedGruposPicts[index].texto.en
    //     : _pictogramController.selectedGruposPicts[index].texto.es);
    //add to the sentence
    if (_pictogramController.selectedPicto ==
        _pictogramController.selectedGruposPicts[index].texto.en) {
      await _homeController
          .addPictToSentence(_pictogramController.selectedGruposPicts[index]);
      _homeController.fromAdd = false;
      final data = _homeController.picts;
      List<String> fileData = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileData.add(obj);
      });
      if (!kIsWeb) {
        final localFile = LocalFileController();
        await localFile.writePictoToFile(
          data: fileData.toString(),
          language: _ttsController.languaje,
        );
        print('writing to file');
      }
      //for the file data
      final instance = await SharedPreferences.getInstance();
      await instance.setBool('Pictos_file', true);
      final res1 = instance.getBool('Pictos_file') ?? false;

      print(res1);
      //upload to the firebase
      uploadToFirebase(data: fileData.toString());
      pictsExistsOnFirebase();
      _pictogramController.selectedPicto = '';
      Get.back();
      Get.back();
    }

    ///add it to the variable and punch it in after second hit
    _pictogramController.selectedPicto =
        _pictogramController.selectedGruposPicts[index].texto.en;
    // Get.toNamed(AppRoutes.SELECTPICTO);
  }

  Future<void> uploadToFirebase({required String data}) async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Picto/${auth!.uid}/');
    // await ref.set({
    //   'data': data,
    // });
    await _dataController.uploadDataToFirebaseRealTime(
      data: data,
      type: 'Pictos',
      languageCode: _ttsController.languaje,
    );
  }

  Future<void> pictsExistsOnFirebase() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    // await ref.set({
    //   'value': true,
    // });
    await _dataController.uploadBoolToFirebaseRealtime(
      data: true,
      type: 'PictsExistsOnFirebase',
    );
  }
}
