import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class PictogramGroupsController extends GetxController {
  late ScrollController categoriesGridController;
  late ScrollController pictoGridController;
  late PageController categoriesPageController;
  late PageController pictoPageController;
  final _pictsRepository = Get.find<PictsRepository>();
  final _homeController = Get.find<HomeController>();
  List<Pict> picts = [];
  late Grupos selectedGrupos;
  List<Pict> selectedGruposPicts = [];
  RxBool pictoGridviewOrPageview = true.obs;
  RxBool categoryGridviewOrPageview = true.obs;
  String selectedPicto = '';

  void addSomeScroll(ScrollController controller) {
    controller.animateTo(controller.offset.toDouble() + 200,
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  void removeSomeScroll(ScrollController controller) {
    controller.animateTo(controller.offset.toDouble() - 200,
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  void gotoNextPage(PageController pageController) {
    pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void gotoPreviousPage(PageController pageController) {
    pageController.previousPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  Future<void> fetchDesiredPictos() async {
    selectedGruposPicts = [];
    for (int i = 0; i < selectedGrupos.relacion.length; i++) {
      picts.forEach((element) {
        if (element.id == selectedGrupos.relacion[i].id) {
          selectedGruposPicts.add(element);
        }
      });
    }
  }

  @override
  void onInit() async {
    categoriesGridController = ScrollController();
    pictoGridController = ScrollController();
    categoriesPageController = PageController();
    pictoPageController = PageController();
    await loadAssets();
    super.onInit();
  }

  @override
  void dispose() {
    categoriesGridController.dispose();
    super.dispose();
  }

  Future<void> loadAssets() async {
    this.picts = _homeController.picts;
  }
}
