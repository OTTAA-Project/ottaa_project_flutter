import 'package:flutter/material.dart';

class CenterButtonWidget extends StatelessWidget {
  const CenterButtonWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.color,
    required this.onTap,
  }) : super(key: key);
  final double verticalSize;
  final double horizontalSize;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(verticalSize * 0.015),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            verticalSize * 0.3,
          ),
          border: Border.all(color: Colors.black, width: verticalSize * 0.014),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(verticalSize * 0.01),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(verticalSize * 0.15),
            border: Border.all(color: Colors.white, width: verticalSize * 0.014),
          ),
          child: Icon(
            Icons.play_arrow,
            size: verticalSize * 0.1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
