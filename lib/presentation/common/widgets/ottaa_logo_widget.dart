import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class OttaaLogoWidget extends StatelessWidget {
  const OttaaLogoWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: height * 0.045),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kOTTAAOrangeNew,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 4,
              ),
            ),
          ),
          onPressed: onTap,
          child: SizedBox(
            height: height * 0.16,
            width: height * 0.16,
            child: Center(
              child: Image.asset(
                AppImages.kIconoOttaa,
                color: Colors.white,
                height: height * 0.1,
                width: width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
