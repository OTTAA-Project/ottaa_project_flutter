import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/add_pict_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/add_picto_to_group_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../../utils/CustomAnalytics.dart';
import 'local_widgets/picto_page_widget.dart';

class SelectPictoPage extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();

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
              CustomAnalyticsEvents.setEventWithParameters(
                  "Touch",
                  CustomAnalyticsEvents.createMyMap(
                      'Pictograms Gallery', 'Change View'));
            },
            child: Icon(
              Icons.view_carousel,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => AddPictoPage(),
                );
              },
              child: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => AddPictoToGroupPage(),
              );
            },
            child: Icon(
              Icons.add_to_photos,
              size: 30,
            ),
          ),
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
              padding: EdgeInsets.symmetric(horizontal: width * .10),
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
                      color: kOTTAAOrangeNew,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: () => {
                              CustomAnalyticsEvents.setEventWithParameters(
                                  "Touch",
                                  CustomAnalyticsEvents.createMyMap(
                                      'Pictograms Gallery',
                                      'Backpress Button')),
                              Get.back()
                            },
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
                      _pictogramController.pictoGridviewOrPageview.value
                          ? _pictogramController.removeSomeScroll(
                              _pictogramController.pictoGridController)
                          : _pictogramController.gotoPreviousPage(
                              _pictogramController.pictoPageController),
                      CustomAnalyticsEvents.setEventWithParameters(
                          "Touch",
                          CustomAnalyticsEvents.createMyMap(
                              'Pictograms Gallery', 'Foward Button'))
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
                      _pictogramController.pictoGridviewOrPageview.value
                          ? _pictogramController.addSomeScroll(
                              _pictogramController.pictoGridController)
                          : _pictogramController.gotoNextPage(
                              _pictogramController.pictoPageController),
                      CustomAnalyticsEvents.setEventWithParameters(
                          "Touch",
                          CustomAnalyticsEvents.createMyMap(
                              'Pictograms Gallery', 'Next Button'))
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
              child: OttaLogoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
