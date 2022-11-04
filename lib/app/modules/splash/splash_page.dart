import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.deepOrange,
            ),
            SizedBox(height: 10),
            Text("we_are_preparing_everything".tr)
          ],
        ),
      ),
    );
  }
}
