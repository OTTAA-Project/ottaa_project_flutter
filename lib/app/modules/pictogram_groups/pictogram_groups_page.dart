import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/category_view_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/picto_search_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../../utils/CustomAnalytics.dart';
import 'local_widgets/otta_logo_widget.dart';

class PictogramGroupsPage extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('GaleriaGrupos'),
        actions: [
          // GestureDetector(
          //     onTap: () => {
          //           CustomAnalyticsEvents.setEventWithParameters(
          //               "Touch",
          //               CustomAnalyticsEvents.createMyMap(
          //                   'Group Gallery', 'Change View'))
          //         },
          //     child: Icon(
          //       Icons.reorder,
          //       size: 30,
          //     )),
          // const SizedBox(
          //   width: 8,
          // ),
          GestureDetector(
            onTap: () {
              _pictogramController.categoryGridviewOrPageview.value =
                  !_pictogramController.categoryGridviewOrPageview.value;
              CustomAnalyticsEvents.setEventWithParameters(
                  "Touch",
                  CustomAnalyticsEvents.createMyMap(
                      'Group Gallery', 'Change View'));
            },
            child: Icon(
              Icons.view_carousel,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap(
                        'Group Gallery', 'Add Group'));
                Get.toNamed(AppRoutes.ADDGROUP);
              },
              child: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     print(_homeController.grupos.last.imagen.picto);
          //     CustomAnalyticsEvents.setEventWithParameters(
          //         "Touch",
          //         CustomAnalyticsEvents.createMyMap(
          //             'Group Gallery', 'Syncronize Pictogram'));
          //   },
          //   child: Icon(
          //     Icons.cloud_download,
          //     size: 30,
          //   ),
          // ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              // height: Get.height * 0.7,
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * .10),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                        // color: Colors.pink,
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
                          Container(),

                          /// for keeping them in order and the button will be in separate Positioned
                          Container(),
                          GestureDetector(
                            onTap: () async {
                              CustomAnalyticsEvents.setEventWithParameters(
                                  "Touch",
                                  CustomAnalyticsEvents.createMyMap(
                                      'Group Gallery', 'Search Pictogram'));

                              var result = await showSearch<String>(
                                context: context,
                                delegate: CustomDelegate(),
                              );
                              print(result);
                            },
                            child: Icon(
                              Icons.search,
                              size: verticalSize * 0.1,
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

            ///left one
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
                width: horizontalSize * 0.10,
                height: verticalSize * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () => {
                      _pictogramController.categoryGridviewOrPageview.value
                          ? _pictogramController.removeSomeScroll(
                              _pictogramController.categoriesGridController)
                          : _pictogramController.gotoPreviousPage(
                              _pictogramController.categoriesPageController),
                      CustomAnalyticsEvents.setEventWithParameters(
                          "Touch",
                          CustomAnalyticsEvents.createMyMap(
                              'Group Gallery', 'Foward Button'))
                    },
                    child: Icon(
                      Icons.skip_previous,
                      size: verticalSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            ///right one
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
                width: horizontalSize * 0.10,
                height: verticalSize * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () => {
                      _pictogramController.categoryGridviewOrPageview.value
                          ? _pictogramController.addSomeScroll(
                              _pictogramController.categoriesGridController)
                          : _pictogramController.gotoNextPage(
                              _pictogramController.categoriesPageController),
                      CustomAnalyticsEvents.setEventWithParameters(
                          "Touch",
                          CustomAnalyticsEvents.createMyMap(
                              'Group Gallery', 'Next Button'))
                    },
                    child: Icon(
                      Icons.skip_next,
                      size: verticalSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            /// main data widget
            Positioned(
              left: 0,
              right: 0,
              bottom: verticalSize * 0.17,
              child: Obx(
                () => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.099),
                  child: Container(
                    height: verticalSize * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          _pictogramController.categoryGridviewOrPageview.value
                              ? horizontalSize * 0.02
                              : horizontalSize * 0.13,
                      vertical: 16,
                    ),
                    // width: horizontalSize * 0.8,
                    child: CategoryViewWidget(),
                  ),
                ),
              ),
            ),

            /// the play button
            Positioned(
              bottom: verticalSize * 0.02,
              left: horizontalSize * 0.43,
              right: horizontalSize * 0.43,
              child: Obx(
                () => GestureDetector(
                  onTap: _pictogramController.categoryGridviewOrPageview.value
                      ? () {}
                      : () async {
                          //saying the name after selecting the category
                          //saying the name after selecting the category and saving the selected group
                          _pictogramController.selectedGrupos =
                              _homeController.grupos[_pictogramController
                                  .categoriesPageController.page!
                                  .toInt()];
                          _ttsController.speak(_ttsController.languaje ==
                                  "en-US"
                              ? _homeController
                                  .grupos[_pictogramController
                                      .categoriesPageController.page!
                                      .toInt()]
                                  .texto
                                  .en
                              : _homeController
                                  .grupos[_pictogramController
                                      .categoriesPageController.page!
                                      .toInt()]
                                  .texto
                                  .es);
                          await _pictogramController.fetchDesiredPictos();
                          CustomAnalyticsEvents.setEventWithParameters(
                              "Touch",
                              CustomAnalyticsEvents.createMyMap(
                                  'Group Gallery', 'Pictograms Gallery'));
                          Get.toNamed(AppRoutes.SELECTPICTO);
                        },
                  child: OttaLogoWidget(),
                ),
              ),
            ),

            /// close button
            Positioned(
              left: horizontalSize * 0.27,
              bottom: verticalSize * 0.04,
              child: GestureDetector(
                onTap: () => {
                  CustomAnalyticsEvents.setEventWithParameters(
                      "Touch",
                      CustomAnalyticsEvents.createMyMap(
                          'Group Gallery', 'Backpress Button')),
                  Get.back()
                },
                child: Icon(
                  Icons.cancel,
                  size: verticalSize * 0.1,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
