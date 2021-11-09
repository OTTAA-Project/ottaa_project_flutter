import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/category_widget.dart';

class PictogramGroupsPage extends StatelessWidget {
  final _pictogramController = Get.find<PictogramGroupsController>();
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
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
          Icon(
            Icons.menu,
            size: 30,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        controller: _pictogramController.gridController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: 100,
                        itemBuilder: (context, index) => CategoryWidget(
                          index: index,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1,
                        ),
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
                          Icon(
                            Icons.search,
                            size: height * 0.1,
                            color: Colors.white,
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
                    onTap: () => _pictogramController.removeSomeScroll(),
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
                    onTap: () => _pictogramController.addSomeScroll(),
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
                    borderRadius: BorderRadius.circular(100)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 48,
                      left: 55,
                      child: Container(
                        color: Colors.white,
                        height: 75,
                        width: 70,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.contactless,
                        size: height * 0.2,
                        color: kOTTAOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
