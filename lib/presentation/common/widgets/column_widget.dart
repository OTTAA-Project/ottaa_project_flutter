import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

enum ColumnType { left, right }

class ColumnWidget extends StatelessWidget {
  final List<Widget> children;
  final ColumnType columnType;

  const ColumnWidget({super.key, required this.children, required this.columnType});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;

    return Container(
      height: height * 0.5,
      width: width * 0.10,
      decoration: BoxDecoration(
        color: kOTTAAOrangeNew,
        borderRadius: BorderRadius.only(
          topRight: columnType == ColumnType.left ? const Radius.circular(16) : Radius.zero,
          topLeft: columnType == ColumnType.right ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
