import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/shared_pref_client.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';
final _sharedPrefClient = SharedPrefClient();
Widget step3Onboarding<widget>(
    OnboardingController _, PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      FadeInLeft(
        child: HeaderWave(
          color: kOTTAOrangeNew,
          bgColor: kOTTABackgroundNew,
        ),
      ),
      Positioned(
        bottom: 0,
        left: horizontalSize * 0.05,
        child: JelloIn(
          child: SvgPicture.asset(
            'assets/Group 706.svg',
            width: horizontalSize * 0.3,
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.03,
        top: verticalSize * 0.03,
        child: FadeInUp(
          child: Center(
            child: Container(
              width: horizontalSize * 0.45,
              height: verticalSize,
              // decoration: BoxDecoration(
              //     color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Choose_your_avatar".tr),
                    Container(
                      height: verticalSize * 0.2,
                      width: horizontalSize * 0.16,
                      // color: Colors.black,
                      child: Stack(
                        children: [
                          Center(
                            child: Obx(
                              () => Image.asset(
                                'assets/profiles/Group ${_.imageNumber.value}@2x.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 0,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: kOTTAOrangeNew,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: verticalSize * 0.05),
                      mainAxisSpacing: verticalSize * 0.02,
                      children: [
                        ImageWidget(imageNumber: 615),
                        ImageWidget(imageNumber: 617),
                        ImageWidget(imageNumber: 639),
                        ImageWidget(imageNumber: 663),
                        ImageWidget(imageNumber: 664),
                        ImageWidget(imageNumber: 665),
                        ImageWidget(imageNumber: 666),
                        ImageWidget(imageNumber: 667),
                        ImageWidget(imageNumber: 668),
                        ImageWidget(imageNumber: 669),
                        ImageWidget(imageNumber: 670),
                        ImageWidget(imageNumber: 674),
                        ImageWidget(imageNumber: 672),
                        ImageWidget(imageNumber: 673),
                        ImageWidget(imageNumber: 671),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: verticalSize * 0.02),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: StepButton(
                              text: "Previous".tr,
                              // leading: Icons.chevron_left,
                              onTap: () {
                                _.pageNumber.value = 1;
                                controller.animateToPage(_.pageNumber.value,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                              backgroundColor: kQuantumGrey,
                              fontColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: horizontalSize * 0.06,
                          ),
                          Expanded(
                            child: StepButton(
                              text: "Next".tr,
                              // trailing: Icons.chevron_right,
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                                await _.uploadAvatar(
                                    photoNumber: _.imageNumber.value);
                                await _sharedPrefClient.setPhotoPref();
                                Get.offAllNamed(AppRoutes.HOME);
                              },
                              backgroundColor: kOTTAOrangeNew,
                              fontColor: Colors.white,
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
        ),
      ),
      Positioned(
        top: verticalSize * 0.045,
        left: horizontalSize * 0.025,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'por_ltimo'.tr}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: verticalSize * 0.01,
            ),
            Text(
              '${'elige_un_personaje_que_nmejor_te_represente'.tr}!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class ImageWidget extends StatelessWidget {
  ImageWidget({Key? key, required this.imageNumber}) : super(key: key);
  final int imageNumber;
  final _controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.imageNumber.value = imageNumber,
      child: Image.asset(
        'assets/profiles/Group $imageNumber@2x.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
