import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'local_widgets/add_picto_to_group_widget.dart';
import 'local_widgets/otta_logo_widget.dart';

class AddPictoToGroupPage extends GetView<PictogramGroupsController> {
  AddPictoToGroupPage({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('OTTAA PROJECT'),
        actions: [],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              // height: Get.height * 0.7,
              padding: EdgeInsets.symmetric(horizontal: width * .10),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: GridView.builder(
                      controller: controller.addPictoGridController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: controller.pictsForGroupAdding.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedList[index].value =
                                !controller.selectedList[index].value;
                          },
                          child: Obx(
                            () => AddPictoToGroupWidget(
                              color: controller.pictsForGroupAdding[index].tipo,
                              name: controller.ttsController.languaje == 'en-US'
                                  ? controller
                                      .pictsForGroupAdding[index].texto.en
                                  : controller
                                      .pictsForGroupAdding[index].texto.es,
                              image: controller.pictsForGroupAdding[index]
                                          .imagen.pictoEditado !=
                                      null
                                  ? controller.pictsForGroupAdding[index].imagen
                                      .pictoEditado!
                                  : controller
                                      .pictsForGroupAdding[index].imagen.picto,
                              isSelected: controller.selectedList[index].value,
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.90,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: kOTTAAOrangeNew,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: () => {Get.back()},
                            child: Icon(
                              Icons.cancel,
                              size: height * 0.1,
                              color: Colors.white,
                            ),
                          ),

                          /// for keeping them in order and the button will be in separate Positioned

                          Container(),
                          GestureDetector(
                            onTap: () async {
                              showDialog<void>(
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                context: context,
                              );
                              List<Pict> toBeAddedonToCurrentList = [];
                              int index = -1;
                              controller.grupos.firstWhere((element) {
                                index++;
                                return element.id ==
                                    controller.selectedGrupos.id;
                              });
                              print('the group index is $index');
                              int index2 = -1;
                              controller.pictsForGroupAdding.forEach((element) {
                                index2++;
                                if (controller.selectedList[index2].value ==
                                    true) {
                                  _homeController.grupos[index].relacion.add(
                                    GrupoRelacion(
                                      id: controller
                                          .pictsForGroupAdding[index2].id,
                                      frec: 0,
                                    ),
                                  );
                                  toBeAddedonToCurrentList.add(
                                      controller.pictsForGroupAdding[index2]);
                                  print(controller
                                      .pictsForGroupAdding[index2].texto.en);
                                }
                              });
                              final data = _homeController.grupos;
                              List<String> fileData = [];
                              data.forEach((element) {
                                final obj = jsonEncode(element);
                                fileData.add(obj);
                              });

                              /// saving changes to file
                             /* if (!kIsWeb) {
                                final localFile = LocalFileController();
                                await localFile.writeGruposToFile(
                                  data: fileData.toString(),
                                  language: _homeController.language,
                                );
                                // print('writing to file');
                              }
                              //for the file data
                              final instance =
                                  await SharedPreferences.getInstance();
                              await instance.setBool(
                                  "${Constants.LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!}_grupo",
                                  true);*/
                              // print(res1);
                              //upload to the firebase
                              await controller.uploadToFirebaseGrupo(
                                data: data,
                              );
                              // await controller.gruposExistsOnFirebase();
                              //change the view and add values to the current list
                              controller.selectedGruposPicts
                                  .addAll(toBeAddedonToCurrentList);
                              controller.pictoGridviewOrPageview.value =
                                  !controller.pictoGridviewOrPageview.value;
                              controller.pictoGridviewOrPageview.value =
                                  !controller.pictoGridviewOrPageview.value;
                              controller.selectedList = List.generate(
                                  _homeController.picts.length,
                                  (index) => false.obs,
                                  growable: true);
                              print(controller.selectedGruposPicts.length);
                              controller.secondTimeSameGroup =
                                  controller.selectedGroupIndex;
                              Get.close(2);
                            },
                            child: Icon(
                              Icons.save,
                              size: height * 0.1,
                              color: Colors.white,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //left one
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: kOTTAAOrangeNew,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                width: width * 0.10,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () => {
                      controller.pictoGridviewOrPageview.value
                          ? controller
                              .removeSomeScroll(controller.pictoGridController)
                          : controller
                              .gotoPreviousPage(controller.pictoPageController)
                    },
                    child: Icon(
                      Icons.skip_previous,
                      size: height * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //right one
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: kOTTAAOrangeNew,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                  ),
                ),
                width: width * 0.10,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () => {
                      controller.pictoGridviewOrPageview.value
                          ? controller
                              .addSomeScroll(controller.pictoGridController)
                          : controller
                              .gotoNextPage(controller.pictoPageController),
                    },
                    child: Icon(
                      Icons.skip_next,
                      size: height * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            /// the play button
            Positioned(
              bottom: height * 0.02,
              left: width * 0.43,
              right: width * 0.43,
              child: OttaaLogoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
