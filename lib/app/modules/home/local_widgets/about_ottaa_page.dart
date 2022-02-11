import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class AboutOttaaPage extends GetView<HomeController> {
  const AboutOttaaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: verticalSize * 0.2,
              right: horizontalSize * 0.03,
              child: Text(
                'Keep your OTTAA up-to-date',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: verticalSize * 0.3,
              right: horizontalSize * 0.1,
              child: Container(
                height: verticalSize * 0.4,
                width: horizontalSize * 0.4,
                decoration: BoxDecoration(
                  color: kOTTAOrangeNew,
                  borderRadius: BorderRadius.circular(verticalSize * 0.03),
                  border: Border.all(
                    color: Colors.white,
                    width: 8,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Account Info',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
