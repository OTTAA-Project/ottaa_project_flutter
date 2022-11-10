import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/ottaa_wave.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';

class TutorialStep extends ConsumerStatefulWidget {
  const TutorialStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoStepState();
}

class _UserInfoStepState extends ConsumerState<TutorialStep> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    final provider = ref.watch(onBoardingProvider);

    final loading = ref.watch(loadingProvider);

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FadeInLeft(
              child: const OTTAAWave(
                color: kOTTAAOrangeNew,
                bgColor: kOTTAABackgroundNew,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.05,
            child: JelloIn(
              child: Image.asset(
                AppImages.kWheelChairGirl,
                width: width * 0.35,
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            height: height,
            child: Align(
              alignment: Alignment.center,
              child: FadeInUp(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    width: width * 0.35,
                    height: height * 0.73,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(AppImages.kLogoOttaa),
                          ),
                          const SizedBox(height: 20),
                          SimpleButton(
                            width: false,
                            fontColor: Colors.white,
                            backgroundColor: Colors.grey,
                            // color: kOTTAAOrange,
                            // disabledColor: kQuantumGrey,
                            onTap: () {}, //TODO: Context go to tutorial screen
                            text: "Launch_short_tutorial".trl,
                            // shape: GFButtonShape.pills,
                            // size: verticalSize * 0.07,
                            // blockButton: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: width * 0.05),
                            child: SimpleButton(
                              width: false,
                              fontColor: Colors.white,
                              backgroundColor: Colors.grey,
                              // color: kOTTAAOrange,
                              // disabledColor: kQuantumGrey,
                              onTap: () {},
                              text: "Do_a_guided_workshop".trl,
                              // shape: GFButtonShape.pills,
                              // size: verticalSize * 0.07,
                              // blockButton: true,
                            ),
                          ),
                          SimpleButton(
                            width: false,
                            fontColor: Colors.white,
                            backgroundColor: Colors.grey,
                            onTap: () {},
                            text: "Book_a_demo".trl,
                            // color: kOTTAAOrange,
                            // disabledColor: kQuantumGrey,

                            // shape: GFButtonShape.pills,
                            // size: verticalSize * 0.07,
                            // blockButton: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            bottom: height * 0.05,
            child: SizedBox(
              width: width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleButton(
                    text: "Previous".trl,
                    // leading: Icons.chevron_left,
                    onTap: () {
                      provider.previousPage();
                    },
                    backgroundColor: kQuantumGrey,
                    fontColor: Colors.white,
                  ),
                  SimpleButton(
                    text: "Next".trl,
                    // trailing: Icons.chevron_right,
                    onTap: () async {
                      provider.nextPage();
                    },
                    backgroundColor: kOTTAAOrangeNew,
                    fontColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: width * 0.045,
            left: height * 0.025,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.45,
                  child: FittedBox(
                    child: Text(
                      'Ottaa_is_a_powerful_communication_tool'.trl,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                SizedBox(
                  width: height * 0.45,
                  child: Text(
                    'te_ofrecemos_varias_opciones_para_naprender_a_utilizarla_y_sacarle_el_maximo_provecho'.trl,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
