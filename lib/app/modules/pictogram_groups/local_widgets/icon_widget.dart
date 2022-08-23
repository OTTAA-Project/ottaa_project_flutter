import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Icon(
      icon,
      size: verticalSize * 0.05,
      color: Colors.grey[200],
    );
  }
}
//TODO: WHY??