
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PictogramGroupsController extends GetxController{

  late ScrollController gridController;


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