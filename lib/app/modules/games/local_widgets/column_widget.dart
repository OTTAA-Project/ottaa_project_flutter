import 'package:flutter/material.dart';

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    Key? key,
    required this.horizontalSize,
    required this.verticalSize,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final double verticalSize;
  final double horizontalSize;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              verticalSize * 0.03,
            ),
            topRight: Radius.circular(
              verticalSize * 0.03,
            ),
          ),
        ),
        height: verticalSize * 0.5,
        width: horizontalSize * 0.15,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: verticalSize * 0.1,
          ),
        ),
      ),
    );
  }
}
