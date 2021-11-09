import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'icon_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          //placeholder for the photos
          const Placeholder(
            fallbackHeight: 100,
            fallbackWidth: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            //filler for the text
            child: Text(
              'Filler Text $index',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              IconWidget(icon: Icons.timer_off),
              IconWidget(icon: Icons.location_off),
              IconWidget(icon: Icons.face),
              IconWidget(icon: Icons.wc),
            ],
          ),
        ],
      ),
    );
  }
}
