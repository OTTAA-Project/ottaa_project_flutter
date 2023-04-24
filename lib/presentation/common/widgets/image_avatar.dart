import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  final int imageId;
  final void Function(int) onTap;
  const ImageAvatar({Key? key, required this.imageId, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(imageId),
      child: Image.asset(
        'assets/profiles/Group $imageId@2x.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
