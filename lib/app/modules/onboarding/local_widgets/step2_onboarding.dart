import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';

step2Onboarding<widget>(
    OnboardingController _, PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      FadeInLeft(child: HeaderWave(color: kOTTAOrange)),
      Positioned(
        bottom: 0,
        left: horizontalSize * 0.05,
        child: JelloIn(
          child: SvgPicture.asset(
            'assets/wheelchair girl.svg',
            width: horizontalSize * 0.43,
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        top: verticalSize * 0.12,
        child: FadeInUp(
          child: Center(
              child: Container(
                  width: horizontalSize * 0.4,
                  height: verticalSize * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                              onPressed: null,
                              child: Text('LAUNCH SHORT TUTORIAL')),
                          ElevatedButton(
                              onPressed: null,
                              child: Text('DO A GUIDED WORKSHOP')),
                          ElevatedButton(
                              onPressed: null, child: Text('BOOK A DEMO')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => controller.animateToPage(0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut),
                            iconSize: 150,
                            icon: SvgPicture.asset(
                              'assets/Group 731.svg',
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.animateToPage(2,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut),
                            iconSize: 150,
                            icon: SvgPicture.asset(
                              'assets/Group 732.svg',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))),
        ),
      ),
      Positioned(
          top: verticalSize * 0.045,
          left: horizontalSize * 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OTTAA es una poderosa herramienta de comunicación',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              Text(
                  'Te ofrecemos diferentes opciones para que aprendas a usarla y sques el mayor provecho',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ))
    ],
  );
}
