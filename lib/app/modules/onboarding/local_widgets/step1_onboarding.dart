import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';

step1Onboarding<widget>(
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
            'assets/3 people.svg',
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
                      Text("Gracias por elegir OTTAA PROJECT"),
                      Form(
                        key: _.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _.nameController,
                              decoration: InputDecoration(hintText: "Nombre"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _.genderController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "Genero"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      Text("Fecha de Nacimiento"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => _.authController.signOut(),
                            iconSize: 150,
                            icon: SvgPicture.asset(
                              'assets/Group 731.svg',
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.animateToPage(1,
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
              Text('Bienvenidos, esto es OTTAA',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              Text(
                  'Ayudamos a miles de niños con problemas de habla a comunicarse, mejorando su calidad de vida',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ))
    ],
  );
}
