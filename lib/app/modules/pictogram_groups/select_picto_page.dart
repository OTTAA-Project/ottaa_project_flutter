import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_page_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/category_widget.dart';
import 'local_widgets/picto_page_widget.dart';

class SelectPictoPage extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();
  final _pictogramController = Get.find<PictogramGroupsController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAOrange,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('GaleriaGrupos'),
        actions: [
          Icon(
            Icons.reorder,
            size: 30,
          ),
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              _pictogramController.pictoGridviewOrPageview.value =
                  !_pictogramController.pictoGridviewOrPageview.value;
            },
            child: Icon(
              Icons.view_carousel,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
          ),
          Icon(
            Icons.cloud_download,
            size: 30,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        //todo: change the color
        color: Colors.grey[700],
        child: Stack(
          children: [
            Container(
              // height: Get.height * 0.7,
              padding: EdgeInsets.symmetric(horizontal: width * .15),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _pictogramController
                                    .pictoGridviewOrPageview.value
                                ? 16
                                : width * 0.16,
                            vertical: 16),
                        child: PictoPageWidget(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: kOTTAOrange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.cancel,
                              size: height * 0.1,
                              color: Colors.white,
                            ),
                          ),

                          /// for keeping them in order and the button will be in separate Positioned
                          Container(),
                          Container(),
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
                  color: kOTTAOrange,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                width: width * 0.15,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        _pictogramController.pictoGridviewOrPageview.value
                            ? _pictogramController.removeSomeScroll(
                                _pictogramController.pictoGridController)
                            : _pictogramController.gotoPreviousPage(
                                _pictogramController.pictoPageController),
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
                  color: kOTTAOrange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                  ),
                ),
                width: width * 0.15,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        _pictogramController.pictoGridviewOrPageview.value
                            ? _pictogramController.addSomeScroll(
                                _pictogramController.pictoGridController)
                            : _pictogramController.gotoNextPage(
                                _pictogramController.pictoPageController),
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
              bottom: height * 0.05,
              left: width * 0.43,
              right: width * 0.43,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(width *0.1),
                ),
                child: FittedBox(
                  child: Image.asset(
                    'assets/icono_ottaa.webp',
                    fit: BoxFit.cover,
                    // height: width * 0.2,
                    // width: width * 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
