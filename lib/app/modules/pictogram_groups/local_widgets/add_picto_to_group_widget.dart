import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

final Map<int, Color> groupColor = {
  1: Colors.yellow,
  2: kOTTAAOrangeNew,
  3: Colors.green,
  4: Colors.blue,
  5: Colors.purple,
  6: Colors.black,
};

class AddPictoToGroupWidget extends StatelessWidget {
  const AddPictoToGroupWidget({
    Key? key,
    required this.color,
    required this.image,
    required this.name,
    required this.isSelected,
  }) : super(key: key);
  final int color;
  final String image;
  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(horizontalSize * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(verticalSize * 0.03),
        border: isSelected ? Border.all(
          color: Colors.blue,
          width: 4,
        ) : Border.all(),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.pink,
                borderRadius: BorderRadius.circular(verticalSize * 0.02),
                border: Border.all(color: groupColor[color]!, width: 4),
              ),
              child: kIsWeb
                  ? Image.network(image)
                  : CachedNetworkImage(
                      imageUrl: image,
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                    fontSize: verticalSize * 0.02, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
