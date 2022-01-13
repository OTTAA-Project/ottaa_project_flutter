import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'icon_widget.dart';

final Map<int, Color> groupColor = {
  1: Colors.yellow,
  2: kOTTAOrange,
  3: Colors.green,
  4: Colors.blue,
  5: Colors.purple,
  6: Colors.black,
};

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.name,
    required this.imageName,
    this.border = false,
    this.bottom = true,
    this.color = 0,
    this.languaje = '',
  }) : super(key: key);
  final String name;
  final String imageName;
  final bool border;
  final int color;
  final bool bottom;
  final String languaje;

  @override
  Widget build(BuildContext context) {
    // String text;
    //
    // switch (this.languaje) {
    //   case "es-US":
    //     text = texto.es;
    //     break;
    //   case "en-US":
    //     text = texto.en;
    //     break;
    //
    //   default:
    //     text = texto.es;
    // }
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: border
                      ? Border.all(
                          color: groupColor[color]!,
                          width: 6,
                        )
                      : Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: imageName,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                fit: BoxFit.fill,
              ),
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
