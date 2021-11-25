import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
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
        bottom: verticalSize * 0.10,
        child: Container(
          width: horizontalSize * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepButton(
                text: "Previous".tr,
                leading: Icons.chevron_left,
                onTap: () => _.authController.handleSignOut(),
                backgroundColor: Colors.grey,
                fontColor: Colors.white,
              ),
              StepButton(
                text: "Next".tr,
                trailing: Icons.chevron_right,
                onTap: () async {
                  if (_.name.value == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Add a name'),
                      ),
                    );
                  } else if (_.dateOfBirthInMs.value == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please choose a date of birth'),
                      ),
                    );
                  } else if (_.gender.value == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please choose a gender'),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await _.uploadInfo();
                    print('hi');
                    await _.setPref();
                    Get.back();
                    controller.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
                backgroundColor: kOTTAOrange,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        top: verticalSize * 0.012,
        child: FadeInUp(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: horizontalSize * 0.35,
                  height: verticalSize * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
                      Text("Thank_you_for_choosing_ottaa_project".tr),
                      Form(
                        key: _.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _.nameController,
                              onChanged: (value) {
                                _.name.value = value;
                              },
                              decoration: InputDecoration(hintText: "Name".tr),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_some_text'.tr;
                                }
                                return null;
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                final initialDate = DateTime.now();
                                final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1950),
                                  lastDate: initialDate,
                                  initialDate: initialDate,
                                );
                                _.dateOfBirthInMs.value =
                                    date!.millisecondsSinceEpoch;
                                print(_.dateOfBirthInMs.value);
                                final dates = date.toString();
                                _.birthDateController.text =
                                    dates.replaceRange(10, 23, '');
                              },
                              child: TextFormField(
                                controller: _.birthDateController,
                                keyboardType: TextInputType.number,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText: "Date_of_birth".tr),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(content: _dialogWidget()),
                                );
                                print('yes');
                              },
                              child: TextFormField(
                                controller: _.genderController,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: "Gender".tr),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: verticalSize * 0.045,
        left: horizontalSize * 0.025,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: horizontalSize * 0.45,
              child: FittedBox(
                child: Text(
                  'Lets_get_to_knwo_each_other_first'.tr + '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: horizontalSize * 0.45,
              child: AutoSizeText(
                'We_are_going_to_collect_some_data_to_get_to_know_you_better'
                    .tr,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _dialogWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _textWidget(text: 'Male'.tr),
      _textWidget(text: 'Female'.tr),
      _textWidget(text: 'Binary'.tr),
      _textWidget(text: 'Fluid'.tr),
      _textWidget(text: 'Other'.tr),
    ],
  );
}

final _controller = Get.find<OnboardingController>();

Widget _textWidget({required String text}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          _controller.gender.value = text;
          _controller.genderController.text = text;
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(text),
        ),
      ),
      Divider(),
    ],
  );
}
