import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/about/about_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class AboutOttaaPage extends GetView<AboutController> {
  const AboutOttaaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 4,
              // child: HeaderWave(
              //   color: kOTTAAOrangeNew,
              //   height: horizontalSize,
              //   width: verticalSize,
              // ),
              child: HeaderWave(
                color: Colors.white,
                bgColor: kOTTAAOrangeNew,
              ),
            ),
            Positioned(
              top: verticalSize * 0.2,
              right: horizontalSize * 0.03,
              child: Text(
                'keep_your_ottaa_up_to_date'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Noto Sans",
                  fontSize: verticalSize * 0.03,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              top: verticalSize * 0.3,
              right: horizontalSize * 0.1,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: verticalSize * 0.01,
                    horizontal: horizontalSize * 0.02),
                height: verticalSize * 0.4,
                width: horizontalSize * 0.4,
                decoration: BoxDecoration(
                  color: kOTTAAOrangeNew,
                  borderRadius: BorderRadius.circular(verticalSize * 0.03),
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'account_info'.tr,
                          style: TextStyle(
                              fontFamily: "Noto Sans",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: verticalSize * 0.03),
                        ),
                      ),
                      LineWidget(
                        text: controller.userEmail.value,
                        heading: 'account'.tr,
                      ),
                      LineWidget(
                        text: controller.userSubscription.value,
                        heading: 'account_type'.tr,
                      ),
                      LineWidget(
                        text: controller.currentOTTAAInstalled.value.toString(),
                        heading: 'current_ottaa_installed'.tr,
                      ),
                      LineWidget(
                        text: controller.currentOTTAAVersion.value.toString(),
                        heading: 'current_ottaa_version'.tr,
                      ),
                      LineWidget(
                        text: controller.deviceName.value,
                        heading: 'device_name'.tr,
                      ),
                      SizedBox(
                        height: verticalSize * 0.005,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: verticalSize * 0.1,
              right: horizontalSize * 0.1,
              child: GestureDetector(
                onTap: () async {
                  await controller.launchEmailSubmission();
                },
                child: Container(
                  height: verticalSize * 0.06,
                  width: horizontalSize * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(verticalSize * 0.025),
                  ),
                  child: Center(
                    child: Text(
                      'Contact Support',
                      style: TextStyle(
                        color: kOTTAAOrangeNew,
                        fontFamily: "Noto Sans",
                        fontSize: verticalSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: verticalSize * 0.03,
              left: horizontalSize * 0.04,
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  'assets/ic_mancha_gris.PNG',
                  height: verticalSize * 0.5,
                ),
              ),
            ),
            Positioned(
              left: horizontalSize * 0.01,
              top: verticalSize * 0.01,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
    required this.text,
    required this.heading,
  }) : super(key: key);
  final String heading;
  final String text;

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$heading:",
          style: TextStyle(
            fontFamily: "Noto Sans",
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: verticalSize * 0.021,
          ),
        ),
        SizedBox(
          width: horizontalSize * 0.005,
        ),
        Text(
          text,
          style: TextStyle(
              fontFamily: "Noto Sans",
              color: Colors.white,
              fontSize: verticalSize * 0.021),
        ),
      ],
    );
  }
}

class HeaderWave extends StatelessWidget {
  final Color color;
  final Color bgColor;

  const HeaderWave({required this.color, this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
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
    path.lineTo(size.width * 0.4, 0);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.3,
        size.width * 0.35, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.75, size.width * 0.35, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
