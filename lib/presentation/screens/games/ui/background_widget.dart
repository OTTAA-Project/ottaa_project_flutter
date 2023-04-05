import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        AppImages.kGameBackgroundIcon,
        height: 150,
        width: 150,
      ),
    );
  }
}
