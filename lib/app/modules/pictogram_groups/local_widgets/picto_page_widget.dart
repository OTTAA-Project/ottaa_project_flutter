import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/choice_dialouge.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_page_widget.dart';
import 'category_widget.dart';

class PictoPageWidget extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final languaje = _ttsController.languaje;
    return Obx(
      () => _pictogramController.pictoGridviewOrPageview.value
          ? GridView.builder(
              controller: _pictogramController.pictoGridController,
              padding: const EdgeInsets.symmetric(vertical: 8),
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
                    builder: (context) => ChoiceDialogue(),
                  );
                  // Get.toNamed(AppRoutes.EDITPICTO);
                },
                child: CategoryWidget(
                  name: languaje == "en"
                      ? _pictogramController.selectedGruposPicts[index].texto.en
                      : _pictogramController
                          .selectedGruposPicts[index].texto.es,
                  imageName: _pictogramController
                      .selectedGruposPicts[index].imagen.picto,
                  border: true,
                  bottom: false,
                  color: _pictogramController.selectedGruposPicts[index].tipo,
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.90,
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
                  Get.toNamed(AppRoutes.EDITPICTO);
                },
                child: CategoryPageWidget(
                  name: languaje == "en"
                      ? _pictogramController.selectedGruposPicts[index].texto.en
                      : _pictogramController
                          .selectedGruposPicts[index].texto.es,
                  imageName: _pictogramController
                      .selectedGruposPicts[index].imagen.picto,
                  border: true,
                  color: _pictogramController.selectedGruposPicts[index].tipo,
                ),
              ),
            ),
    );
  }

  Future<void> onTap(int index, String languaje) async {
    //saying the name after selecting the category
    _ttsController.speak(languaje == "en"
        ? _pictogramController.selectedGruposPicts[index].texto.en
        : _pictogramController.selectedGruposPicts[index].texto.es);
    //add to the sentence
    if (_pictogramController.selectedPicto ==
        _pictogramController.selectedGruposPicts[index].texto.en) {
      await _homeController
          .addPictToSentence(_pictogramController.selectedGruposPicts[index]);
      _homeController.addId =
          _pictogramController.selectedGruposPicts[index].id;

      if (_homeController.fromAdd) {
        // //fetch the value of id to which we will be adding relation
        // _homeController.toId = _homeController.sentencePicts.last.id;
        // fetch the picto from which you want to add relation
        int pictToAddedIndex = -1;
        final pictToAdded = _homeController.picts.firstWhere((e) {
          pictToAddedIndex++;
          return e.id == _homeController.toId;
        });
        //find the relacions and check for the null and others
        final lengthOfRelacion =
            _homeController.picts[pictToAddedIndex].relacion!.length;
        print(lengthOfRelacion);
        final pictFromAdded = _homeController.picts
            .firstWhere((e) => e.id == _homeController.addId);
        print(pictFromAdded.texto.en);
        if (lengthOfRelacion == 0) {
          _homeController.picts[pictToAddedIndex].relacion!.add(
            Relacion(id: pictFromAdded.id, frec: 1),
          );
        } else {
          int relacionIndex = -1;
          final res = _homeController.picts[pictToAddedIndex].relacion!
              .contains((Relacion e) {
            relacionIndex++;
            return e.id == pictFromAdded.id;
          });
          print(res);
          if (res) {
            _homeController
                .picts[pictToAddedIndex].relacion![relacionIndex].frec++;
          } else {
            _homeController.picts[pictToAddedIndex].relacion!.add(
              Relacion(id: pictFromAdded.id, frec: 1),
            );
          }
        }
        print(pictToAdded.texto.en);
        _homeController.fromAdd = false;
        final data = _homeController.picts;
        List<String> fileData = [];
        data.forEach((element) {
          final obj = jsonEncode(element);
          fileData.add(obj);
        });
        if (!kIsWeb) {
          final localFile = LocalFileController();
          await localFile.writePictoToFile(data: fileData.toString());
          print('writing to file');
        }
        //for the file data
        final instance = await SharedPreferences.getInstance();
        await instance.setBool('Pictos_file', true);
        final res1 = instance.getBool('Pictos_file') ?? false;

        print(res1);
        //upload to the firebase
        await uploadToFirebase(data: fileData.toString());
        await pictsExistsOnFirebase();
      }
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
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Picto/${auth!.uid}/');
    await ref.set({
      'data': data,
    });
  }

  Future<void> pictsExistsOnFirebase() async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    await ref.set({
      'value': true,
    });
  }
}
