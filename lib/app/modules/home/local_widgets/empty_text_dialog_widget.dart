import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyTextDialogWidget extends StatelessWidget {
  const EmptyTextDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(
                verticalSize * 0.08,
              ),
            ),
            padding: EdgeInsets.all(verticalSize * 0.02),
            child: Row(
              children: [
                Image.asset(
                  'assets/Group 671.png',
                  height: verticalSize * 0.15,
                ),
                SizedBox(
                  width: verticalSize * 0.03,
                ),
                Text(
                  'share_text'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: verticalSize * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
