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
        backgroundColor: kOTTAABackgroundNew,
        body: Center(
          child: Stack(
            children: [
              FadeInUp(
                child: Center(
                  child: Container(
                    width: horizontalSize * 0.6,
                    height: verticalSize * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: Column(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: (horizontalSize * 0.6) * 0.2),
                    //       child: Image.asset(
                    //         'assets/imgs/logo_ottaa.webp',
                    //       ),
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text("${"Hello".tr}!"),
                    //         Text("Please_register_for".tr),
                    //         Text("Continue".tr),
                    //         Text("hello_world".tr)
                    //       ],
                    //     ),
                    //     JelloIn(
                    //       child: SignInButton(
                    //         Buttons.GoogleDark,
                    //         text: "Login_with_google".tr,
                    //         onPressed: () => _.authController.handleSignIn(
                    //           SignInType.GOOGLE,
                    //         ),
                    //         // onPressed: () => Get.offAllNamed(AppRoutes.ONBOARDING),
                    //       ),
                    //     ),
                    //     JelloIn(
                    //       child: SignInButton(
                    //         Buttons.Facebook,
                    //         text: "Login_with_facebook".tr,
                    //         onPressed: () => _.authController
                    //             .handleSignIn(SignInType.FACEBOOK),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: FadeInUp(
                  child: HeaderWave(color: kOTTAAOrangeNew),
                ),
              ),
              Positioned(
                bottom: verticalSize * 0.045,
                left: horizontalSize * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome_this_is_ottaa'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'We_help_thousands_of_children_with_speech_problems_to_communicate_improving_their_quality_of_life'
                          .tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                child: Center(
                  child: Container(
                    width: horizontalSize * 0.6,
                    height: verticalSize * 0.65,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: (horizontalSize * 0.6) * 0.2),
                          child: Image.asset(
                            'assets/imgs/logo_ottaa.webp',
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: verticalSize * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalSize * 0.05),
                              child: Text(
                                "${"login_screen".tr}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: verticalSize * 0.12,
                        ),
                        JelloIn(
                          child: LoginButton(
                            onTap: () => _.authController
                                .handleSignIn(SignInType.GOOGLE),
                            text: "Login_with_google".tr,
                            googleOrFacebook: true,
                            verticalSize: verticalSize,
                            horizontalSize: horizontalSize,
                          ),
                          // Container(
                          //   height: verticalSize * 0.04,
                          //   child: SignInButton(
                          //     Buttons.GoogleDark,
                          //     text: "Login_with_google".tr,
                          //     onPressed: () => _.authController.handleSignIn(
                          //       SignInType.GOOGLE,
                          //     ),
                          // onPressed: () => Get.offAllNamed(AppRoutes.HOME),
                        ),
                        SizedBox(
                          height: verticalSize * 0.02,
                        ),
                        JelloIn(
                          // child: Container(
                          //   height: verticalSize * 0.04,
                          //   child: SignInButton(
                          //     Buttons.Facebook,
                          //     text: "Login_with_facebook".tr,
                          //     onPressed: () => _.authController
                          //         .handleSignIn(SignInType.FACEBOOK),
                          //   ),
                          // ),
                          child: LoginButton(
                            onTap: () => _.authController
                                .handleSignIn(SignInType.FACEBOOK),
                            text: "Login_with_facebook".tr,
                            googleOrFacebook: false,
                            verticalSize: verticalSize,
                            horizontalSize: horizontalSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.googleOrFacebook,
    required this.verticalSize,
    required this.horizontalSize,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final bool googleOrFacebook;
  final double verticalSize, horizontalSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.004),
        decoration: BoxDecoration(
          color: googleOrFacebook ? Color(0xFF4285F4) : Color(0xFF1877f2),
        ),
        height: verticalSize * 0.039,
        width: horizontalSize * 0.173,
        child: Row(
          children: [
            googleOrFacebook
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: verticalSize * 0.005),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/google_icon.ico',
                        height: verticalSize * 0.03,
                        width: horizontalSize * 0.02,
                      ),
                    ),
                  )
                : Icon(
                    Icons.facebook,
                    color: Colors.white,
                  ),
            SizedBox(
              width: horizontalSize * 0.01,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWave extends StatelessWidget {
  final Color color;

  const HeaderWave({required this.color});

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Container(
      height: verticalSize,
      width: horizontalSize,
      clipBehavior: Clip.antiAlias,
      // color: Colors.black,
      decoration: BoxDecoration(
          // color: Colors.black
          ),
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
    final lapiz = Paint();

    // Propiedades
    lapiz.color = this.color; //Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.7,
        size.width * 0.4, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.65, size.height * 0.8, size.width, size.height * 0.75);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, lapiz);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
