import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/local_widgets/frame_color_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';

import '../../theme/app_theme.dart';
import '../edit_picto/local_widgets/icon_widget.dart';

class AddGroupPage extends GetView<PictogramGroupsController> {
  const AddGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAOrangeNew,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        centerTitle: false,
        title: Text('Add Group'),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(horizontalSize * 0.01),
                      ),
                    ),
                    SizedBox(
                      width: horizontalSize * 0.01,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(horizontalSize * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: FrameColorWidget(
                          onTap: ({int? tipo}) {
                            print(tipo);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: horizontalSize * 0.01),
                color: kOTTAOrangeNew,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconWidget(
                      onTap: () {},
                      iconData: Icons.edit,
                      text: 'text'.tr,
                    ),
                    IconWidget(
                      onTap: () {},
                      iconData: Icons.assistant,
                      text: 'tags'.tr,
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
