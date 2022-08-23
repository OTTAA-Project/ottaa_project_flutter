import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class PictoMatchPictoBottomWidget extends StatelessWidget {
  const PictoMatchPictoBottomWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.onTap,
    required this.foundOrNot,
    required this.top,
    required this.left,
    required this.name,
  }) : super(key: key);
  final double verticalSize, horizontalSize, left, top;
  final String name;
  final void Function()? onTap;
  final bool foundOrNot;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(verticalSize * 0.02),
          splashColor: kOTTAAOrangeNew,
          onTap: foundOrNot ? onTap : null,
          child: Container(
            height: verticalSize * 0.4,
            width: horizontalSize * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(verticalSize * 0.02),
              // color: topOrBottom ? Colors.transparent : Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                      verticalSize * 0.01,
                      verticalSize * 0.01,
                      verticalSize * 0.01,
                      0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(verticalSize * 0.03),
                      border: Border.all(color: Colors.black, width: verticalSize * 0.01),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.help_outline,
                        color: kOTTAAOrangeNew,
                        size: verticalSize * 0.19,
                      ),
                    ),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: verticalSize * 0.042,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
