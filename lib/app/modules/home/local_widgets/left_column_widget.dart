import 'package:flutter/material.dart';

class LeftColumnWidget extends StatelessWidget {
  const LeftColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;

    return Container(
      height: verticalSize * 0.75,
      width: horizontalSize * 0.10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            child: GestureDetector(
              onTap: null,
              child: Center(
                  child: Icon(
                // Icons.gamepad,
                Icons.gamepad,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: null,
              child: Center(
                  child: Icon(
                Icons.image,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(horizontalSize / 40)),
      ),
    );
  }
}
