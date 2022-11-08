import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/ui/sign_in_button.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
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
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: FadeInUp(
                child: const HeaderWave(color: kOTTAAOrangeNew),
              ),
            ),
            Positioned(
              bottom: verticalSize * 0.045,
              left: horizontalSize * 0.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome_this_is_ottaa'.trl,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'We_help_thousands_of_children_with_speech_problems_to_communicate_improving_their_quality_of_life'
                        .trl,
                    style: const TextStyle(
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
                  height: verticalSize * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (horizontalSize * 0.6) * 0.2),
                        child: Image.asset(
                          AppImages.kLogoOttaa,
                          height: verticalSize * 0.15,
                          width: horizontalSize * 0.3,
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
                              "login_screen".trl,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: verticalSize * 0.05,
                      ),
                      JelloIn(
                        child: SizedBox(
                          width: horizontalSize * 0.4,
                          child: SignInButton(
                            type: SignInType.google,
                            text: "Login_with_google".trl,
                            logo: AppImages.kGoogleIcon,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: verticalSize * 0.02,
                      ),
                      JelloIn(
                        child: SizedBox(
                          width: horizontalSize * 0.4,
                          child: SignInButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kFacebookColor,
                              fixedSize: const Size.fromHeight(50),
                            ),
                            type: SignInType.facebook,
                            text: "Login_with_facebook".trl,
                            logo: AppImages.kFacebookIcon,
                          ),
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
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.004),
          decoration: BoxDecoration(
            color: googleOrFacebook
                ? const Color(0xFF4285F4)
                : const Color(0xFF1877f2),
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/google_icon.ico',
                          height: verticalSize * 0.03,
                          width: horizontalSize * 0.02,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
              SizedBox(
                width: horizontalSize * 0.01,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWave extends StatelessWidget {
  final Color color;

  const HeaderWave({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Container(
      height: verticalSize,
      width: horizontalSize,
      clipBehavior: Clip.antiAlias,
      // color: Colors.black,
      decoration: const BoxDecoration(
          // color: Colors.black
          ),
      child: CustomPaint(
        painter: _HeaderWavePainter(color),
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
    lapiz.color = color; //Color(0xff615AAB);
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
