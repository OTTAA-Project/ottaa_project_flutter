import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialougeWidget extends StatelessWidget {
  const DialougeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalSize * 0.03,
        vertical: 8,
      ),
      child: Text(
        'we_are_working_on_this_feature'.tr,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
