import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/icon_widget.dart';

class RightColumnWidget extends GetView<EditPictoController> {
  const RightColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: horizontalSize * 0.01),
        color: kOTTAOrangeNew,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWidget(
              onTap: () {
                controller.text.value = true;
                controller.frame.value = false;
                controller.tags.value = false;
              },
              iconData: Icons.edit,
              text: 'text'.tr,
            ),
            IconWidget(
              onTap: () {
                controller.text.value = false;
                controller.frame.value = true;
                controller.tags.value = false;
              },
              iconData: Icons.border_outer,
              text: 'frame'.tr,
            ),
            IconWidget(
              onTap: () {
                controller.text.value = false;
                controller.frame.value = false;
                // controller.tags.value = true;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TAGs will come in next Release',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: verticalSize * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              iconData: Icons.assistant,
              text: 'tags'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
