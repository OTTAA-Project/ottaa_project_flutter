import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'icon_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.name,required this.imageName}) : super(key: key);
  final String name;
  final String imageName;

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
          Image.asset('assets/imgs/$imageName.webp',height: 100,fit: BoxFit.fill,width: double.infinity,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            //filler for the text
            child: Text(
              name,
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
