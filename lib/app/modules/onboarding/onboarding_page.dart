import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

import 'onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<OnboardingController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.grey.shade400,
            body: Stack(
              children: [
                FadeInLeft(child: HeaderWave(color: Colors.orange)),
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
                // FadeInUp(
                //   child: Center(
                //       child: Container(
                //           width: horizontalSize * 0.6,
                //           height: verticalSize * 0.65,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(10)),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                //             children: [
                //               Image(
                //                   image: AssetImage(
                //                       'assets/imgs/logo_ottaa.webp')),
                //               Column(
                //                 children: [
                //                   Text("Hola!"),
                //                   Text("Por Favor Registrarse para"),
                //                   Text("Continuar")
                //                 ],
                //               ),
                //               JelloIn(
                //                 child: SignInButton(
                //                   Buttons.GoogleDark,
                //                   text: "Acceder con Google",
                //                   onPressed: () => _.authController.signIn(),
                //                 ),
                //               ),
                //             ],
                //           ))),
                // ),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        IconButton(
                          onPressed: () => Get.toNamed(AppRoutes.TUTORIAL),
                          iconSize: 150,
                          icon: SvgPicture.asset(
                            'assets/Group 732.svg',
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }
}

class HeaderWave extends StatelessWidget {
  final Color color;

  const HeaderWave({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(this.color),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  final Color color;

  _HeaderWavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = this.color; //Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    // path.moveTo(0, size.height);
    // path.lineTo(0, size.height * 0.8);
    // path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
    //     size.width * 0.5, size.height * 0.85);
    // path.quadraticBezierTo(
    //     size.width * 0.75, size.height * 0.9, size.width, size.height * 0.85);
    // path.lineTo(size.width, size.height);

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.3,
        size.width * 0.45, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.4, size.height * 0.75, size.width * 0.45, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
