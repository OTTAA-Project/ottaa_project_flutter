import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/shared_pref_client.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';

final _sharedPrefCient = SharedPrefClient();

Widget step1Onboarding<widget>(
    OnboardingController _, PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      FadeInLeft(
          child: HeaderWave(
        color: kOTTAAOrangeNew,
        bgColor: kOTTAABackgroundNew,
      )),
      Positioned(
        bottom: 0,
        left: horizontalSize * 0.05,
        child: JelloIn(
          child: SvgPicture.asset(
            'assets/3 people.svg',
            width: horizontalSize * 0.4,
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        top: verticalSize * 0.05,
        child: FadeInUp(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(verticalSize * 0.02),
                  ),
                  width: horizontalSize * 0.35,
                  height: verticalSize * 0.73,
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/imgs/logo_ottaa.webp'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: verticalSize * 0.05),
                          child: Text(
                            "check_if_the_info_is_correct_nif_not_change_it_as_you_wish_this_will_help_us_to_personalize_the_app_for_you"
                                .tr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Form(
                          key: _.formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${"Name".tr}: ',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _.nameController,
                                      onChanged: (value) {
                                        _.name.value = value;
                                      },
                                      decoration: InputDecoration(
                                        focusColor: kOTTAAOrangeNew,
                                        fillColor: kOTTAAOrangeNew,
                                        hintText: "Name".tr,
                                        contentPadding: const EdgeInsets.all(0),
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kOTTAAOrangeNew),
                                        ),
                                      ),
                                      cursorColor: kOTTAAOrangeNew,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_some_text'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalSize * 0.02),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog(content: _dialogWidget()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        '${"Gender".tr}: ',
                                        style:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _.genderController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            focusColor: kOTTAAOrangeNew,
                                            border: InputBorder.none,
                                          ),
                                          enabled: false,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey[600],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final initialDate = DateTime.now();
                                  final date = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: kOTTAAOrangeNew,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    firstDate: DateTime(1950),
                                    lastDate: initialDate,
                                    initialDate: initialDate,
                                  );
                                  _.dateOfBirthInMs.value =
                                      date!.millisecondsSinceEpoch;
                                  print(_.dateOfBirthInMs.value);
                                  _.birthDateController.text =
                                      '${date.day}/${date.month}/${date.year}';
                                  // dates.replaceRange(10, 23, '');
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      '${'Date_of_birth'.tr}:',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _.birthDateController,
                                        keyboardType: TextInputType.number,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            hintText: "Date_of_birth".tr),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Icon(
                                      Icons.insert_invitation,
                                      color: kOTTAAOrangeNew,
                                    ),
                                    const SizedBox(
                                      width: 16,
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
              ],
            ),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        bottom: verticalSize * 0.05,
        child: Container(
          width: horizontalSize * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepButton(
                text: "Previous".tr,
                // leading: Icons.chevron_left,
                onTap: () => _.authController.handleSignOut(),
                backgroundColor: kQuantumGrey,
                fontColor: Colors.white,
              ),
              StepButton(
                text: "Next".tr,
                // trailing: Icons.chevron_right,
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
                    final male = 'Male'.tr;
                    final female = 'Female'.tr;
                    final binary = 'Binary'.tr;
                    final fluid = 'Fluid'.tr;
                    final other = 'Other'.tr;
                    if (male.toString().toLowerCase() ==
                        _.gender.value.toString().toLowerCase()) {
                      //todo : add here for male
                      await _.uploadDataForSelectedGender(maleOrFemale: true);
                    } else if (female.toString().toLowerCase() ==
                        _.gender.value.toString().toLowerCase()) {
                      //todo : add here for female
                      await _.uploadDataForSelectedGender(maleOrFemale: false);
                    } else if (binary.toString().toLowerCase() ==
                        _.gender.value.toString().toLowerCase()) {
                      //todo : add here for binary
                    } else if (fluid.toString().toLowerCase() ==
                        _.gender.value.toString().toLowerCase()) {
                      //todo : add here for fluid
                    } else if (other.toString().toLowerCase() ==
                        _.gender.value.toString().toLowerCase()) {
                      //todo : add here for other
                    }
                    await _.uploadInfo();
                    await _sharedPrefCient.setFirstTimePref();
                    Get.back();
                    controller.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                  // _.pageNumber.value = 1;
                  // controller.animateToPage(_.pageNumber.value,
                  //     duration: Duration(milliseconds: 300),
                  //     curve: Curves.easeInOut);
                },
                backgroundColor: kOTTAAOrangeNew,
                fontColor: Colors.white,
              ),
            ],
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
                  'hola_nnos_conozcamos_un_poco'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: verticalSize * 0.02,
            ),
            Container(
              width: horizontalSize * 0.45,
              child: AutoSizeText(
                'vamos_a_pedirte_cierta_informaci_n_para_nmejorar_tu_experiencia_con_ottaa'
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
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _textWidget(text: 'Male'.tr),
        _textWidget(text: 'Female'.tr),
        _textWidget(text: 'Binary'.tr),
        _textWidget(text: 'Fluid'.tr),
        _textWidget(text: 'Other'.tr),
      ],
    ),
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
