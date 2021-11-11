import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_view_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/picto_search_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_pages.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/category_page_widget.dart';
import 'local_widgets/category_widget.dart';

class PictogramGroupsPage extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    print(_homeController.grupos.length);
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
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              _pictogramController.categoryGridviewOrPageview.value =
                  !_pictogramController.categoryGridviewOrPageview.value;
            },
            child: Icon(
              Icons.view_carousel,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
              padding: EdgeInsets.symmetric(horizontal: Get.width * .15),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _pictogramController
                                    .categoryGridviewOrPageview.value
                                ? 16
                                : Get.width * 0.13,
                            vertical: 16),

                        ///the whole view is extracted to another file
                        child: CategoryViewWidget(),
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
                          GestureDetector(
                            onTap: () async {
                              var result = await showSearch<String>(
                                context: context,
                                delegate: CustomDelegate(),
                              );
                             print(result);
                            },
                            child: Icon(
                              Icons.search,
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
                  color: kOTTAOrange,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                width: Get.width * 0.15,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        _pictogramController.categoryGridviewOrPageview.value
                            ? _pictogramController.removeSomeScroll(
                                _pictogramController.categoriesGridController)
                            : _pictogramController.gotoPreviousPage(
                                _pictogramController.categoriesPageController),
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
                width: Get.width * 0.15,
                height: height * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        _pictogramController.categoryGridviewOrPageview.value
                            ? _pictogramController.addSomeScroll(
                                _pictogramController.categoriesGridController)
                            : _pictogramController.gotoNextPage(
                                _pictogramController.categoriesPageController),
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
              left: Get.width * 0.43,
              right: Get.width * 0.43,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(height * 0.4),
                ),
                child: Image.asset(
                  'assets/icono_ottaa.webp',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
