import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_widgets/step1_tutorial.dart';
import 'local_widgets/step2_tutorial.dart';
import 'local_widgets/step3_tutorial.dart';
import 'local_widgets/step4_tutorial.dart';
import 'tutorial_controller.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return GetBuilder<TutorialController>(
        id: "tutorial",
        builder: (_) {
          return Scaffold(
            body: SafeArea(
                child: PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                step1Tutorial(controller, context),
                step2Tutorial(controller, context),
                step3Tutorial(controller, context),
                step4Tutorial(controller, context),
              ],
            )),
          );
        });
  }
}
