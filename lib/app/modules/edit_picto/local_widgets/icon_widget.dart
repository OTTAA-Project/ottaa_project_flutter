import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: width * 0.10,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
