import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ProfileChooserButtonWidget extends StatelessWidget {
  const ProfileChooserButtonWidget({
    Key? key,
    required this.heading,
    required this.imagePath,
    required this.onTap,
    required this.selected,
    required this.subtitle,
  }) : super(key: key);
  final String heading, subtitle, imagePath;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: selected ? Border.all(
            color: kOTTAAOrangeNew,
            width: 3,
          ) : const Border(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: add the theme here
                  Text(
                    heading,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              imagePath,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
