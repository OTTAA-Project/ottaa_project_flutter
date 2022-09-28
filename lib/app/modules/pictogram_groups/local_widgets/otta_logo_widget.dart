import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class OttaaLogoWidget extends StatelessWidget {
  const OttaaLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        // color: Colors.black,
        borderRadius: BorderRadius.circular(width * 0.07),
        border: Border.all(color: Colors.black,width: width * 0.008)
      ),
      // padding: EdgeInsets.all(width * 0.010),
      child: Container(
        // height: width * 0.1,
        // width: width * 0.1,
        padding: EdgeInsets.all(width * 0.02),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: kOTTAAOrangeNew,
          borderRadius: BorderRadius.circular(width * 0.4),
        ),
        child: Image.asset(
          'assets/icono_ottaa.png',
          fit: BoxFit.fill,
          // height: width * 0.08,
          // width: width * 0.04,
        ),
      ),
    );
  }
}
