import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class LeftSidePaidVersion extends StatelessWidget {
  const LeftSidePaidVersion({
    Key? key,
    required this.text,
    required this.iconAddress,
  }) : super(key: key);

  final String text;
  final IconData iconAddress;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(verticalSize * 0.01),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Icon(
                iconAddress,
                color: kOTTAAOrangeNew,
                size: verticalSize * 0.5,
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
