import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class LeftColumnWidget extends StatelessWidget {
  const LeftColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;

    return Container(
      height: height * 0.5,
      width: width * 0.10,
      decoration: const BoxDecoration(
        color: kOTTAAOrangeNew,
        borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
      ),
    );
  }
}
