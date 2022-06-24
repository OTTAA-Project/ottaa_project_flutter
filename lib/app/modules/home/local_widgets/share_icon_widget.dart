import 'package:flutter/material.dart';

class ShareIconWidget extends StatelessWidget {
  const ShareIconWidget({
    Key? key,
    required this.verticalSize,
    required this.color,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final double verticalSize;
  final Color color;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: color,
            size: verticalSize * 0.2,
          ),
          SizedBox(
            height: verticalSize * 0.02,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: verticalSize * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
