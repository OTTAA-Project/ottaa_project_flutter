
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class PictogramGroupsController extends GetxController{

  late ScrollController gridController;

  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();
  final _homeController = Get.find<HomeController>();



  void addSomeScroll(){
    gridController.animateTo(gridController.offset.toDouble() + 200, duration: Duration(milliseconds: 100), curve: Curves.ease);
  }
  void removeSomeScroll(){
    gridController.animateTo(gridController.offset.toDouble() - 200, duration: Duration(milliseconds: 100), curve: Curves.ease);
  }


  @override
  void onInit() {
    gridController = ScrollController();
    super.onInit();
  }
  @override
  void dispose() {
    gridController.dispose();
    super.dispose();
  }
}