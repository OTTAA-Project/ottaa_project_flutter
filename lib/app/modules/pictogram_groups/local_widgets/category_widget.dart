import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'icon_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.name,
    required this.imageName,
    this.border = false,
    this.bottom = true,
    this.color = 0,
  }) : super(key: key);
  final String name;
  final String imageName;
  final bool border;
  final int color;
  final bool bottom;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          //placeholder for the photos
          Container(
            decoration: BoxDecoration(
                border: border
                    ? Border.all(
                        color: color == 1
                            ? Yellow
                            : color == 2
                                ? Orange
                                : color == 3
                                    ? YellowGreen
                                    : color == 4
                                        ? DodgerBlue
                                        : color == 5
                                            ? Magenta
                                            : color == 6
                                                ? Black
                                                : Black,
                        width: 6,
                      )
                    : Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              'assets/imgs/$imageName.webp',
              height: 100,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            //filler for the text
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          bottom
              ? Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      IconWidget(icon: Icons.timer_off),
                      IconWidget(icon: Icons.location_off),
                      IconWidget(icon: Icons.face),
                      IconWidget(icon: Icons.wc),
                    ],
                  ),
              )
              : Container(),
        ],
      ),
    );
  }
}
