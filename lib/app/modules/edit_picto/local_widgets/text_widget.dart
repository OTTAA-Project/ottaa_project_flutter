import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class TextWidget extends GetView<EditPictoController> {
  TextWidget({Key? key}) : super(key: key);
  final _ttsController = Get.find<TTSController>();

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(verticalSize * 0.01),
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
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    focusColor: kOTTAAOrangeNew,
                    fillColor: kOTTAAOrangeNew,
                    hintText: "Name".tr,
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kOTTAAOrangeNew),
                    ),
                  ),
                  cursorColor: kOTTAAOrangeNew,
                  onChanged: (value) {
                    final lang = _ttsController.languaje;
                    if (lang == 'en') {
                      controller.pict.value!.texto.en = value;
                    } else {
                      controller.pict.value!.texto.es = value;
                    }
                  },
                ),
              ),
              SizedBox(
                width: verticalSize * 0.03,
              ),
              GestureDetector(
                onTap: () async =>
                    await _ttsController.speak(controller.nameController.text),
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
