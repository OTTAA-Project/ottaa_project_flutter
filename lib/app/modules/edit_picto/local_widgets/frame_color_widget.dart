import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../edit_picto_controller.dart';

class FrameColorWidget extends GetView<EditPictoController> {
  const FrameColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: height * 0.07,
          left: width * 0.02,
          child: Text(
            'fitzgerald_key'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
              fontSize: width * 0.02,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height * 0.28,
          child: ColorWidget(
            color: Colors.green,
            text: 'actions'.tr,
            tipo: 3,
          ),
        ),
        Positioned(
          top: height * 0.34,
          right: 0,
          left: -width * 0.12,
          child: ColorWidget(
            color: Colors.purple,
            text: 'interactions'.tr,
            tipo: 5,
          ),
        ),
        Positioned(
          top: height * 0.34,
          left: 0,
          right: -width * 0.12,
          child: ColorWidget(
            color: Colors.yellow,
            text: 'people'.tr,
            tipo: 1,
          ),
        ),
        Positioned(
          top: height * 0.45,
          right: 0,
          left: -width * 0.12,
          child: ColorWidget(
            color: kOTTAOrange,
            text: 'nouns'.tr,
            tipo: 2,
          ),
        ),
        Positioned(
          top: height * 0.45,
          left: 0,
          right: -width * 0.12,
          child: ColorWidget(
            color: Colors.blue,
            text: 'adjectives'.tr,
            tipo: 4,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height * 0.54,
          child: ColorWidget(
            color: Colors.black,
            text: 'miscellaneous'.tr,
            tipo: 6,
          ),
        ),
      ],
    );
  }
}

class ColorWidget extends StatelessWidget {
  ColorWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.tipo,
  }) : super(key: key);
  final Color color;
  final String text;
  final int tipo;
  final controller = Get.find<EditPictoController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        controller.pictoBorder.value = false;
        controller.pict.value!.tipo = tipo;
        controller.pictoBorder.value = true;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: width * 0.05,
            width: width * 0.05,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(text),
        ],
      ),
    );
  }
}
