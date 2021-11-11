import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';

import 'category_page_widget.dart';
import 'category_widget.dart';

class PictoPageWidget extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _pictogramController.pictoGridviewOrPageview.value
          ? GridView.builder(
              controller: _pictogramController.pictoGridController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _pictogramController.selectedGruposPicts.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: ()async{
                  await onTap(index);
                },
                child: CategoryWidget(
                  name:
                      _pictogramController.selectedGruposPicts[index].texto.en,
                  imageName: _pictogramController
                      .selectedGruposPicts[index].imagen.picto,
                  border: true,
                  bottom: false,
                  color : _pictogramController.selectedGruposPicts[index].tipo,
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
              onTap: ()async{
                await onTap(index);
              },
              child: CategoryPageWidget(
                name: _pictogramController
                    .selectedGruposPicts[index].texto.en,
                imageName: _pictogramController
                    .selectedGruposPicts[index].imagen.picto,
                border: true,
                color: _pictogramController.selectedGruposPicts[index].tipo,
              ),
            ),
          ),
    );
  }

  Future<void> onTap(int index)async{
    //saying the name after selecting the category
    _ttsController.speak(
        _pictogramController.selectedGruposPicts[index].texto.en);
    //add to the sentence
    if(_pictogramController.selectedPicto == _pictogramController.selectedGruposPicts[index].texto.en){
      await _homeController.addPictToSentence(
          _pictogramController.selectedGruposPicts[index]);
      Get.back();
      Get.back();
    }
    ///add it to the variable and punch it in after second hit
    _pictogramController.selectedPicto = _pictogramController.selectedGruposPicts[index].texto.en;
    // Get.toNamed(AppRoutes.SELECTPICTO);
  }
}
