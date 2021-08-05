import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'configuration_controller.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<ConfigurationController>(
        builder: (_) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SignInButton(
                    Buttons.GoogleDark,
                    text: "Salir de OTTAA",
                    onPressed: () => _.authController.handleSignOut(),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "LANGUAJE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Switch(
                      activeColor: kOTTAOrange,
                      value: _.ttsController.isEnglish,
                      onChanged: (bool value) {
                        _.toggleLanguaje(value);
                      }),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "PITCH",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Slider(
                    activeColor: kOTTAOrange,
                    value: _.ttsController.pitch,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: _.ttsController.pitch.toString(),
                    onChanged: (double value) {
                      _.setPitch(value);
                    },
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "RATE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Slider(
                    activeColor: kOTTAOrange,
                    value: _.ttsController.rate,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: _.ttsController.rate.toString(),
                    onChanged: (double value) {
                      _.setRate(value);
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    height: verticalSize * 0.2,
                    width: horizontalSize,
                    color: kOTTAOrange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // FittedBox(
                        //   child: GestureDetector(
                        //     onTap: null,
                        //     child: Center(
                        //         child: Icon(
                        //       Icons.arrow_back_ios,
                        //       color: Colors.white,
                        //       size: horizontalSize / 10,
                        //     )),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: GestureDetector(
                        //     onTap: null,
                        //     child: Center(
                        //         child: Icon(
                        //       Icons.surround_sound_rounded,
                        //       color: Colors.white,
                        //       size: horizontalSize / 10,
                        //     )),
                        //   ),
                        // ),
                        FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              Get.offNamed(AppRoutes.HOME);
                            },
                            child: Center(
                                child: Icon(
                              Icons.home,
                              color: Colors.white,
                              size: horizontalSize / 10,
                            )),
                          ),
                        ),
                        // FittedBox(
                        //   child: GestureDetector(
                        //     onTap: null,
                        //     child: Center(
                        //         child: Icon(
                        //       Icons.arrow_forward_ios,
                        //       color: Colors.white,
                        //       size: horizontalSize / 10,
                        //     )),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.black87,
            ));
  }
}
