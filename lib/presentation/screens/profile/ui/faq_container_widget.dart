import 'package:flutter/material.dart';

class FaqContainerWidget extends StatelessWidget {
  const FaqContainerWidget({
    Key? key,
    required this.selected,
  }) : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    //todo: add the theme here
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: selected
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "como armo un pictograma?",
                ),
                selected
                    ? Icon(
                        Icons.close,
                      )
                    : Icon(
                        Icons.add,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
