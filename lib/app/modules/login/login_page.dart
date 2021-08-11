import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<LoginController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.grey.shade400,
            body: Center(
                child: Stack(
              children: [
                FadeInUp(child: HeaderWave(color: kOTTAOrange)),
                FadeInUp(
                  child: Center(
                      child: Container(
                          width: horizontalSize * 0.6,
                          height: verticalSize * 0.65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image(
                                  image: AssetImage(
                                      'assets/imgs/logo_ottaa.webp')),
                              Column(
                                children: [
                                  Text("Hola!"),
                                  Text("Por Favor Registrarse para"),
                                  Text("Continuar"),
                                  // Text("hello".tr)
                                ],
                              ),
                              JelloIn(
                                child: SignInButton(
                                  Buttons.GoogleDark,
                                  text: "Acceder con Google",
                                  onPressed: () => _.authController
                                      .handleSignIn(SignInType.GOOGLE),
                                ),
                              ),
                              JelloIn(
                                child: SignInButton(
                                  Buttons.Facebook,
                                  text: "Acceder con Facebook",
                                  onPressed: () => _.authController
                                      .handleSignIn(SignInType.FACEBOOK),
                                ),
                              ),
                            ],
                          ))),
                ),
                Positioned(
                    bottom: verticalSize * 0.045,
                    left: horizontalSize * 0.05,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bienvenidos, esto es OTTAA',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),
                        Text(
                            'Ayudamos a miles de niños con problemas de habla a comunicarse, mejorando su calidad de vida',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ))
              ],
            ))));
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
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width, size.height * 0.85);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
