import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/image_widget.dart';

class GrupoWidget extends StatelessWidget {
  const GrupoWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.color,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);
  final Color color;
  final double verticalSize;
  final double horizontalSize;
  final String imageUrl, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Container(
          height: verticalSize,
          width: horizontalSize * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(verticalSize * 0.02),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: ImageWidget(imageUrl: imageUrl),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: verticalSize * 0.023
                    ),),
                    Container(
                      height: 5,
                      width: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
