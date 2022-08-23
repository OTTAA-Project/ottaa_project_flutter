import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../edit_picto_controller.dart';

class FrameColorWidget extends GetView<EditPictoController> {
  const FrameColorWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function({int? tipo})? onTap;

  @override
  Widget build(BuildContext context) {
    final horizontalSIze = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: verticalSize * 0.02,
          left: horizontalSIze * 0.01,
          child: Text(
            'fitzgerald_key'.tr,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: verticalSize * 0.03),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: verticalSize * 0.2,
          child: ColorWidget(
            color: Colors.green,
            text: 'actions'.tr,
            tipo: 3,
            onTap: () => onTap!(tipo: 3),
          ),
        ),
        Positioned(
          top: verticalSize * 0.35,
          right: 0,
          left: -horizontalSIze * 0.2,
          child: ColorWidget(
            color: Colors.purple,
            text: 'interactions'.tr,
            tipo: 5,
            onTap: () => onTap!(tipo: 5),
          ),
        ),
        Positioned(
          top: verticalSize * 0.35,
          left: 0,
          right: -horizontalSIze * 0.2,
          child: ColorWidget(
            color: Colors.yellow,
            text: 'people'.tr,
            tipo: 1,
            onTap: () => onTap!(tipo: 1),
          ),
        ),
        Positioned(
          top: verticalSize * 0.5,
          right: 0,
          left: -horizontalSIze * 0.2,
          child: ColorWidget(
            color: kOTTAAOrange,
            text: 'nouns'.tr,
            tipo: 2,
            onTap: () => onTap!(tipo: 2),
          ),
        ),
        Positioned(
          top: verticalSize * 0.5,
          left: 0,
          right: -horizontalSIze * 0.2,
          child: ColorWidget(
            color: Colors.blue,
            text: 'adjectives'.tr,
            tipo: 4,
            onTap: () => onTap!(tipo: 4),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: verticalSize * 0.6,
          child: ColorWidget(
            color: Colors.black,
            text: 'miscellaneous'.tr,
            tipo: 6,
            onTap: () => onTap!(tipo: 6),
          ),
        ),
      ],
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.tipo,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final String text;
  final int tipo;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: width * 0.04,
            width: width * 0.04,
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
