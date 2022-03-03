import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class OttaLogoWidget extends StatelessWidget {
  const OttaLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(width * 0.07),
      ),
      padding: EdgeInsets.all(width * 0.010),
      child: Container(
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: kOTTAOrangeNew,
          borderRadius: BorderRadius.circular(width * 0.2),
        ),
        child: Image.asset(
          'assets/icono_ottaa.png',
          fit: BoxFit.cover,
          // height: width * 0.2,
          // width: width * 0.2,
        ),
      ),
    );
  }
}
