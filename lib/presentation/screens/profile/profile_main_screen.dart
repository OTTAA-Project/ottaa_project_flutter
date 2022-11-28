import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo: add the theme here
      backgroundColor: kOTTAABackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    // padding: const EdgeInsets.all(4),
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImages.kAnimales,
                          fit: BoxFit.contain,
                          // height: 90,
                          // width: 90,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Hola victoria!',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
