import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class AddGroupTextWidget extends GetView<PictogramGroupsController> {
  const AddGroupTextWidget({
    Key? key,
    required this.controllerTxt,
  }) : super(key: key);
  final TextEditingController controllerTxt;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'text'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: verticalSize * 0.03),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalSize * 0.03),
            child: Text(
              'text_widget_long_1'.tr,
              style: TextStyle(),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controllerTxt,
                  decoration: InputDecoration(
                    focusColor: kOTTAOrangeNew,
                    fillColor: kOTTAOrangeNew,
                    hintText: "Name".tr,
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kOTTAOrangeNew),
                    ),
                  ),
                  cursorColor: kOTTAOrangeNew,
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: verticalSize * 0.03,
              ),
              GestureDetector(
                onTap: () async =>
                    await controller.ttsController.speak(controllerTxt.text),
                child: Image.asset(
                  'assets/icono_ottaa.webp',
                  fit: BoxFit.cover,
                  height: verticalSize * 0.06,
                  width: verticalSize * 0.06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
