import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
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
                onTap: () async {
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
